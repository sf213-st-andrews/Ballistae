// Graphics.pde

void drawCity(float x, float y, float w, float h) {
  fill(0, 0, 255);
  rect(x, y, w, h);
}

void drawMissile(float x, float y) {
  fill(0, 0, 255);
  rect(x, y, 20, 40);
}

void drawObstacle(float x, float y) {
  fill(255, 0, 0);
  rect(x, y, 30, 30);
}
