// Particle.pde
abstract class Particle {
	private PVector position;
	private PVector velocity;
	private PVector forceAccumulator;
	private float invMass;

	Particle(float x, float y, float xV, float yV, float invM) {
		this.position = new PVector(x, y);
		if (invM == 0f) {
			return;
		}
		this.velocity = new PVector(xV, yV);
		this.forceAccumulator = new PVector(0, 0);
		this.invMass = invM;
	}

	public abstract float getMass();

	abstract void addForce(PVector force);

	abstract void integrate();
}
