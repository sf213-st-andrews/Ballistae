
public static final float GRAVITY = 0.2f;


// Physics phys;
// Graphics gph;

final int screen_width	 = 1200;
final int screen_height	 = 900;

City cities[];
Ballista ballistae[];
ArrayList<Bomb> bombs;			// Pool of ammunition
ArrayList<Explosion> explosions;// Pool of explosions

Meteor meteors[];

int score = 0;

void settings() {
    size(screen_width, screen_height);
}

void setup() {
    // ArrayList initialization
    bombs = new ArrayList<Bomb>();
    explosions = new ArrayList<Explosion>();
    
    // Cities
    cities = new City[6];
    int cSect = screen_width / cities.length; // Divide into sections
    int scSect = cSect / cities.length;       // For Offset to make the sections neat
    for (int i = 0; i < cities.length; i++) {
        cities[i] = new City((cSect * i) + scSect, screen_height - 40);
    }
    // Ballistae
    ballistae = new Ballista[5];
    for(int i = 0; i < ballistae.length; i++) {
        ballistae[i];
    }
    
    // Meteors
    meteors = new Meteor[4];
    for (int i = 0; i < 4; i++) {
        meteors[i] = new Meteor(new PVector((screen_width / 4) * i + 15, 0),
            newPVector((float) random( -10, 10),(float) random(0, 20)),(int) random(20, 50));
    }
}

void mousePressed() {
    if (mouseButton == LEFT) {
        for (int i = 0; i < ballistae.length; i++) {
            ballistae[i].fireBomb(new PVector(mouseX, mouseY));
		}
    } else {
        for (int i = 0; i < bombs.size(); i++) {
            bombs.get(i).explode();
        }
    }
}

void draw() {
    // Graphics
    background(47, 150, 173);// Sky Color
    // Cities
    for (int i = 0; i < cities.length; i++) {
        cities[i].draw();
    }
    // Bombs
    for (int i = bombs.size() - 1; i >= 0; i--) {
        // Start from last to first so removing isn't a problem
        bombs.get(i).draw();
        if (bombs.get(i).exploded) {
            if (bombs.get(i).getExplosion().lifetime <= 0) { 
                bombs.remove(i);
            }
        }
    }
    // Meteors
    for (int i = 0; i < meteors.length; i++) {
        meteors[i].draw();
    }
    // System.out.println("Bombs size: " + bombs.size());
}