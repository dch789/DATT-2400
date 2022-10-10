class Leaves {
  private PVector originPos;

  private float size;
  private float speedX;
  private float speedY;

  private int green;
  private int redblue;
  private int radMax;

  private boolean flowered;

  private ArrayList<PVector> flower;

  private PGraphics foliage;

  Leaves(PVector origin, float speed, Branch br) {
    //origin values
    originPos = origin;

    //Leaves values
    speedX = speed;
    speedY = speed;
    size = 10;
    //max radius of leaves
    radMax = 85;
    //colours
    green = int( random(140, 160) );
    redblue = 105;
    //list to record flower positions
    flower = new ArrayList<>();
  }
  
    Leaves(PVector origin, float speed, Split sp) {
    //origin values
    originPos = origin;

    //Leaves values
    speedX = speed;
    speedY = speed;
    size = 10;
    //max radius of leaves
    radMax = 85;
    //colours
    green = int( random(140, 160) );
    redblue = 105;
    //list to record flower positions
    flower = new ArrayList<>();
  }

  void display() {

    //leaves expand around origin
    if (speedX < radMax) {

      float randRed = int( random(redblue - 10, redblue + 10) );
      float randBlue = int( random(redblue - 10, redblue + 10) );
      float randGreen = int( random(green, green) );

      fill(randRed, randGreen, randBlue);
      //foliage.fill(randRed, randGreen, randBlue);

      float x = originPos.x + int( random(-speedX, speedX) );
      float y = originPos.y + int( random(-speedY, speedY) );

      rect(x, y, size, size);
      //foliage.rect(x, y, size, size);

      speedX = speedX + 0.2;
      speedY = speedY + 0.15;

      size = random(5, 20);

      if (int( random(0, 200) ) == 1) {
        flower.add(new PVector(x, y));
      }
    }
    //if not flowered yet, loop list of flower pos
    else if (flowered != true) {
      for (int i = 0; i < flower.size(); i++) {

        float x = flower.get(i).x;
        float y = flower.get(i).y;

        //draw petals around flower pos
        for (int j = 0; j < 5; j++) {

          float x2 = x + random(-4, 4);
          float y2 = y + random(-4, 4);

          fill(255, 235, 235);
          //foliage.fill(255, 235, 235);

          rect(x2, y2, 8, 8);
          //foliage.rect(x2, y2, 8, 8);
        }
        //draw center of flower
        fill(255, 204, 0);
        //foliage.fill(255, 204, 0);

        rect(x, y, 4, 4);
        //foliage.rect(x, y, 4, 4);
      }
      flowered = true;
    }
    //completed image of foliage
    else {
      //foliage.endDraw();
      //background(51);
      //image(foliage, 0, 0);
      //tint(155, 0, 0);
    }
  }
}
