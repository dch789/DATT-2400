class Pulse {

  PVector origin;
  float radius;
  float size;
  float alpha;
  float sizeMult;
  float fgSize;

  Pulse(PVector origin, float radius, float sizeMult) {
    this.origin = new PVector(origin.x, origin.y);
    this.radius = radius;
    this.sizeMult = sizeMult;

    size = 7;
    alpha = 30;
    fgSize = 3;
  }

  void display() {

    bgPulse();
    //foreground pulse effect lasts according to current bg pulse alpha
    if (alpha > 8) {
      fgPulse();
      //fgSize += 0.1;
    }
    //delete object from list after fade is complete
    if (alpha < 0) {
      pulse.remove(this);
    }
  }

  //background pulse effect
  void bgPulse() {
    //center dot
    fill(150, 200, 255, alpha + 50);
    rect(origin.x, origin.y, 5, 5);

    for (int i = 0; i < 1000; i++) {
      //generate random angle
      var angle = Math.random()*Math.PI*2;
      fill(150, 200, 255, alpha);

      //circle perimeter coords
      float x = origin.x + (float)Math.cos(angle)*radius;
      float y = origin.y + (float)Math.sin(angle)*radius;

      //ring point - always bigger than expRing's size
      if (size * sizeMult > expRing.size + 0.1) {
        rect(x, y, size * sizeMult, size * sizeMult);
      }
      else {
        rect(x, y, expRing.size + 0.1, expRing.size + 0.1);
      }
    }
    size += 1;
    alpha -= 2;
  }

  //foreground pulse effect
  void fgPulse() {
    for (int i = 0; i < 1000; i++) {
      //generate random angle
      var angle = Math.random()*Math.PI*2;
      fill(150, 200, 255, 255);

      //circle perimeter coords
      float x = origin.x + (float)Math.cos(angle)*radius;
      float y = origin.y + (float)Math.sin(angle)*radius;

      //ring point
      rect(x, y, fgSize, fgSize);
    }
  }
}
