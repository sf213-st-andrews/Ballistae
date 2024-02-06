// City.pde

class City {
	// City Properties
	PVector position;
	PVector area;

	// Ballistae
	Ballistae ballista;
	
	// Constructor
	City(float x, float y) {
        this.position = new PVector(x, y);
		this.area = new PVector(100, 40);
		this.ballista = new Ballistae(this.position);
	}

	void draw() {
		fill(100, 100, 100);// 13, 26, 33
		rect(position.x, position.y, area.x, area.y);
		// Call here not in Main
		ballista.draw();
	}
}

