// Graphics
final int screen_width			= 1200;
final int screen_height			= 900;
final int screen_width_half		= screen_width/2;
final int ground_height			= 80;
final int ground_height_half	= ground_height/2;

// Physics
public static final float GRAVITY = 0.2f;
Gravity gravity = new Gravity(new Gravity(new PVector(0f, 0.2f)));

// Registry


// Objects
City cities[];
Ballista ballistae[];
ArrayList<Bomb> bombs;			// Pool of ammunition
ArrayList<Explosion> explosions;// Pool of explosions
Meteor meteors[];

// int score = 0;

void settings() {
	size(screen_width, screen_height);
}

void setup() {
	// Graphics
	rectMode(CENTER);
	// ArrayList initialization
	bombs = new ArrayList<Bomb>();
	explosions = new ArrayList<Explosion>();
	// Cities
	cities = new City[6];
	int cSect	= screen_width / cities.length; // Divide into sections
	int cSect_h	= cSect / 2;       				// For Offset to make the sections neat
	for (int i = 0; i < cities.length; i++) {
		cities[i] = new City((cSect * i) + cSect_h, screen_height - 20);
	}
	// Ballistae
	ballistae = new Ballista[3];
	int bSect	= screen_width / ballistae.length; // Divide into sections
	int bSect_h	= bSect / 2;       				// For Offset to make the sections neat
	for(int i = 0; i < ballistae.length; i++) {
		ballistae[i] = new Ballista((bSect * i) + bSect_h, screen_height - 70, bombs, explosions);
	}
	
	// Meteors
	meteors = new Meteor[4];
	for (int i = 0; i < 4; i++) {
		meteors[i] = new Meteor(new PVector((screen_width / 4) * i + 15, 0), new PVector((float) random( -10, 10),(float) random(0, 20)),(int) random(20, 50), explosions);
	}
}

void mousePressed() {
	if (mouseButton == LEFT) {
		for (int i = 0; i < ballistae.length; i++) {
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
		if (bombs.size() > 0) {bombs.get(bombs.size() - 1).explode();}
	}
}

void draw() {
	// Graphics
	background(47, 150, 173);// Sky Color: 47, 150, 173
	// Ground
	fill(24, 56, 1);
	rect(screen_width_half, screen_height - ground_height_half, screen_width, ground_height);
	// Cities
	for (int i = 0; i < cities.length; i++) {
		cities[i].draw();
	}
	// Ballistae
	for (int i = 0; i < ballistae.length; i++) {
		ballistae[i].draw();
	}
	// Meteors
	for (int i = 0; i < meteors.length; i++) {
		meteors[i].draw();
	}
	// Bombs
	for (int i = bombs.size() - 1; i >= 0; i--) {
		// Start from last to first so removing isn't a problem
		bombs.get(i).draw();
		if (bombs.get(i).exploded) {
			bombs.remove(i);
		}
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