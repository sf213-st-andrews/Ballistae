// Meteor.pde
private static final float  MASS_MODIFIER		= 32f;
private static final int    METEOR_SCORE_VALUE	= 25;
private static final int    METEOR_INVUN_TIME	= 16;// The time a meteor has before it becomes vunerable.

class Meteor extends Particle implements Circle, Explodable, Scorable {
	private int radius;
	private int invunTimer;
	boolean exploded;
	private ArrayList<Explosion> explosions;

	// Constructor
	Meteor(float x, float y, float xV, float yV, int radius, ArrayList<Explosion> explosions) {
		super(x, y, xV, yV, MASS_MODIFIER / (float)(radius*radius));// Mass increases exponentially(?) with radius.
		this.radius		= radius;
		this.invunTimer	= METEOR_INVUN_TIME;
		this.exploded	= false;
		this.explosions	= explosions;
	}

	@Override
	float getMass() {
		return (float)(radius*radius) / MASS_MODIFIER;
	}

	@Override
	void integrate() {
		if (exploded) {
			return;
		}
		invunTimer -= 1;
		super.integrate();
	}

	void explode() {
		if (exploded || invunTimer > 0) {
			return;// Can't be exploded while invunerable
		}
		// Add Explosion to referenced Array
		explosions.add(new Explosion(super.position.x, super.position.y, 8, (int) (radius*1.5f)));
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
			int sumRadius = bRadius + otherCirlce.getRadius();
			Particle otherParticle = (Particle) otherCirlce;
			float distance = super.position.dist(otherParticle.position);
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

			return (distance < bRadius);
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
		// this.explode();//CURRENTLY THIS IS NOT CALLED
	}
	void handleCollisionRectangle(Rectangle otherRectangle) {
		this.explode();
	}

	public int getScore() {
		return METEOR_SCORE_VALUE;
	}

	void draw() {
		// Physics
		integrate();

		// Graphics
		fill(169, 169, 169); // Temp Dark Grey
		ellipse(super.position.x, super.position.y, radius, radius);
	}
}
