// Particle.pde
final class Particle {
	// private static final float DAMPING = 0.995f;

	// Vector Attributes
	private PVector position;
	private PVector velocity;
	private PVector forceAccumulator;
	// Add Size?

	// Float Attributes
	private float invMass;

	// Constructor
	Particle(int x, int y, float xV, float yV, float invM) {
		this.position			= new PVector(x, y);
		if (invM == 0f) {return;}
		this.velocity 			= new PVector(xV, yV);
		this.forceAccumulator	= new PVector(0,0);
	}

	public float getMass() {return 1/invMass;}

	void addForce(PVector force) {
		forceAccumulator.add(force);
	}

	void integrate() {
		if (invMass == 0f) {return;}
		// Update position
		position.add(velocity);
		// Acceleration. Get Gravity First, then add forces?
		PVector acceleration = forceAccumulator.get();
		acceleration.mult(invMass);
		// Update velocity
		velocity.add(acceleration);
	}
}