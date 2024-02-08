// Bomb.pde

// Damping or Actual Drag?
private static final float BOMB_DAMPING =.996f;

class Bomb {
    PVector position;
    PVector velocity;
    PVector acceleration;
    // float invMass;
    boolean exploded;
    private ArrayList<Explosion> explosions;
    
    // Constructor
    Bomb(PVector pos, PVector vel, ArrayList<Explosion> explosions) {
        this.position       = pos;
        this.velocity       = vel;
        this.acceleration   = new PVector(0, GRAVITY);
        this.exploded       = false;
        this.explosions     = explosions;
    }
    
    void update() {
        position.add(velocity);
        velocity.add(acceleration);
        velocity.mult(BOMB_DAMPING);
    }
    
    void explode() {
        if (exploded) {return;}
		// Add Explosion to referenced Array
        explosions.add(new Explosion(new PVector(position.x, position.y), 8, 100));
        // Signal for Delete Self
		exploded = true;
		// Move Offscreen
        position.set(-100, -100);// Offscreen
    }
    
    void draw() {
        if (exploded) {return;}
        // Physics
        update();
        // Graphics
        fill(0, 0, 0);//
        ellipse(this.position.x, this.position.y, 20, 20);
    }
}
