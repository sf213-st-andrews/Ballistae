// Bomb.pde

// Damping or Actual Drag?
private static final float BOMB_DAMPING =.996f;

class Bomb {
    PVector position;
    PVector velocity;
    PVector acceleration;
    // float invMass;
    boolean exploded;
    private Explosion explosion;
    
    // Constructor
    Bomb(PVector pos, PVector vel) {
        this.position = pos;
        this.velocity = vel;
        this.acceleration = new PVector(0, GRAVITY);
        this.exploded = false;
    }
    
    void update() {
        position.add(velocity);
        velocity.add(acceleration);
        velocity.mult(BOMB_DAMPING);
    }
    
    void explode() {
        explosion = new Explosion(new PVector(position.x, position.y));
        exploded = true;
        // Delete Self
        position.set( - 100, -100);// Offscreen
    }
    
    void draw() {
        if (exploded) {
            explosion.draw();// Comment out so they can be removed from the ArrayList
            return;
        }
        // Physics
        update();
        
        // Graphics
        fill(0, 0, 0);// Temp Black
        ellipse(this.position.x, this.position.y, 20, 20);
    }

    public Explosion getExplosion() {
        return explosion;
    }
}