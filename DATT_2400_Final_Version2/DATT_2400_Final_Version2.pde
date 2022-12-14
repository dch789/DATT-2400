PImage water;
PImage background;
PGraphics underwater;

int numOfFish = 11;

Ripple ripple;
Obstacles obstacles;
Fish[] fish;

boolean splashing;

void settings() {
  background = loadImage("water2.png");
  size(750, 500);
}

void setup() {
  //setup background image
  image(background, 0, 0, width, height);
  save("screen.tif");
  underwater = createGraphics(width, height);

  //construct objects
  obstacles = new Obstacles();
  ripple = new Ripple();
  fish = new Fish[numOfFish];
  for (int i = 0; i < numOfFish; i++) {
    fish[i] = new Fish();
  }
}

void draw() {
  //refresh underwater image
  refreshBG();


  //display objects
  ripple.display();
  obstacles.display();

  splashing = false;
}

void mousePressed() {
  ripple.rippleAt(mouseX, mouseY);
  splashing = true;
}

void mouseDragged() {
  ripple.previous[mouseX][mouseY] = 999;
  splashing = true;
}

//refresh background image
void refreshBG() {
  underwater.beginDraw();
  //display image - scaled to width and height
  underwater.image(background, 0, 0, width, height);
  obstacles.underwater();
  for (int i = 0; i < numOfFish; i++) {
    fish[i].display();
  }
  underwater.endDraw();
}
