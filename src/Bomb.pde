// Bomb.pde
class Bomb extends Particle implements Circle {
	private ArrayList<Explosion> explosions;
	private boolean exploded;

	// Constructor
	Bomb(float x, float y, float xV, float yV, ArrayList<Explosion> explosions) {
		super(x, y, xV, yV, 1f); // The mass of the bomb is 1
		this.explosions = explosions;
		this.exploded = false;
	}

	@Override
	public float getMass() {
		return 1f; // Mass of the bomb is 1
	}

	@Override
	void integrate() {
		if (exploded) {
			return;
		}
		super.integrate();
	}

	void explode() {
		if (exploded) {
			return;
		}
		// Add Explosion to referenced Array
		explosions.add(new Explosion(new PVector(super.position.x, super.position.y), 8, 100));
		// Signal for Delete Self
		exploded = true;
	}

	boolean collidesWith(Collidable other) {
		if (other instanceof Circle) {return collidesWithCircle(other);}
		else {return collidesWithRectangle(other);}
	}
	
	boolean collidesWithCircle(Circle otherCirlce);// instanceof bomb?
	boolean collidesWithRectangle(Rectangle otherRectangle);

	void handleCollision(Collidable other);
	void handleCollisionCirlce(Circle otherCirlce);
	void handleCollisionRectangle(Rectangle otherRectangle);

	void draw() {
		if (exploded) {
			return;
		}
		// Physics
		integrate();

		// Graphics
		fill(0, 0, 0);
		ellipse(super.position.x, super.position.y, 20, 20);
	}
}
