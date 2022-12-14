class Obstacles {
  PImage bounds;
  PImage overlay;
  PGraphics scan;
  PGraphics foreground;

  Obstacles() {
    bounds = loadImage("pond bounds.png");
    overlay = loadImage("pond outline.png");

    scan = createGraphics(width, height);
    scan.beginDraw();
    scan.image(bounds, 0, 0, width*1.1, height);
    scan.endDraw();

    foreground = createGraphics(width, height);
    foreground.beginDraw();
    foreground.image(overlay, 0, 0, width*1.1, height);
    foreground.endDraw();
  }

  void display () {
    image(scan, 0, 0);
    image(foreground, 0, 0);
  }

  void underwater() {
    underwater.beginDraw();
    underwater.image(foreground, 0, 0);
    underwater.endDraw();
  }

  boolean isWater(int x, int y) {
    var index = x + y * width;
    //prevent out of bounds error
    if (index > 375000) return false;
    
    if (scan.pixels[index] == 0) {
      return true;
    } else {
      return false;
    }
  }
}
