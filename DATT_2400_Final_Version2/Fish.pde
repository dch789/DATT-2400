class Fish {
  color col;

  float sizeMin = 5;
  float sizeMax = 10;
  float size;

  float speed;
  float speedMult = 5;

  float dir;
  float lastDir;

  float lastFrame;
  float deltaTime;
  float fleeTime = 3; //in seconds

  boolean wag;
  boolean isFleeing;

  PVector pos;
  PVector startPos;
  PVector movePos;

  Fish() {
    //spawn in random position in water
    pos = new PVector(random(width), random(height));
    while (!obstacles.isWater(int(pos.x), int(pos.y))) {
      pos = new PVector(random(width), random(height));
    }
    movePos = pos;
    startPos = pos;

    //spawn in random size, direcion, and color
    //dir = radians(random(0, 360));
    size = random(sizeMin, sizeMax);
    col = color(random(200, 255), random(0, 200), 0);
    speed = random(0.8, 1);
  }

  void display() {
    drawBody(pos.x, pos.y, size);
    move();
  }

  void move() {
    if (flee()) {
      if (isFleeing) {
        deltaTime = 0;
      } else {
        speed *= speedMult;
      }
      isFleeing = true;
    }
    if (isFleeing) {
      var currentFrame = millis();
      deltaTime += currentFrame - lastFrame;
      if (deltaTime >= fleeTime*1000) {
        deltaTime = 0;
        speed /= speedMult;
        isFleeing = false;
      }
      lastFrame = millis();
    }
    //fish has reached destination
    if (pos.x == movePos.x && pos.y == movePos.y) {

      //look for new position to move to
      movePos = new PVector(constrain(random(pos.x - 50, pos.x + 50), 0, width), constrain(random(pos.y - 50, pos.y + 50), 0, height));

      //generate new position if not valid
      while (!obstacles.isWater(int(movePos.x), int(movePos.y))) {
        movePos = new PVector(constrain(random(pos.x - 50, pos.x + 50), 0, width), constrain(random(pos.y - 50, pos.y + 50), 0, height));
      }
      //set new starting pos
      startPos = new PVector(pos.x, pos.y);
    }
    //facing direction
    lastDir = dir;
    dir = getAngle(pos.x, pos.y, movePos.x, movePos.y);

    //move over time
    if (abs(pos.x - movePos.x) < speed) {
      pos.x = movePos.x;
    } else if (pos.x < movePos.x) {
      pos.x += speed;
    } else if (pos.x > movePos.x) {
      pos.x -= speed;
    }
    if (abs(pos.y - movePos.y) < speed) {
      pos.y = movePos.y;
    } else if (pos.y < movePos.y) {
      pos.y += speed;
    } else if (pos.y > movePos.y) {
      pos.y -= speed;
    }

    //DEBUG - plot destination
    //underwater.beginDraw();
    //underwater.ellipse(movePos.x, movePos.y, 5, 5);
    //underwater.endDraw();
  }

  void drawBody(float x, float y, float size) {

    underwater.beginDraw();
    underwater.noStroke();
    underwater.fill(col);

    for (float i = 0; i < 5; i++) {
      //ellipse shrinks further down the line
      var tailSize = size - (size * 0.1) * i;

      //prevent negative error
      if (tailSize < 0) tailSize = 0;

      //tail direction at angle 0
      var tailX = x + (i * (tailSize/1.7));
      var tailY = y;

      //create wag
      //if (wag) {
      //  wag = false;
      //  dir += 0.1;
      //} else {
      //  wag = true;
      //  dir -= 0.1;
      //}

      var rads = radians(dir);

      //tail direction rotated
      var rotateX = x + (tailX - x) * cos(rads) + (tailY - y) * sin(rads);
      var rotateY = y - (tailX - x) * sin(rads) + (tailY - y) * cos(rads);

      underwater.ellipse(rotateX, rotateY, tailSize - i, tailSize -i);
    }
    underwater.endDraw();
  }

  boolean flee() {
    //player is splashing
    if (splashing == true) {
      //distance based on size of fish
      if (abs(dist(pos.x, pos.y, mouseX, mouseY)) < (3.5 * size)) {
        //println("close");
        var mousePos = new PVector(mouseX, mouseY);
        dir = getAngle(pos.x, pos.y, mousePos.x, mousePos.y);
        return true;
      }
    }
    return false;
  }

  float getAngle(float pX1, float pY1, float pX2, float pY2) {
    return 180 - atan2(pY2 - pY1, pX2 - pX1)* 180/PI;
  }
}
