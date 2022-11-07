class Line {
  PVector origin;
  PVector end;
  float radius;
  float weight;
  double angle;
  color startCol;
  color endCol;
  int tick;

  Line(PVector origin, float radius) {
    this.origin = new PVector(origin.x, origin.y);
    this.radius = radius;

    weight = 5;
    startCol = color(150, 200, 255);
    endCol = color(255);
    //keep track of number of times color has been adjusted
    tick = 0;

    //generate line angle
    angle = Math.random()*Math.PI*2;
  }

  void display() {
    if (random(1) > 0.5) {
      angle += 0.01;
    } else {
      angle -= 0.01;
    }

    //generate end point
    float x = origin.x + (float)Math.cos(angle)*radius;
    float y = origin.y + (float)Math.sin(angle)*radius;
    end = new PVector(x, y);

    if (tick > 6) {
      stroke(255 - random(100), 120);
    } else {
      stroke(startCol);
      startCol = lerpColor(startCol, color(255 - random(100), 120), 0.1);
      tick++;
    }

    strokeWeight(random(weight));
    line(origin.x, origin.y, end.x, end.y);

    //reset stroke
    noStroke();
  }
}
