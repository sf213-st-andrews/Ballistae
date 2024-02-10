// Explosion.pde
// Is this a Particle? No
class Explosion implements Circle {
	PVector position;
	int maxRadius;	// The Maximum Radius
	int radius;		// The Current Radius
	int lifetime;	// How long the explosion stays before it self-deletes
	int halfLife;	// Half of the lifetime.

	// Constructor
	Explosion(float x, float y, int halfLife, int maxRadius) {
		this.position = new PVector(x, y); // Create a new PVector to avoid reference issues
		this.halfLife = halfLife;
		this.lifetime = halfLife*2;
		this.maxRadius = maxRadius;
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
			int sumRadius = radius + otherCirlce.getRadius();
			Particle otherParticle = (Particle) otherCirlce;
			float distance = position.dist(otherParticle.position);
			return (distance < sumRadius);
		}
		System.out.println("ECWC Error: Not a Particle");
		return false;
	}
	boolean collidesWithRectangle(Rectangle otherRectangle) {
		if (otherRectangle instanceof Particle) {
			PVector rectArea		= otherRectangle.getArea();
			Particle otherParticle	= (Particle) otherRectangle;
			PVector otherPosition	= otherParticle.position;

			float closestX = constrain(position.x, otherPosition.x, otherPosition.x + rectArea.x);
			float closestY = constrain(position.y, otherPosition.y, otherPosition.y + rectArea.y);
			float distance = dist(position.x, position.y, closestX, closestY);

			return (distance < radius);
		}
		System.out.println("ECWR Error: Not a Particle");
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
		if (otherCirlce instanceof Explodable) {
			Explodable explodable = (Explodable) (otherCirlce);
			explodable.explode();
		}
		return;
	}
	void handleCollisionRectangle(Rectangle otherRectangle) {
		// TODO finish
		return;
	}

	void update() {
		if (lifetime <= 0) {return;}
		radius = maxRadius - ((halfLife - lifetime)*(halfLife - lifetime));
		lifetime -= 1;
	}

	void draw() {
		// Phys
		update();

		fill(235, 82, 52); // Orange. *2 because of how ellipse draws. Add Offset?
		ellipse(position.x, position.y, radius*2, radius*2);// Not sure if Radius*2 is wise

		// Explosion has a yellow heart
		fill(235, 210, 52); // Yellow
		ellipse(position.x, position.y, radius, radius);
	}
}
