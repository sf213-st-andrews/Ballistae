// Graphics
final int screen_width			= 1200;
final int screen_height			= 900;
final int ground_height			= 80;

// Physics
public static final float DAMPING = 0.995;
Gravity gravity	= new Gravity(new PVector(0f, 0.2f));// 0.2f
Drag drag		= new Drag(0.001f, 0.1f);// Currently Drag does NOT depend on the size/surface area of the particle

// Registry
// ForceRegistry forceRegistry;

// Objects
// City
int nCities = 6;
City cities[];
// Ballista
int nBallis = 3;
Ballista ballistae[];
// ArrayLists
ArrayList<Bomb> bombs;			// Pool of ammunition
ArrayList<Explosion> explosions;// Pool of explosions
ArrayList<Meteor> meteors;		// Pool of meteors

// int score = 0;

void settings() {
	size(screen_width, screen_height);
}

void setup() {
	// Graphics
	// ArrayList initialization
	bombs		= new ArrayList<Bomb>();
	explosions	= new ArrayList<Explosion>();
	meteors		= new ArrayList<Meteor>();
	// Cities
	cities = new City[nCities];
	int cityWidth = 100;
	int totalCW = cityWidth * nCities;
	int gap = (screen_width - totalCW) / (nCities + 1);
	for (int i = 1; i <= nCities; i++) {
		cities[i-1] = new City(i*gap + (i-1)*cityWidth, screen_height - 40);
	}
	// Ballistae
	ballistae = new Ballista[nBallis];
	int ballistaWidth = 40;
	int totalBW = ballistaWidth * nBallis;
	gap = (screen_width - totalBW) / (nBallis + 1);
	for(int i = 1; i <= nBallis; i++) {
		ballistae[i-1] = new Ballista(i*gap + (i-1)*ballistaWidth, screen_height - 100, bombs, explosions);
	}
	
	// Meteors
	// spawnWave(6);
	meteors.add(new Meteor(250, 450, 
		0, 0, 
		50, explosions));
}

void spawnWave(int waveSize) {
	int wSect	= screen_width / waveSize;
	int wSect_h	= wSect / 2;
	for (int i = 0; i < waveSize; i++) {
		meteors.add(new Meteor(wSect * i + (float)random(0, wSect_h), -50f, 
		(float)random(-1, 1), 0f, 
		(int) random(20, 50), explosions));
	}
}

void mousePressed() {
	if (mouseButton == LEFT) {
		for (int i = 0; i < nBallis; i++) {
			ballistae[i].fireBomb();
		}
	} else {
		for (int i = 0; i < bombs.size(); i++) {
			bombs.get(i).explode();
		}
	}
}

void keyPressed() {
	// Not using Switch Statement b/c two buttons can be pressed at once
	if (key == '1') {
		ballistae[0].fireBomb();
	}
	if (key == '2') {
		ballistae[1].fireBomb();
	}
	if (key == '3') {
		ballistae[2].fireBomb();
	}
	if (key == ' ') {
		if (bombs.size() > 0) {bombs.get(0).explode();}
	}
	// For Debugging
	if (key == 'm') {
		spawnWave(12);
	}
}

void draw() {
	// Graphics
	background(47, 150, 173);// Sky Color: 47, 150, 173
	// Ground
	fill(24, 56, 1);
	rect(0, screen_height - ground_height, screen_width, ground_height);
	// Cities
	for (int i = 0; i < nCities; i++) {
		// save meteors.size() - 1 as a variable ealier?
		for (int j = meteors.size() - 1; j >= 0; j--) {
			Meteor meteor = meteors.get(j);// For Readablity

			if (cities[i].collidesWithCircle(meteor)) {
				cities[i].intact = false;
			}
		}
		cities[i].draw();
	}
	// Ballistae
	for (int i = 0; i < nBallis; i++) {
		ballistae[i].draw();
	}
	// Meteors
	for (int i = meteors.size() - 1; i >= 0; i--) {
		// Start from last to first so removing isn't a problem
		Meteor meteor = meteors.get(i);// For Readablity

		for (int j = bombs.size() - 1; j >= 0; j--) {
			if (meteor.collidesWithCircle(bombs.get(j))) {
				meteor.handleCollisionCirlce(bombs.get(j));
				break;// To break out of the for-loop
			}
		}
		if (meteor.exploded) {
			meteors.remove(i);
			continue;
		}
		gravity.updateForce(meteors.get(i));
		drag.updateForce(meteors.get(i));
		meteors.get(i).draw();
	}
	// Bombs
	for (int i = bombs.size() - 1; i >= 0; i--) {
		// Start from last to first so removing isn't a problem
		Bomb bomb = bombs.get(i);
		if (bomb.exploded) {
			bombs.remove(i);
			continue;
		}
		gravity.updateForce(bomb);
		drag.updateForce(bomb);
		bomb.draw();
		
		for (int j = meteors.size() - 1; j >= 0; j--) {
			Meteor meteor = meteors.get(j);// For Readablity
			if (bomb.collidesWithCircle(meteor)) {
				bomb.handleCollisionCirlce(meteor);// Not Circle b/c that has no implementation
				break;// Assumes no other interactions
			}
		}
	}
	// Explosions
	// Try Optimizing this later
	// ArrayList<Circle> circles = new ArrayList<Circle>();
	// circles.addAll(meteors);
	// circles.addAll(bombs);

	for (int i = explosions.size() - 1; i >= 0; i--) {
		// Start from last to first so removing isn't a problem
		Explosion explosion = explosions.get(i);
		explosion.draw();
		if (explosion.lifetime <= 0) {
			explosions.remove(i);
			continue;
		}
		// for (int j = circles.size() - 1; j >= 0; j--) {
		// 	if (explosion.collidesWithCircle(circles.get(j))) {
		// 		explosion.handleCollisionCirlce(circles.get(j));
		// 	}
		// }
	}
	
	// System.out.println("Bombs size: " + bombs.size());
	// System.out.println("Explosions size: " + explosions.size());
}
