// Ballista.pde
class Ballista {
	// Graphics
	private static final float ballistaWidth = 40;
	private static final float ballistaHeight = 50;
	float bowstringY;

	// Attributes
	private PVector pos;
	private ArrayList<Bomb> bombs;
	ArrayList<Explosion> explosions;
	private float magReduce = 0.025f;

	// Constructor
	Ballista(float x, float y, ArrayList<Bomb> bombs, ArrayList<Explosion> explosions) {
		this.pos = new PVector(x, y);
		this.bombs = bombs;
		this.explosions = explosions;
		this.bowstringY = y - ballistaHeight / 2;
	}

	// Fire a bomb towards the mouse position. Do I need to even pass the mouse position?
	void fireBomb(PVector mousePos) {
		bombs.add(new Bomb(new PVector(pos.x, bowstringY), PVector.sub(mousePos, pos).mult(magReduce), explosions));
	}

	// Draw
	void draw() {
		// Draw bowstring
		line(pos.x, bowstringY, mouseX, mouseY);

		// Draw ballista
		fill(165, 42, 42);
		ellipse(pos.x, bowstringY, ballistaWidth, ballistaWidth);
		// Draw tower
		fill(150);
		rect(pos.x, pos.y, ballistaWidth, ballistaHeight);
	}
}
