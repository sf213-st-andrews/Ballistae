// Display.pde
class Display {
	int rgb[];
	int textSize;
	float position[];
	String text;

	Display(int r, int g, int b, int textSize, String text, float x, float y) {
		this.rgb = new int[3];
		this.rgb[0] = r;
		this.rgb[1] = g;
		this.rgb[2] = b;

		this.textSize = textSize;
		this.text = text;

		this.position = new float[2];
		this.position[0] = x;
		this.position[1] = y;
	}
	Display(String text, float x, float y) {
		this(255,255,255, 20, text, x, y);
	}

	void updateText(String text) {
		this.text = text;
	}

	void draw(boolean hasShadow) {
		textSize(textSize);
		
		if (hasShadow) {
			fill(0,0,0);
			text(text, position[0]+3, position[1]);
		}
		
		fill(rgb[0], rgb[1], rgb[2]);
		text(text, position[0], position[1]);

	}
}