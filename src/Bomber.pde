//Bomber.pde

private static final int WING_SPAN		= 60;
private static final int BODY_LENGTH	= 80;
private static final int MAX_TIMER		= 60;

class Bomber {
	private float x, y;
	private int bomberTimer;
	private ArrayList<Meteor> meteors;
	private ArrayList<Explosion> explosions;

	Bomber(float x, float y, ArrayList<Meteor> meteors, ArrayList<Explosion> explosions) {
		this.x = x;
		this.y = y;
		this.bomberTimer = MAX_TIMER;
		this.meteors = meteors;
		this.explosions	= explosions;
	}

	void moveBomber(float increment) {
		this.x += increment;
	}
	void setBomberPos(float x, float y) {
		this.x = x;
		this.y = y;
	}

	void dropMeteor() {
		meteors.add(new Meteor(x, y + 100, 0f, 0f, 90, explosions));
	}

	void updateTimer() {
		if (bomberTimer > 0) {
			bomberTimer--;
		} else {
			dropMeteor();
			bomberTimer = MAX_TIMER;
		}
	}

	void draw() {
		// Draw wings
		stroke(100, 100, 100);
		strokeWeight(16);
		line(x - WING_SPAN/3, y + WING_SPAN/2, x + WING_SPAN/3, y - WING_SPAN/2);
		resetStroke();

		// Draw body
		stroke(40, 40, 40);
		strokeWeight(1);
		fill(80, 80, 80);
		ellipse(x - 10, y, BODY_LENGTH, 26);

		// Draw tail
		// Use same stroke and fill as prior
		triangle(
			x - 48, y, 
			x - 48, y - 20, 
			x - 32, y);


		// Draw cockpit
		stroke(0);
		fill(200, 200, 200);
		ellipse(x + 16, y - 4, 16, 10);

		// Reset
		resetStroke();
	}
	void resetStroke() {
		stroke(0);
		strokeWeight(1);
	}
}
