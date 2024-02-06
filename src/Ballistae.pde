// Ballistae.pde

class Ballistae {
    PVector pos;
	
	// Temp
	Rock rock;// = new Rock(pos, new PVector(0,0));
	boolean fired = false;
	float magReduce = 0.01f;
    
    Ballistae(PVector cityPos) {
        this.pos = PVector.add(cityPos, new PVector(50, -20));
       	// Maths are good. Wait still double check it though.
	}
    
    void fireRock(PVector mousePos) {
        // Just a test, Rock ammo should be handled carefully
		PVector bPos = new PVector(pos.x, pos.y);
		rock = new Rock(bPos, PVector.sub(mousePos, pos).mult(magReduce));
		fired = true;
	}
    
    void draw() {
        float ballistaWidth = 20;
        float ballistaHeight = 40;
        float bowstringOffset = 8;
        
        // Draw ballista
        fill(100, 100, 100);
        rect(pos.x - ballistaWidth / 2, pos.y - ballistaHeight / 2, ballistaWidth, ballistaHeight);
        
        // Draw bowstring
        strokeWeight(2);
        line(pos.x - bowstringOffset, pos.y - 20, pos.x - bowstringOffset, pos.y - 35);
        line(pos.x + bowstringOffset, pos.y - 20, pos.x + bowstringOffset, pos.y - 35);
        
        // Draw arrow
        fill(150, 75, 0);
        triangle(pos.x - 10, pos.y - 35, pos.x + 10, pos.y - 35, pos.x, pos.y - 60);

		// Temp
		if (fired) {
			rock.draw();
			rock.update();//Physics in draw calls huh
			// Why is the rock moving the ballista?
		}
		
	}
}
