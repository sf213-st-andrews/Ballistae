Physics phys;
// Graphics gph;

City cities[];

final int screen_width	 = 800;
final int screen_height	 = 600;

int score = 0;

void settings() {
    size(screen_width, screen_height);
}

void setup() {
    
    cities = new City[3];
    cities[0] = new City(150, screen_height - 40);
    cities[1] = new City(350, screen_height - 40);
    cities[2] = new City(550, screen_height - 40);
}

void mousePressed() {
    //Check if the mouse is within a specific region
    for(int i = 0; i < cities.length; ++i) {
        cities[i].ballista.fireRock(new PVector(mouseX, mouseY));
	}
}

void draw() {
    background(47, 150, 173);// Sky Color
    // Cities
    // gph.drawCity(cities[0]);
    for(int i = 0; i < cities.length; ++i) {
        cities[i].draw();
	}
}