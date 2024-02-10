// Particle.pde
abstract class Particle {
	private PVector position;
	private PVector velocity;
	private PVector forceAccumulator;
	private float invMass;

	Particle(float x, float y, float xV, float yV, float invM) {
		this.position = new PVector(x, y);
		this.invMass = invM;
		if (invM == 0f) {
			return;
		}
		this.velocity = new PVector(xV, yV);
		this.forceAccumulator = new PVector(0, 0);
	}

	public float getMass() {
		return 1f/invMass;
	}

	void addForce(PVector force) {
		this.forceAccumulator.add(force);
	}

	void integrate() {
		// Add an if invMass = 0 check?
		position.add(velocity);

		PVector acceleration = forceAccumulator.get();// System.out.println(super.invMass);// Print
		acceleration.mult(invMass);
		forceAccumulator.x = 0;// System.out.println(acceleration);// Print
		forceAccumulator.y = 0;

		velocity.add(acceleration);
		velocity.mult(DAMPING);
	}
}
