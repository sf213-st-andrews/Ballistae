// Explosion.pde

class Explosion {
	PVector pos;
	int radius = 100;  // Temp put in constructor
	int lifetime = 10; // Temp put in constructor. How long the explosion stays before it self-deletes
	float rlRatio;     // Ratio of Radius/Lifetime

	// Constructor
	Explosion(PVector pos) {
		this.pos = new PVector(pos.x, pos.y); // Create a new PVector to avoid reference issues
		this.rlRatio = radius / (float)lifetime; // Convert to float for accurate division
	}

	void update() {
		if (lifetime <= 0) {
			return;
		}
		lifetime -= 1;
		radius -= rlRatio;
	}

	void draw() {
		// Phys
		update();

		fill(235, 82, 52); // Orange
		ellipse(pos.x, pos.y, radius, radius);

		// Explosion has a yellow heart
		fill(235, 210, 52); // Yellow
		ellipse(pos.x, pos.y, radius / 2, radius / 2);
	}
}
