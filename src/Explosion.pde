// Explosion.pde

class Explosion {
    PVector pos;
    // PVector velocity;?
    int radius = 20;
    int lifetime = 10;// How long the explosion stays before it self deletes
    // Constructor
    Explosion(PVector pos) {
        this.pos = pos;
    }

    void draw() {
		fill(235, 82, 52);// Orange
		ellipse(pos.x, pos.y, radius, radius);
		// Explosion has a yellow heart
		fill(235, 210, 52);// Yellow
		ellipse(pos.x, pos.y, radius/2, radius/2);
	}

}
