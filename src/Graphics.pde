// Graphics.pde

class Graphics {
	void drawCity(float x, float y, float w, float h) {
		fill(0, 0, 255);
		rect(x, y, w, h);
	}

	void drawMissile(float x, float y) {
		fill(0, 0, 255);
		rect(x, y, 20, 40);
	}

	void drawBallistae(float x, float y) {
        // Draw ballista
        fill(100, 100, 100);
        rectMode(CENTER);
        rect(x, y, 20, 40);
        
        // Draw bowstring
        strokeWeight(2);
        line(x - 8, y - 20, x - 8, y - 35);
        line(x + 8, y - 20, x + 8, y - 35);
        
        // Draw arrow
        fill(150, 75, 0);
        triangle(x - 10, y - 35, x + 10, y - 35, x, y - 60);
	}
}
