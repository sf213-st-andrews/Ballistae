// Circle.pde
interface Circle extends Collidable {
	boolean collidesWith(Collidable other);
	void handleCollision(Collidable other);
}
