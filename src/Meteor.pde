// Meteor.pde implements Collidable

// Damping or Actual Drag?
private static final float METEOR_DAMPING = .95f;

class Meteor {
	PVector position;
	PVector velocity;
	PVector acceleration;
	int radius;
	// float invMass;
	boolean exploded;
	private ArrayList<Explosion> explosions;

	// Constructor
	Meteor(PVector pos, PVector vel, int radius, ArrayList<Explosion> explosions) {
		this.position		= pos;
		this.velocity		= vel;
		this.acceleration	= new PVector(0, GRAVITY);
		this.radius			= radius;
		this.exploded		= false;
		this.explosions		= explosions;
	}

	void update() {
		position.add(velocity);
		velocity.add(acceleration);
		velocity.mult(METEOR_DAMPING);
	}

	void explode() {
        if (exploded) {return;}
		// Add Explosion to referenced Array
        explosions.add(new Explosion(new PVector(position.x, position.y), 8, 100));
        // Signal for Delete Self
		exploded = true;
		// Move Offscreen
        position.set(-200, -100);// Offscreen
    }

	void draw() {
		update();

		fill(169, 169, 169); // Temp Dark Grey
		ellipse(this.position.x, this.position.y, radius, radius);
	}
}
