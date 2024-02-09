// Meteor.pde  implements Collidable
class Meteor extends Particle {
    int radius;
    boolean exploded;
    private ArrayList<Explosion> explosions;

    // Constructor
    Meteor(float x, float y, float xV, float yV, int radius, ArrayList<Explosion> explosions) {
        super(x, y, xV, yV, 16f / (float)(radius*radius));// Mass increases exponentially(?) with radius.
        this.radius = radius;
        this.exploded = false;
        this.explosions = explosions;
    }

	@Override
	public float getMass() {
		return 1f/super.invMass;
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
		// Physics
		integrate();

		// Graphics
        fill(169, 169, 169); // Temp Dark Grey
        ellipse(super.position.x, super.position.y, radius, radius);
    }
}
