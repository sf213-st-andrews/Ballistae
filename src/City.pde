// City.pde

private static final int 	CITY_SCORE_VALUE = 100;

class City extends Particle implements Rectangle,Scorable {
	// City Properties
	private PVector area;// Could be a static final variable, but I want to keep my options open.
	public boolean intact;// public b/c it's easy
	
	// Constructor
	City(float x, float y) {
		super(x, y, 0, 0, 0);
		this.area = new PVector(100, 40);
		this.intact = true;
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

			return (distance < otherRadius);
		}
		System.out.println("CCWC Error: Not a Particle");// Remove?
		return false;
	}
	boolean collidesWithRectangle(Rectangle otherRectangle) {
		// City will never collide with another city
		return false;
	}

	void handleCollision(Collidable other) {
		intact = false;
	}
	void handleCollisionCirlce(Circle otherCirlce) {return;}// If something collides, then it's dead.
	void handleCollisionRectangle(Rectangle otherRectangle) {return;}// If something collides, then it's dead.

	public int getScore() {
		if (intact) {
			return 	CITY_SCORE_VALUE;
		}
		return 0;
	}

	void draw() {
		if (intact) {
			fill(100, 100, 100);
		} else {
			fill(255, 0, 0);// Pick better color. Red means it's destroyed.
		}
		rect(super.position.x, super.position.y, area.x, area.y);
	}
}

