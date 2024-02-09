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
