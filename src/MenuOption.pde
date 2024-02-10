// MenuOption.pde
class MenuOption {
	String label;
	float x, y, w, h;
	boolean mouseOver;

	MenuOption(String label, float x, float y, float w, float h) {
		this.label	= label;
		this.x		= x;
		this.y		= y;
		this.w		= w;
		this.h		= h;
		this.mouseOver = false;
	}

	void draw() {
    	fill(mouseOver ? color(200) : 255);
    	rect(x, y, w, h);
    	fill(0);
    	textAlign(CENTER, CENTER);
    	text(label, x + w / 2, y + h / 2);
	}

	boolean isMouseOver() {
    	mouseOver = mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
    	return mouseOver;
	}

	void handleMouseClick() {
		//
	}
}