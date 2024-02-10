// Bomb.pde

private static int bRadius = 20;// Make sure Graphics draw it correctly

class Bomb extends Particle implements Circle {
	// Explosions
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
	// Interface Methods
	int getRadius() {
		return bRadius;
	}

	boolean collidesWith(Collidable other) {
		if (other instanceof Circle) {return collidesWithCircle((Circle) other);}
		else {return collidesWithRectangle((Rectangle) other);}
	}
	boolean collidesWithCircle(Circle otherCirlce) {
		// instanceof bomb?
		if (otherCirlce instanceof Particle) {
			// Is this check necessary?
			int sumRadius = bRadius + otherCirlce.getRadius();
			Particle otherParticle = (Particle) otherCirlce;
			float distance = super.position.dist(otherParticle.position);
			// System.out.println("CDist: " + distance);
			return (distance <= sumRadius);
		}
		System.out.println("BCWC Error: Not a Particle");// Remove?
		return false;
	}
	boolean collidesWithRectangle(Rectangle otherRectangle) {
		// Should it just be false because Bomb never collides with any rectangle? Best to cover all bases + can reuse code
		if (otherRectangle instanceof Particle) {
			// TODO Double Check Code
			PVector rectArea		= otherRectangle.getArea();
			Particle otherParticle	= (Particle) otherRectangle;
			PVector otherPosition	= otherParticle.position;// is position private?

			float closestX = constrain(super.position.x, otherPosition.x, otherPosition.x + rectArea.x);
			float closestY = constrain(super.position.y, otherPosition.y, otherPosition.y + rectArea.y);
			float distance = dist(super.position.x, super.position.y, closestX, closestY);

			return (distance <= bRadius);
		}
		System.out.println("BCWR Error: Not a Particle");// Remove?
		return false;
	}

	void handleCollision(Collidable other) {
		this.explode();
		return;
		// if (other instanceof Circle) {
		// 	handleCollisionCirlce((Circle) other);
		// 	return;
		// } else {
		// 	handleCollisionRectangle((Rectangle) other);
		// 	return;
		// }
	}
	void handleCollisionCirlce(Circle otherCirlce) {
		return;// Return to?
	}
	void handleCollisionRectangle(Rectangle otherRectangle) {
		return;// Return to?
	}

	void draw() {
		if (exploded) {
			return;
		}
		// Physics
		integrate();

		// Graphics
		fill(0, 0, 0);
		ellipse(super.position.x, super.position.y, bRadius, bRadius);
	}
}
