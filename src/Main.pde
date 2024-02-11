// Graphics
static final int screen_width		= 1200;
static final int screen_width_h		= screen_width/2;
static final int screen_height		= 900;
static final int screen_height_h	= screen_height/2;
static final int ground_height		= 80;

// Physics
public static final float DAMPING = 0.995;
Gravity gravity	= new Gravity(new PVector(0f, 0.2f));// 0.2f
Drag drag		= new Drag(2.0f, 0.1f);// Currently Drag does NOT depend on the size/surface area of the particle

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
boolean keyLog[];
// int score = 0;
public static final int START_MENU	= 0;// 0 Start Menu
public static final int GAMEPLAY	= 1;// 1 Gameplay
public static final int PAUSE_MENU	= 2;// 2 Pause Menu
int gameState;
static final int numOptions			= 3;
static final int optionWidth		= 200;
static final int optionHeight		= 50;
MenuOption options[];

void settings() {
	size(screen_width, screen_height);
}

void setup() {
	gameState = 0;
	keyLog = new boolean[numKeys];
	for (int i = 0; i < numKeys; i++) {
		keyLog[i] = true;// Set all keys to ready to be pressed
	}
	// Text Font
	fill(255);
	textAlign(CENTER, CENTER);
	textSize(20);
	textFont(createFont("Serif", 20));

	setupMenu();
	setupGame();// Should the game be set up here? Make a loading screen?
}

void setupMenu() {
	options = new MenuOption[numOptions];
	options[0] = new MenuOption("Play",		screen_width_h - optionWidth/2, screen_height_h - 200, optionWidth, optionHeight);
	options[1] = new MenuOption("Restart",	screen_width_h - optionWidth/2, screen_height_h - 100, optionWidth, optionHeight);
	options[2] = new MenuOption("Exit",		screen_width_h - optionWidth/2, screen_height_h + 200, optionWidth, optionHeight);
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
	
	// Meteors // This is Test Meteor
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
		(int) random(30, 70), explosions));
	}
}

void mousePressed() {
	for (int i = 0; i < numOptions; i++) {
		if (options[i].isMouseOver()) {
			options[i].handleMouseClick();
		}
	}
}

void keyPressed() {
  // Not using Switch Statement b/c two buttons can be pressed at once
	if (key == '1' && keyLog[0]) {
		keyLog[0] = false;
		ballistae[0].fireBomb();
	}
	if (key == '2' && keyLog[1]) {
		keyLog[1] = false;
		ballistae[1].fireBomb();
	}
	if (key == '3' && keyLog[2]) {
		keyLog[2] = false;
		ballistae[2].fireBomb();
  	}
	if (key == ' ' && keyLog[3]) {
		keyLog[3] = false;
		for (int i = 0; i < bombs.size(); i++) {
			bombs.get(i).explode(); // Have to explode them all. Bomb removal is early on the game draw list. Don't do it here.
		}
	}
	if (key == 'm' && keyLog[4]) {
		keyLog[4] = false;
		spawnWave(6);
	}
	if (keyCode == ENTER && gameState != START_MENU) {
		// Cannot Pause Game while in Start Menu
		gameState = ((gameState + 1) % 3) + 1;// Swaps between 1 and 2
	}
}

void keyReleased() {
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
  	if (key == 'm') {
  	  keyLog[4] = true;
  	}
}

void draw() {
	switch (gameState) {
		case START_MENU:// Start Menu
			drawStartMenu();
		break;

		case GAMEPLAY:// Gameplay
			drawGameplay();
		break;

		case PAUSE_MENU:// Pause Menu
			drawPauseMenu();
		break;

		default :
			drawStartMenu();
		break;	
	}
}

void drawStartMenu() {
	background(0,0,0);// Black
	for (int i = 0; i < numOptions; i++) {
		options[i].draw();
	}
	if (options[0].mouseOver) {
		gameState = 1;
		options[0].mouseOver = false;
		return;
	}
	if (options[1].mouseOver) {
		gameState = 1;
		options[1].mouseOver = false;
		setupGame();// Restarts the game
		return;
	}
	if (options[2].mouseOver) {
		exit();
		return;
	}
}
void drawGameplay() {
	// Graphics
	background(47, 150, 173);
	// Ground
	fill(24, 56, 1);
	rect(0, screen_height - ground_height, screen_width, ground_height);
	// Cities
	for (int i = 0; i < nCities; i++) {
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
				bomb.handleCollisionCirlce(meteor);
				break;// Assumes no other collisions will happen
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
		Explosion explosion = explosions.get(i);// For Readability
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
void drawPauseMenu() {
	fill(0,0,0, 100);
	rect(0,0, screen_width, screen_height);
}
