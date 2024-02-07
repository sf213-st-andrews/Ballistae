// Ballista.pde
class Ballista {
    // Graphics
    private static final float ballistaWidth = 20;
    private static final float ballistaHeight = 40;
    private static final float bowstringOffset = 8;

    // Attributes
    private PVector pos;
    private ArrayList<Bomb> bombs;
    private float magReduce = 0.025f;

    // Constructor
    Ballista(float x, float y, ArrayList<Bomb> bombs) {
        this.pos = new PVector(x, y);
        this.bombs = bombs;
    }

    // Fire a bomb towards the mouse position
    void fireBomb(PVector mousePos) {
        bombs.add(new Bomb(new PVector(pos.x, pos.y), PVector.sub(mousePos, pos).mult(magReduce)));
    }

    // Draw
    void draw() {
        // Draw tower
        fill(150);
        rect(pos.x, pos.y, ballistaWidth, ballistaHeight);

        // Draw bowstring
        float bowstringY = pos.y - ballistaHeight / 2;
        line(pos.x, pos.y, pos.x, bowstringY);

        // Draw ballista
        fill(165, 42, 42);
        ellipse(pos.x, bowstringY, 20, 20);
    }
}
