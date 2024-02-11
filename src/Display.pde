// Display.pde
class Display {
    int rgb[];
    int textSize;

    Display(int r, int g, int b) {
        this.rgb = new int[3];
        this.rgb[0] = r;
        this.rgb[1] = g;
        this.rgb[2] = b;
    }

}