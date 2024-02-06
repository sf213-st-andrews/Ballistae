
public static final float GRAVITY = 0.2f;


// Physics phys;
// Graphics gph;

final int screen_width	 = 1200;
final int screen_height	 = 900;

City cities[];
ArrayList<Bomb> bombs;// Pool of ammunition
Meteor meteors[];

int score = 0;

void settings() {
    size(screen_width, screen_height);
}

void setup() {
    // Bombs
    bombs = new ArrayList<Bomb>();
    // Cities & Ballistae
    cities = new City[3];
    cities[0] = new City(300 - 50, screen_height - 40, bombs);
    cities[1] = new City(600 - 50, screen_height - 40, bombs);
    cities[2] = new City(900 - 50, screen_height - 40, bombs);
    
    // Meteors
    meteors = new Meteor[12];
    for (int i = 0; i < 12; i++) {
        meteors[i] = new Meteor(new PVector((screen_width/12)*i + 10, 30), new PVector(0,2));
    }
}

void mousePressed() {
    if (mouseButton == LEFT) {
        for(int i = 0; i < cities.length; ++i) {
            cities[i].ballista.fireBomb(new PVector(mouseX, mouseY));
	    }
    }
    if (mouseButton == RIGHT) {
        for(int i = 0; i < bombs.size(); ++i) {
            bombs.get(i).explode();
	    }
    }
}

void draw() {
    // Graphics
    background(47, 150, 173);// Sky Color
    // Cities
    for(int i = 0; i < cities.length; ++i) {
        cities[i].draw();
	}
    // Bombs
    for(int i = 0; i < bombs.size(); ++i) {
        bombs.get(i).draw();
	}
    // Meteors
    for(int i = 0; i < meteors.length; ++i) {
        meteors[i].draw();
	}
}