class ExpandRing {
  float radius;
  float rate;
  float size;
  boolean stall;
  boolean expanding;

  ExpandRing() {
    //starting radius
    radius = 0;
    stall = false;
    expanding = true;
    size = 3;
  }

  void display() {
    //center dot
    fill(255);
    rect(origin.x, origin.y, size-1, size-1);

    for (int i = 0; i < 1000; i++) {
      //generate random angle
      var angle = Math.random()*Math.PI*2;
      fill(255);

      //circle perimeter coords
      float x = origin.x + (float)Math.cos(angle)*radius;
      float y = origin.y + (float)Math.sin(angle)*radius;

      //ring point
      rect(x, y, size, size);

      //reverse growth at specified radius
      if (radius >= width/2) {
        rate = -growth;
        expanding = false;
      } else if (radius <= 0) {
        rate = growth;
        expanding = true;
      }
    }
    //stall ring expansion for one tick
    if (stall) {
      stall = false;
    } else {
      //update radius
      radius += rate;
    }
  }

  void pulse(float sizeMult) {
    //create pulse object
    pulse.add(new Pulse(origin, radius, sizeMult));
    //trigger stall
    stall = true;
  }
}
