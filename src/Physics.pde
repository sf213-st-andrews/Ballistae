// Physics.pde

class Physics {
    float updateMissileY(float missileY) {
    // Your missile physics logic here
    return missileY - 1;  // For simplicity, the missile moves up
    }

    float updateObstacleY(float obstacleY) {
    // Your obstacle physics logic here
    return obstacleY + 5;  // For simplicity, the obstacle falls down
    }
}
