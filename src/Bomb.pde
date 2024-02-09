// Bomb.pde
class Bomb extends Particle {
	private ArrayList<Explosion> explosions;
	private boolean exploded;

	// Constructor
	Bomb(float x, float y, float xV, float yV, ArrayList<Explosion> explosions) {
		super(x, y, xV, yV, 1f); // Assuming the mass of the bomb is 1
		this.explosions = explosions;
		this.exploded = false;
	}

	@Override
	public float getMass() {
		return 1f; // Mass of the bomb is 1
	}

	@Override
	void addForce(PVector force) {
		super.forceAccumulator.add(force);
		// System.out.println(force);
	}

	@Override
	void integrate() {
		if (exploded) {
			return;
		}

		// Physics
		super.position.add(super.velocity);

		PVector acceleration = super.forceAccumulator.get();
		// System.out.println(super.invMass);// Print
		acceleration.mult(super.invMass);
		// System.out.println(acceleration);// Print
		super.forceAccumulator.x = 0;
		super.forceAccumulator.y = 0;

		super.velocity.add(acceleration);
		super.velocity.mult(DAMPING);
	}

	void explode() {
		if (exploded) {
			return;
		}
		// Add Explosion to referenced Array
		explosions.add(new Explosion(new PVector(super.position.x, super.position.y), 8, 100));
		// Signal for Delete Self
		exploded = true;
		// Move Offscreen
		super.position.set(-100, -100); // Offscreen
	}

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
