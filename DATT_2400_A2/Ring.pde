class Ring {
  float radius;
  float alpha;
  float triggerDist;
  float sizeMult;
  float sizeRange;
  boolean trigger;
  Line ringLine;

  Ring() {
    //generate random radius
    radius = random(1, width/2);
    alpha = 5;
    triggerDist = 15;
    trigger = false;
    sizeMult = (radius/120);
    sizeRange = 20;
  }

  void display() {
    //check if expRing radius is larger than ring radius
    if (expRing.radius >= radius) {

      //trigger pulse if change
      if (trigger == false) {
        trigger = true;
        //generate new ring line and pulse
        ringLine = new Line(origin, radius);
        expRing.pulse(sizeMult);
      }

      for (int i = 0; i < 1000; i++) {
        //generate random angle
        var angle = Math.random()*Math.PI*2;
        //generate colour
        fill(200 - random(100));

        //circle perimeter coords
        float x = origin.x + (float)Math.cos(angle)*radius;
        float y = origin.y + (float)Math.sin(angle)*radius;

        //ring point
        rect(x, y, 3, 3);
      }
      ringLine.display();
    }
    //expRing is smaller than ring
    else {

      //trigger pulse if change
      if (trigger == true) {
        trigger = false;
        //generate new pulse
        expRing.pulse(sizeMult);
      }

      //temp alpha value
      float a;
      //distance between expanding ring and current ring
      float distance = radius - expRing.radius;
      //size range
      float range = sizeRange;

      //behaviour if expRing expanding
      if (expRing.expanding) {

        //trigger behaviour
        if (distance <= triggerDist) {
          a = alpha + 100 * (triggerDist - distance)/triggerDist;
          range = range - ((range - 3) * (triggerDist - distance)/triggerDist);
        } else {
          a = alpha;
        }

        for (int i = 0; i < 1000; i++) {
          //generate random angle
          var angle = Math.random()*Math.PI*2;
          //generate colour
          fill(255 - random(100), a);
          //generate size (min: expRing size, max: range)
          float size = random(expRing.size, range) * sizeMult;

          if (size < 3) {
            size = 3;
          }

          //circle perimeter coords
          float x = origin.x + (float)Math.cos(angle)*radius;
          float y = origin.y + (float)Math.sin(angle)*radius;

          //ring point
          rect(x, y, size, size);
        }
      }
      //behaviour if expRing shrinking
      else {

        //trigger behaviours
        if (distance <= triggerDist) {
          a = alpha + 100 * (triggerDist - distance)/triggerDist;
        } else {
          a = alpha;
        }

        for (int i = 0; i < 1000; i++) {
          //generate random angle
          var angle = Math.random()*Math.PI*2;
          //generate colour
          fill(255 - random(100), a);
          //generate size (min: expRing size, max: range)
          float size = random(expRing.size, range) * sizeMult;

          if (size < 3) {
            size = 3;
          }

          //circle perimeter coords
          float x = origin.x + (float)Math.cos(angle)*radius;
          float y = origin.y + (float)Math.sin(angle)*radius;

          //ring point
          rect(x, y, size, size);
        }
      }
    }
  }
}
