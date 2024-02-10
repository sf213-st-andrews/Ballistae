// Rectangle.pde
interface Rectangle extends Collidable {
	// Return a PVector with the width and height of the rectangle.
	PVector getArea();

	boolean collidesWith(Collidable other);
	boolean collidesWithCircle(Circle otherCirlce);
	boolean collidesWithRectangle(Rectangle otherRectangle);

	void handleCollision(Collidable other);
	void handleCollisionCirlce(Circle otherCirlce);
	void handleCollisionRectangle(Rectangle otherRectangle);
}
