// Meteor.pde

// Damping or Actual Drag?
private static final float METEOR_DAMPING = .95f;

class Meteor {
	PVector position;
	PVector velocity;
	PVector acceleration;
	int radius;
	// float invMass;

	// Constructor
	Meteor(PVector pos, PVector vel, int radius) {
		this.position = pos;
		this.velocity = vel;
		this.acceleration = new PVector(0, GRAVITY);
		this.radius = radius;
	}

	void update() {
		position.add(velocity);
		velocity.add(acceleration);
		velocity.mult(METEOR_DAMPING);
	}

	void explode() {
		Explosion explode = new Explosion(position);
		// Delete Self
	}

	void draw() {
		fill(169, 169, 169); // Temp Dark Grey
		ellipse(this.position.x, this.position.y, 30, 30);
		update();
	}
}
