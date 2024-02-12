//Bomber.pde

private static final int WING_SPAN		= 50;
private static final int BODY_LENGTH	= 200;
private static final int MAX_TIMER		= 60;

class Bomber {
	private float x, y;
	private ArrayList<Meteor> meteors;
	private ArrayList<Explosion> explosions;
	private int bomberTimer;

	Bomber(float x, float y, ArrayList<Meteor> meteors, ArrayList<Explosion> explosions) {
		this.x = x;
		this.y = y;
		this.meteors = meteors;
		this.explosions	= explosions;
	}

	void moveBomber(float increment, float minX, float maxX) {
		this.x = constrain(x + increment, minX, maxX);
	}

	void dropMeteor() {
		meteors.add(new Meteor(x, y + 100, 0f, 0f, 90, explosions));
	}
}