// Collidable.pde Made using advice. Just Circle Collisions for now

interface Collidable {
	boolean collidesWith(Collidable other);
	void handleCollision(Collidable other);
}
