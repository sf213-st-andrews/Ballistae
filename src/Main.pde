// Graphics
final int screen_width			= 1200;
final int screen_height			= 900;
final int screen_width_half		= screen_width/2;
final int ground_height			= 80;
final int ground_height_half	= ground_height/2;

// Physics
public static final float DAMPING = 0.995;
Gravity gravity	= new Gravity(new PVector(0f, 0.2f));// 0.2f
Drag drag		= new Drag(0.001f, 0.001f);// Currently Drag does NOT depend on the size/surface area of the particle

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
	rectMode(CENTER);
	// ArrayList initialization
	bombs		= new ArrayList<Bomb>();
	explosions	= new ArrayList<Explosion>();
	meteors		= new ArrayList<Meteor>();
	// Cities
	cities = new City[nCities];
	int cSect	= screen_width / nCities; // Divide into sections
	int cSect_h	= cSect / 2;       				// For Offset to make the sections neat
	for (int i = 0; i < nCities; i++) {
		cities[i] = new City((cSect * i) + cSect_h, screen_height - 20);
	}
	// Ballistae
	ballistae = new Ballista[nBallis];
	int bSect	= screen_width / nBallis; // Divide into sections
	int bSect_h	= bSect / 2;       				// For Offset to make the sections neat
	for(int i = 0; i < nBallis; i++) {
		ballistae[i] = new Ballista((bSect * i) + bSect_h, screen_height - 70, bombs, explosions);
	}
	
	// Meteors
	spawnWave(6);
}

void spawnWave(int waveSize) {
	int wSect	= screen_width / waveSize;
	int wSect_h	= wSect / 2;
	for (int i = 0; i < waveSize; i++) {
		meteors.add(new Meteor(wSect * i + (float)random(0, wSect_h), -50f, 
		(float)random(-5, 5), (float)random(-10, 20), 
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
}

void draw() {
	// Graphics
	background(47, 150, 173);// Sky Color: 47, 150, 173
	// Ground
	fill(24, 56, 1);
	rect(screen_width_half, screen_height - ground_height_half, screen_width, ground_height);
	// Cities
	for (int i = 0; i < nCities; i++) {
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
		if (bombs.get(i).exploded) {
			bombs.remove(i);
			continue;
		}
		gravity.updateForce(bombs.get(i));
		drag.updateForce(bombs.get(i));
		bombs.get(i).draw();
	}
	// Explosions
	for (int i = explosions.size() - 1; i >= 0; i--) {
		// Start from last to first so removing isn't a problem
		explosions.get(i).draw();
		if (explosions.get(i).lifetime <= 0) {
			explosions.remove(i);
		}
	}
	
	// System.out.println("Bombs size: " + bombs.size());
}
