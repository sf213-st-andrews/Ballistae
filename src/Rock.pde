// Rock.pde

// Damping or Actual Drag?
private static final float ROCK_DAMPING = .996f;

class Rock {
    PVector position;
    PVector velocity;
    PVector acceleration;
    // float invMass;

    // Constructor
    Rock(PVector pos, PVector vel) {
        this.position = pos;
        this.velocity = vel;
        this.acceleration = new PVector(0, GRAVITY);
    }

    void update() {
        position.add(velocity);
        velocity.add(acceleration);
        velocity.mult(ROCK_DAMPING);
    }

    void explode() {
        Explosion explode = new Explosion(position);
        // Delete Self
    }

    void draw() {
        fill(0, 0, 0);// Temp Black
        ellipse(this.position.x, this.position.y, 20, 20);
    }
}