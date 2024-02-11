// Ballista.pde
private static final float 	magReduce		= 0.1f;
private static final float 	SPACING			= 20f;
private static final int 	MAX_AMMO		= 10;
private static final int 	BOMB_SCORE_VALUE= 5;

class Ballista extends Particle implements Rectangle,Scorable {
	// Graphics
	private int halfRadius;

	// Attributes
	PVector area;
	private int ammo;
	private Display ammoDisplay;
	private int hasFired;
	private ArrayList<Bomb> bombs;
	ArrayList<Explosion> explosions;

	// Constructor
	Ballista(float x, float y, ArrayList<Bomb> bombs, ArrayList<Explosion> explosions) {
		super(x, y, 0, 0, 0);
		
		this.area = new PVector(40, 50);// could be private static
		this.halfRadius = (int) (area.x / 2);// could be private static

		this.ammo = MAX_AMMO;
		this.ammoDisplay = new Display("" + ammo, super.position.x + halfRadius, super.position.y + halfRadius);
		this.hasFired = 0;

		this.bombs = bombs;
		this.explosions = explosions;

	}

	// Fire a bomb towards the mouse position
	void fireBomb() {
		if (ammo <= 0) {return;}
		bombs.add(new Bomb(super.position.x + halfRadius, super.position.y,
		(mouseX - (super.position.x + halfRadius)) * magReduce, (mouseY - super.position.y) * magReduce,
		explosions));
		ammo -= 1;
		hasFired = 16;
	}

	PVector getArea() {
		return area;
	}

	boolean collidesWith(Collidable other) {
		if (other instanceof Circle) {return collidesWithCircle((Circle) other);}
		else {return collidesWithRectangle((Rectangle) other);}
	}
	boolean collidesWithCircle(Circle otherCirlce) {
		if (otherCirlce instanceof Particle) {
			int otherRadius = otherCirlce.getRadius();
			
			Particle otherParticle	= (Particle) otherCirlce;
			PVector otherPosition	= otherParticle.position;
			
			float closestX = constrain(otherPosition.x, super.position.x, super.position.x + this.area.x);
			float closestY = constrain(otherPosition.y, super.position.y, super.position.y + this.area.y);
			float distance = dist(otherPosition.x, otherPosition.y, closestX, closestY);

			return (distance < otherRadius);// float int comparison problems?
		}
		System.out.println("BCWC Error: Not a Particle");// Remove?
		return false;
	}
	boolean collidesWithRectangle(Rectangle otherRectangle) {
		// Ballista will never collide with another ballista or city
		return false;
	}

	void handleCollision(Collidable other) {
		// intact = false;
		return;// Haven't decided what to do about Meteor's (or Bombs even) colliding with Ballista
	}
	void handleCollisionCirlce(Circle otherCirlce) {return;}// If something collides, then it's dead.
	void handleCollisionRectangle(Rectangle otherRectangle) {return;}// If something collides, then it's dead.

	void drawAim() {
		float distance = dist(mouseX, mouseY, super.position.x + halfRadius, super.position.y);
		float segmentLength = SPACING * 2;
		float segments = distance / segmentLength;

		float deltaX = (mouseX - super.position.x - halfRadius) / segments;
		float deltaY = (mouseY - super.position.y) / segments;

		for (int i = 0; i < segments; i +=2) {
			float xStart = super.position.x + halfRadius + i * deltaX;
    		float yStart = super.position.y + i * deltaY;
    		float xEnd = super.position.x + halfRadius + (i + 1) * deltaX;
    		float yEnd = super.position.y + (i + 1) * deltaY;

			stroke(255, 100, 100);
			strokeWeight(4);
			line(xStart, yStart, xEnd, yEnd);

			stroke(255, 255, 255);
			strokeWeight(1);// Resets strokeWeight
			line(xStart, yStart, xEnd, yEnd);
		}
		
		// Reset stroke
		stroke(0, 0, 0);
	}
	void drawBuilding() {
		// Draw ballista
		fill(16*hasFired, 4*hasFired, 0);
		if (hasFired > 0) {
			hasFired -= 1;
		}
		
		ellipse(super.position.x + halfRadius, super.position.y, area.x, area.x);
		// Draw tower
		fill(150);
		rect(super.position.x, super.position.y, area.x, area.y);

	}
	void displayAmmo() {
		ammoDisplay.updateText("" + ammo);
		ammoDisplay.draw(true);
	}

	public int getScore() {
		int score = ammo * BOMB_SCORE_VALUE;
		ammo = MAX_AMMO;// Reset the ammo when a wave is over and the score is called.
		return score;
	}

	// Draw
	void draw() {
		drawAim();
		drawBuilding();
		displayAmmo();
	}
}
