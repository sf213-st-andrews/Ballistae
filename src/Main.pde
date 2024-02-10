// Graphics
static final int screen_width		= 1200;
static final int screen_width_h		= screen_width/2;
static final int screen_height		= 900;
static final int screen_height_h	= screen_height/2;
static final int ground_height		= 80;

// Physics
public static final float DAMPING = 0.995;
Gravity gravity	= new Gravity(new PVector(0f, 0.2f));// 0.2f
Drag drag		= new Drag(0.001f, 0.1f);// Currently Drag does NOT depend on the size/surface area of the particle

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

// GUI and User Input
static final int numKeys = 5;
// int score = 0;
int gameState		= 0;// 0 Start Menu, 1 Gameplay

boolean keyLog[]	= new boolean[numKeys];// 6 Keys

void settings() {
	size(screen_width, screen_height);
}

void setup() {
	for (int i = 0; i < numKeys; i++) {
		keyLog[i] = false;// Set all keys to not pressed
	}
	setupGame();
}

void setupGame() {
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
		keyLog[0] = true;
	}
	if (key == '2') {
		keyLog[1] = true;
	}
	if (key == '3') {
		keyLog[2] = true;
	}
	if (key == ' ') {
		keyLog[3] = true;
	}
	// For Debugging
	if (key == 'm') {
		keyLog[4] = true;
	}
	if (key == ENTER) {
		// Maybe don't need a keyLog for this
		gameState = (gameState+1) % 2;
	}
}

void keyReleased() {
	if (key == '1') {
		keyLog[0] = false;
	}
	if (key == '2') {
		keyLog[1] = false;
	}
	if (key == '3') {
		keyLog[2] = false;
	}
	if (key == ' ') {
		keyLog[3] = false;
	}
	// For Debugging
	if (key == 'm') {
		keyLog[4] = false;
	}
}

void draw() {
	switch (gameState) {
		case 0:// Start Menu
			drawStartMenu();
		break;

		case 1:// Gameplay
			drawGameplay();
		break;

		default :
			drawStartMenu();
		break;	
	}
}

void drawStartMenu() {
	background(0,0,0);// Black
	fill(0, 255, 0);
	rect(screen_width_h, screen_height_h, 100, 100);
}

void drawGameplay() {
	// Keys
	if (keyLog[0]) {
		ballistae[0].fireBomb();
	}
	if (keyLog[1]) {
		ballistae[1].fireBomb();
	}
	if (keyLog[2]) {
		ballistae[2].fireBomb();
	}
	if (keyLog[3]) {
		if (bombs.size() > 0) {bombs.get(0).explode();}
	}
	if (keyLog[4]) {
		spawnWave(12);
	}
	
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
				cities[i].handleCollision(meteor);
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

		if (meteor.exploded || meteor.position.y > screen_height + 100) {
			meteors.remove(i);
			continue;
		}
		gravity.updateForce(meteor);
		drag.updateForce(meteor);
		meteor.draw();
	}
	// Bombs
	for (int i = bombs.size() - 1; i >= 0; i--) {
		// Start from last to first so removing isn't a problem
		Bomb bomb = bombs.get(i);
		if (bomb.exploded || bomb.position.y > screen_height + 100) {
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
	ArrayList<Circle> circles = new ArrayList<Circle>();
	circles.addAll(meteors);
	circles.addAll(bombs);

	for (int i = explosions.size() - 1; i >= 0; i--) {
		// Start from last to first so removing isn't a problem
		Explosion explosion = explosions.get(i);
		explosion.draw();
		if (explosion.lifetime <= 0) {
			explosions.remove(i);
			continue;
		}
		for (int j = circles.size() - 1; j >= 0; j--) {
			if (explosion.collidesWithCircle(circles.get(j))) {
				explosion.handleCollisionCirlce(circles.get(j));
			}
		}
	}
}
