int missileX, missileY; // Missile position
int obstacleX, obstacleY; // Obstacle position
int score = 0;

void setup() {
    size(400, 400);
    missileX = width / 2;
    missileY = height - 30;
    obstacleX = (int) random(width);
    obstacleY = 0;
}

void draw() {
    background(0);
    
    //Draw missile
    fill(0, 0, 255);
    rectMode(CENTER);
    rect(missileX, missileY, 20, 40);
    
    //Draw obstacle
    fill(255, 0, 0);
    rect(obstacleX, obstacleY, 30, 30);
    
    //Move obstacle
    obstacleY += 5;
    
    //Check collision
    if(dist(missileX, missileY, obstacleX, obstacleY) < 25) {
        gameOver();
}
    
    //Check if obstacle is out of screen
    if(obstacleY > height) {
        obstacleY = 0;
        obstacleX = (int) random(width);
        score++;
}
    
    //Display score
    fill(0);
    textSize(20);
    text("Score: " + score, 10, 30);
}

void keyPressed() {
    if(key == ' ') {
        // Shoot missile when spacebar is pressed
        // For simplicity, the missile will move up without user control
        missileY -= 20;
}
}

void mouseMoved() {
    //Move missile with the mouse
    missileX = mouseX;
}

void gameOver() {
    background(255, 0, 0);
    fill(255);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Game Over\nYour Score: " + score, width / 2, height / 2);
    noLoop(); // Stop the game loop
}
