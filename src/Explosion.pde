// Explosion.pde

class Explosion {
    PVector pos;
    // PVector velocity;?
    int radius = 20;
    // Constructor
    Explosion(PVector pos) {
        this.position = pos;
    }

    void draw() {
		fill(235, 82, 52);// Orange
		ellipse(pos.x, pos.y, r, r);
		// Explosion has a yellow heart
		fill(235, 210, 52);// Yellow
		ellipse(pos.x, pos.y, r/2, r/2);
	}

}