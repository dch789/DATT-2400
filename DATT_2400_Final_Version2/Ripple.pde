class Ripple {
  int cols, rows;
  float[][] current;
  float[][] previous;
  float[][] smoothed;
  float[][] velocity;
  float[][] newHeight;
  float dampening = .98;
  int drift; //Xoffset for underwater oscillation effect

  Ripple() {
    cols = width;
    rows = height;

    current = new float[cols][rows];
    previous = new float[cols][rows];
    smoothed = new float[cols][rows];
    velocity = new float[cols][rows];
    newHeight = new float[cols][rows];

    //Initialize the ripple array
    for (int x = 1; x < cols-1; x++) {
      for (int y = 1; y < rows-1; y++) {
        current[x][y] = 0;
        previous[x][y] = 0;
      }
    }
  }

  void display() {
    loadPixels();

    //random ripples
    //if (random(1) > .92) rippleAt(random(2, width-2), random(2, height-2));

    //Process Water Ripple
    for (int x = 1; x < cols-1; x++) {
      for (int y = 1; y < rows-1; y++) {
        if (obstacles.isWater(x, y)) {
          current[x][y] = (
            previous[x-1][y] +
            previous[x+1][y] +
            previous[x][y-1] +
            previous[x][y+1])*.5 - current[x][y];
          current[x][y] = current[x][y] * dampening;

          var velocity = -current[x][y];

          var smoothed =
            (
            previous[x-1][y]
            + previous[x+1][y]
            + previous[x][y-1]
            + previous[x][y+1]
            )
            / 4;

          newHeight[x][y] = smoothed*2 + velocity;
          newHeight[x][y] = newHeight[x][y] * dampening;
          newHeight[x][y] = newHeight[x][y] - newHeight[x][y]/4;

          float Xoffset = newHeight[x-1][y] - newHeight[x+1][y];
          float Yoffset = newHeight[x][y-1] - newHeight[x][y+1];

          float shading = Xoffset;
          shading = constrain(shading, -255, 255)/10;

          if (random(1) > .9) drift = int(map(noise(x * .002, y * .001 + frameCount * .015), 0, 1, -20, 20));

          color texture = underwater.get(int(x + Xoffset) + drift, int(y + Yoffset));

          //var r = red(texture) + shading;
          //var g = green(texture) + shading;
          //var b = blue(texture) + shading;

          //color pixel = color(r, g, b);
          color pixel = texture + int(shading);

          int index = x + y * cols;
          pixels[index] = pixel;
        }
      }
    }
    updatePixels();

    //Swap the buffers
    float[][] temp = previous;
    previous = current;
    current = temp;
  }

  void rippleAt(float x_, float y_) {
    int x0 = (int)x_;
    int y0 = (int)y_;
    int peakValue = (int)random(100, width|height);
    int radius = round(random(2, 6));

    for (int x = x0-radius; x < x0+radius; x+=2) {
      if (x < 1 || x > width-1) continue;
      for (int y = y0-radius; y < y0+radius; y+=2) {
        float distance = dist(x0, y0, x, y);
        if (y < 1 || y > height-1 || distance > radius) continue;
        previous[x][y] = map(distance, 0, radius, peakValue/2, peakValue);
      }
    }
  }
}
