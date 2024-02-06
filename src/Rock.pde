// Rock.pde

// Damping or Actual Drag?
private static final float ROCK_DAMPING = .996f;

class Rock {
    PVector position;
    PVector velocity;
    PVector acceleration;
    // float invMass;
    boolean exploded;
    Explosion explosion;

    // Constructor
    Rock(PVector pos, PVector vel) {
        this.position = pos;
        this.velocity = vel;
        this.acceleration = new PVector(0, GRAVITY);
        this.exploded = false;
    }

    void update() {
        position.add(velocity);
        velocity.add(acceleration);
        velocity.mult(ROCK_DAMPING);
    }

    void explode() {
        explosion = new Explosion(new PVector(position.x, position.y));
        // explosion.draw();// May Cause Issues
        exploded = true;
        // Delete Self
        position.set(-100, -100);// Offscreen
    }

    void draw() {
        if (exploded) {
            explosion.draw();
            return;
        }
        update();

        fill(0, 0, 0);// Temp Black
        ellipse(this.position.x, this.position.y, 20, 20);
    }
}