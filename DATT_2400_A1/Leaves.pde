class Leaves {
  private PVector originPos;
  private Branch originBr;
  private Split originSp;

  private float size;
  private float speedX;
  private float speedY;

  private int green;
  private int redblue;
  private int radMax;

  private boolean leavesFin;
  private boolean flowered;

  private ArrayList<PVector> flower;

  Leaves(PVector origin, float speed, Branch br) {
    //origin values
    originPos = origin;
    originBr = br;

    //Leaves values
    speedX = speed;
    speedY = speed;
    size = 10;
    //increased radius if branch
    radMax = int( random(100, 130) );
    //colours
    green = leafCol;
    redblue = 105;
    leavesFin = false;
    //list to record flower positions
    flower = new ArrayList<>();
  }

  Leaves(PVector origin, float speed, Split sp) {
    //origin values
    originPos = origin;
    originSp = sp;

    //Leaves values
    speedX = speed;
    speedY = speed;
    size = 10;
    //max radius of leaves
    radMax = int( random(80, 90) );
    //colours
    green = leafCol;
    redblue = 105;
    leavesFin = false;
    //list to record flower positions
    flower = new ArrayList<>();
  }

  void display() {

    resetMatrix();
    tree.resetMatrix();
    //copy matrix of origin object
    if (originBr != null) {
      originBr.setMatrix();
    } else if (originSp != null) {
      originSp.setMatrix();
    }

    //leaves expand around origin
    if (speedX < radMax) {

      float randRed = int( random(redblue - 10, redblue + 10) );
      float randBlue = int( random(redblue - 10, redblue + 10) );

      fill(randRed, green, randBlue);
      tree.fill(randRed, green, randBlue);

      float x = originPos.x + int( random(-speedX, speedX) );
      float y = originPos.y + int( random(-speedY, speedY) );

      rect(x, y, size, size);
      tree.rect(x, y, size, size);

      //extra elements if branch origin
      if (originBr != null) {
        randRed = int( random(redblue - 10, redblue + 10) );
        randBlue = int( random(redblue - 10, redblue + 10) );

        fill(randRed, green, randBlue);
        tree.fill(randRed, green, randBlue);
        x = originPos.x + int( random(-speedX, speedX) );
        y = originPos.y + int( random(-speedY, speedY) );

        rect(x, y, size, size);
        tree.rect(x, y, size, size);

        if (int( random(0, 200) ) == 1) {
          flower.add(new PVector(x, y));
        }

        //smaller radius for extra leaves
        if (speedX < radMax - 40) {
          randRed = int( random(redblue - 10, redblue + 10) );
          randBlue = int( random(redblue - 10, redblue + 10) );

          //left
          fill(randRed, green, randBlue);
          tree.fill(randRed, green, randBlue);
          x = originPos.x - 70 + int( random(-speedX, speedX) );
          y = originPos.y - 20 + int( random(-speedY, speedY) );

          rect(x, y, size, size);
          tree.rect(x, y, size, size);

          if (int( random(0, 200) ) == 1) {
            flower.add(new PVector(x, y));
          }

          randRed = int( random(redblue - 10, redblue + 10) );
          randBlue = int( random(redblue - 10, redblue + 10) );

          //right
          fill(randRed, green, randBlue);
          tree.fill(randRed, green, randBlue);
          x = originPos.x + 70 + int( random(-speedX, speedX) );
          y = originPos.y - 20 + int( random(-speedY, speedY) );

          rect(x, y, size, size);
          tree.rect(x, y, size, size);

          if (int( random(0, 200) ) == 1) {
            flower.add(new PVector(x, y));
          }

          randRed = int( random(redblue - 10, redblue + 10) );
          randBlue = int( random(redblue - 10, redblue + 10) );

          //top
          fill(randRed, green, randBlue);
          tree.fill(randRed, green, randBlue);
          x = originPos.x + int( random(-speedX, speedX) );
          y = originPos.y - 60 + int( random(-speedY, speedY) );

          rect(x, y, size, size);
          tree.rect(x, y, size, size);

          if (int( random(0, 200) ) == 1) {
            flower.add(new PVector(x, y));
          }
        }
      }

      speedX = speedX + 0.2;
      speedY = speedY + 0.15;

      size = random(5, 20);

      if (int( random(0, 200) ) == 1) {
        flower.add(new PVector(x, y));
      }
    } else {

      //declare current leaves finished
      if (leavesFin != true) {
        leavesFin = true;
      }

      //if not flowered yet, loop list of flower pos
      if (flowered != true && startFlowering == true) {
        for (int i = 0; i < flower.size(); i++) {

          float x = flower.get(i).x;
          float y = flower.get(i).y;

          color tempCol = petalCol;

          //Very rare chance to have different colour flower
          if (int( random(1, 100) ) == 1) {
            //pick random element of tempCol to modify
            float randCol = random (0, 1);
            if (randCol < 0.33) {
              red(tempCol = tempCol + 40);
              green(tempCol = tempCol - 180);
              blue(tempCol = tempCol - 180);
            } else if (randCol < 0.66) {
              red(tempCol = tempCol - 180);
              green(tempCol = tempCol + 40);
              blue(tempCol = tempCol - 180);
            } else {
              red(tempCol = tempCol - 180);
              green(tempCol = tempCol - 180);
              blue(tempCol = tempCol + 400);
            }
          }

          //draw petals around flower pos
          for (int j = 0; j < 5; j++) {

            float x2 = x + random(-4, 4);
            float y2 = y + random(-4, 4);

            //color modifier - slightly alter color of each petal
            float colMod = random(0.95, 1.05);
            tempCol = color(red(tempCol) * colMod, green(tempCol) * colMod, blue(tempCol) * colMod);

            fill(tempCol);
            tree.fill(tempCol);

            rect(x2, y2, 8, 8);
            tree.rect(x2, y2, 8, 8);
          }
          //draw center of flower
          fill(255, 204, 0);
          tree.fill(255, 214, 10);

          rect(x, y, 4, 4);
          tree.rect(x, y, 4, 4);
        }
        flowered = true;
      }
    }
  }
}
