// Collidable.pde
interface Collidable {
	boolean collidesWith(Collidable other);
	void handleCollision(Collidable other);

	// Add in registerHit()?
}
