// Meteor.pde
class Meteor extends Particle implements Circle {
    int radius;
    boolean exploded;
    private ArrayList<Explosion> explosions;

    // Constructor
    Meteor(float x, float y, float xV, float yV, int radius, ArrayList<Explosion> explosions) {
        super(x, y, xV, yV, 1f / (float)(radius*radius));// Mass increases exponentially(?) with radius.
        this.radius = radius;
        this.exploded = false;
        this.explosions = explosions;
    }

    @Override
    void integrate() {
		if (exploded) {
			return;
		}
		super.integrate();
    }

    void explode() {
        if (exploded) {
            return;
        }
        // Add Explosion to referenced Array
        explosions.add(new Explosion(new PVector(super.position.x, super.position.y), 8, 100));
        // Signal for Delete Self
        exploded = true;
    }

    int getRadius() {
        return radius;
    }

	boolean collidesWith(Collidable other) {
		if (other instanceof Circle) {return collidesWithCircle((Circle) other);}
		else {return collidesWithRectangle((Rectangle) other);}
	}
	boolean collidesWithCircle(Circle otherCirlce) {
        if (otherCirlce instanceof Particle) {
			// Is this check necessary?
			int sumRadius = bRadius + otherCirlce.getRadius();
			Particle otherParticle = (Particle) otherCirlce;
			float distance = super.position.dist(otherParticle.position);
			// System.out.println("CDist: " + distance);
			return (distance <= sumRadius);
		}
		System.out.println("MCWC Error: Not a Particle");// Remove?
		return false;
    }
	boolean collidesWithRectangle(Rectangle otherRectangle) {
        if (otherRectangle instanceof Particle) {
			// TODO Double Check Code
			PVector rectArea		= otherRectangle.getArea();
			Particle otherParticle	= (Particle) otherRectangle;
			PVector otherPosition	= otherParticle.position;// is position private?

			float closestX = constrain(super.position.x, otherPosition.x, otherPosition.x + rectArea.x);
			float closestY = constrain(super.position.y, otherPosition.y, otherPosition.y + rectArea.y);
			float distance = dist(super.position.x, super.position.y, closestX, closestY);

			return (distance <= bRadius);
		}
		System.out.println("BCWR Error: Not a Particle");// Remove?
		return false;
    }

	void handleCollision(Collidable other) {
        if (other instanceof Circle) {
			handleCollisionCirlce((Circle) other);
			return;
		} else {
			handleCollisionRectangle((Rectangle) other);
			return;
		}
    }
	void handleCollisionCirlce(Circle otherCirlce) {
        this.explode();
    }
	void handleCollisionRectangle(Rectangle otherRectangle) {
        this.explode();
    }

    void draw() {
		// Physics
		integrate();

		// Graphics
        fill(169, 169, 169); // Temp Dark Grey
        ellipse(super.position.x, super.position.y, radius, radius);
    }
}
