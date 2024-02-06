// Rock.pde

class Rock {
    PVector position;
    PVector velocity;
    // PVector acceleration;

    // Constructor
    Rock(PVector pos, PVector vel) {
        this.position = pos;
        this.velocity = vel;
    }

    void update() {
        position.add(velocity);
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