
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
    meteors = new Meteor[4];
    for (int i = 0; i < 4; i++) {
        meteors[i] = new Meteor(new PVector((screen_width/4)*i + 15, 0),
         new PVector((float) random(-10, 10), (float) random(0, 20)), 
         (int) random(20, 50));
    }
}

void mousePressed() {
    if (mouseButton == LEFT) {
        for(int i = 0; i < cities.length; i++) {
            cities[i].ballista.fireBomb(new PVector(mouseX, mouseY));
	    }
    } else {
        for(int i = 0; i < bombs.size(); i++) {
            bombs.get(i).explode();
	    }
    }
}

void draw() {
    // Graphics
    background(47, 150, 173);// Sky Color
    // Cities
    for(int i = 0; i < cities.length; i++) {
        cities[i].draw();
	}
    // Bombs
    for(int i = bombs.size()-1; i >= 0; i--) {
        // Start from last to first so removing isn't a problem
        bombs.get(i).draw();
        if (bombs.get(i).exploded) {
            if (bombs.get(i).getExplosion().lifetime <= 0){ 
                bombs.remove(i);
            }
        }
	}
    // Meteors
    for(int i = 0; i < meteors.length; i++) {
        meteors[i].draw();
	}
}