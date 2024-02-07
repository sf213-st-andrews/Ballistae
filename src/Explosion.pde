// Explosion.pde

class Explosion {
	PVector pos;
	int maxRadius;	// The Maximum Radius
	int radius;		// The Current Radius
	int lifetime;	// How long the explosion stays before it self-deletes
	int halfLife;	// Half of the lifetime. Used for graphics

	// Constructor
	Explosion(PVector pos, int halfLife, int maxRadius) {
		this.pos = new PVector(pos.x, pos.y); // Create a new PVector to avoid reference issues
		this.halfLife = halfLife;
		this.lifetime = halfLife*2;
		this.maxRadius = maxRadius;
	}

	void update() {
		if (lifetime <= 0) {
			return;
		}
		radius = maxRadius - ((halfLife - lifetime)*(halfLife - lifetime));
		lifetime -= 1;
		
	}

	void draw() {
		// Phys
		update();

		fill(235, 82, 52); // Orange. *2 because of how ellipse draws. Add Offset?
		ellipse(pos.x, pos.y, radius*2, radius*2);

		// Explosion has a yellow heart
		fill(235, 210, 52); // Yellow
		ellipse(pos.x, pos.y, radius, radius);
	}
}
