// Ballistae.pde

class Ballistae {
    // Ballistae
    private static final float ballistaWidth = 20;
    private static final float ballistaHeight = 40;
    private static final float bowstringOffset = 8;
    
    PVector pos;
    

    // Bombs
    ArrayList<Bomb> bombs;
	
	float magReduce = 0.025f;
    
    Ballistae(PVector cityPos, ArrayList<Bomb> bombs) {
        this.pos = PVector.add(cityPos, new PVector(50, -20));
        this.bombs = bombs;// Pass by Reference
       	// Maths are good. Wait still double check it though.
	}
    
    void fireBomb(PVector mousePos) {
        // Just a test, Bomb ammo should be handled carefully
		bombs.add(new Bomb(new PVector(pos.x, pos.y), PVector.sub(mousePos, pos).mult(magReduce)));
        // System.out.println(PVector.sub(mousePos, pos).mult(magReduce));
	}
    
    void draw() {
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
	}
}
