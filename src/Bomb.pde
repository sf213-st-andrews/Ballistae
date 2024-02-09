// Bomb.pde
class Bomb extends Particle {
	private static final float BOMB_DAMPING = 0.996f;
	private ArrayList<Explosion> explosions;
	private boolean exploded;

	// Constructor
	Bomb(float x, float y, float xV, float yV, ArrayList<Explosion> explosions) {
		super(x, y, xV, yV, 1); // Assuming the mass of the bomb is 1
		this.explosions = explosions;
		this.exploded = false;
	}

	@Override
	public float getMass() {
		return 1; // Mass of the bomb is 1
	}

	@Override
	void addForce(PVector force) {
		// Bombs don't respond to forces in this example
	}

	@Override
	void integrate() {
		if (exploded) {
			return;
		}

		// Physics
		super.integrate();
		super.velocity.mult(BOMB_DAMPING);
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
		

		// Graphics
		fill(0, 0, 0);
		ellipse(super.position.x, super.position.y, 20, 20);
	}
}
