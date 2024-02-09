// Rectangle.pde
interface Rectangle extends Collidable {
	boolean collidesWith(Collidable other);
	void handleCollision(Collidable other);
}
