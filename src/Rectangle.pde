// Rectangle.pde
interface Rectangle extends Collidable {
	boolean collidesWith(Collidable other);
	boolean collidesWithCircle(Circle otherCirlce);
	boolean collidesWithRectangle(Rectangle otherRectangle);

	void handleCollision(Collidable other);
	void handleCollisionCirlce(Circle otherCirlce);
	void handleCollisionRectangle(Rectangle otherRectangle);
}
