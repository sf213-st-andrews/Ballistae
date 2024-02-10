// Ballista.pde
private static float magReduce = 0.1f;
class Ballista extends Particle implements Rectangle {
	// Graphics
	private static final float aimLength		= 512;
	private int halfRadius;

	// Attributes
	PVector area;
	private ArrayList<Bomb> bombs;
	ArrayList<Explosion> explosions;

	// Constructor
	Ballista(float x, float y, ArrayList<Bomb> bombs, ArrayList<Explosion> explosions) {
		super(x, y, 0, 0, 0);
		
		this.area = new PVector(40, 50);// could be private static
		this.halfRadius = (int) (area.x / 2);// could be private static

		this.bombs = bombs;
		this.explosions = explosions;
	}

	// Fire a bomb towards the mouse position
	void fireBomb() {
		bombs.add(new Bomb(super.position.x + halfRadius, super.position.y,
		(mouseX - (super.position.x + halfRadius)) * magReduce, (mouseY - super.position.y) * magReduce,
		explosions));
	}

	PVector getArea() {
		return area;
	}

	boolean collidesWith(Collidable other) {
		if (other instanceof Circle) {return collidesWithCircle((Circle) other);}
		else {return collidesWithRectangle((Rectangle) other);}
	}
	boolean collidesWithCircle(Circle otherCirlce) {
		// DOUBLE CHECK this, I made it without thinking it through
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
		// Ballista will never collide with another ballista
		return false;
	}

	void handleCollision(Collidable other) {
		// intact = false;
		return;// Haven't decided what to do about Meteor's (or Bombs even) colliding with Ballista
	}
	void handleCollisionCirlce(Circle otherCirlce) {return;}// If something collides, then it's dead.
	void handleCollisionRectangle(Rectangle otherRectangle) {return;}// If something collides, then it's dead.

	// Draw
	void draw() {
		// Calculate the direction from the ballista position to the mouse position
		PVector direction = new PVector(mouseX - super.position.x, mouseY - super.position.y);
		direction.normalize();

		stroke(255, 100, 100);
		strokeWeight(4);
		line(super.position.x + halfRadius, super.position.y,
		super.position.x + halfRadius + direction.x * aimLength, super.position.y + direction.y * aimLength);

		stroke(255, 255, 255);
		strokeWeight(1);
		line(super.position.x + halfRadius, super.position.y,
		super.position.x + halfRadius + direction.x * aimLength, super.position.y + direction.y * aimLength);
		
		// Reset stroke
		stroke(0, 0, 0);
		// strokeWeight(1);

		// Draw ballista
		fill(165, 42, 42);
		ellipse(super.position.x + halfRadius, super.position.y, area.x, area.x);
		// Draw tower
		fill(150);
		rect(super.position.x, super.position.y, area.x, area.y);
	}
}
