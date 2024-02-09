// Ballista.pde
class Ballista {
	// Graphics
	private static final float ballistaWidth	= 40;
	private static final float ballistaHeight	= 50;
	private static final float aimLength		= 200;
	float bowstringY;

	// Attributes
	private PVector pos;
	private ArrayList<Bomb> bombs;
	ArrayList<Explosion> explosions;
	private float magReduce = 0.05f;

	// Constructor
	Ballista(float x, float y, ArrayList<Bomb> bombs, ArrayList<Explosion> explosions) {
		this.pos = new PVector(x, y);
		this.bombs = bombs;
		this.explosions = explosions;
		this.bowstringY = y - ballistaHeight / 2;
	}

	// Fire a bomb towards the mouse position. Do I need to even pass the mouse position?
	void fireBomb() {//PVector.sub(mousePos, pos).mult(magReduce)
		bombs.add(new Bomb(pos.x, bowstringY, (mouseX - pos.x) * magReduce, (mouseY - pos.y) * magReduce, explosions));
	}

	// Draw
	void draw() {
		// Calculate the direction from the ballista position to the mouse position
		PVector direction = new PVector(mouseX - pos.x, mouseY - bowstringY);
		direction.normalize();
		stroke(255, 0, 0);
		line(pos.x, bowstringY, pos.x + direction.x * aimLength, bowstringY + direction.y * aimLength);
		stroke(0, 0, 0);

		// Draw ballista
		fill(165, 42, 42);
		ellipse(pos.x, bowstringY, ballistaWidth, ballistaWidth);
		// Draw tower
		fill(150);
		rect(pos.x, pos.y, ballistaWidth, ballistaHeight);
	}
}
