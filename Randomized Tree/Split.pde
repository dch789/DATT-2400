class Split {
  private PVector originMatrix;
  private float originAngle;
  private PVector originPos;
  private float originSize;

  private PVector splitPos;
  private float splitSize;
  private float splitSpeed;
  private float splitShrinkRate;
  private float splitAngle;
  private float splitLimit;

  private boolean splitFin;

  Split(PVector origin, PVector pos, float size, float speed, float angle) {
    //origin values
    //origin's matrix pos
    originMatrix = origin;
    originPos = pos;
    originAngle = angle;
    originSize = size;

    //split values
    splitPos = new PVector(0, 0);
    splitSpeed = speed;
    splitSize = size;

    //rate of size shrink
    splitShrinkRate = random(0.01, 0.025);
    //size to stop growing
    splitLimit = random(3.8, 5);

    //define split angle
    splitAngle = random(0, 75);

    //chance to reverse angle direction
    if (random(1) < 0.5) {
      splitAngle = 360 - splitAngle;
    }
  }

  void display() {

    if (splitSize > splitLimit) {
      //Reset grid
      resetMatrix();
      tree.resetMatrix();

      float randGreen = int( random(woodColG - 10, woodColG + 10) );
      float randBlue = int( random(woodColB - 10, woodColB + 10) );

      fill(woodColR, randGreen, randBlue);
      tree.fill(woodColR, randGreen, randBlue);

      //start at drawing location of origin branch:
      //translate to origin's matrix - rotate to origin's rotation - translate to origin's pos
      translate(originMatrix.x, originMatrix.y);
      rotate(radians(originAngle));
      translate(originPos.x, originPos.y);

      tree.translate(originMatrix.x, originMatrix.y);
      tree.rotate(radians(originAngle));
      tree.translate(originPos.x, originPos.y);

      //angle for split
      rotate(radians(splitAngle));
      tree.rotate(radians(splitAngle));

      //split random walker
      splitPos.x = splitPos.x + int( random(-splitSpeed, splitSpeed) );
      splitPos.y = splitPos.y + int( random(-splitSpeed, splitSpeed/2) );

      //draw split
      rect(splitPos.x, splitPos.y, splitSize, splitSize);
      tree.rect(splitPos.x, splitPos.y, splitSize, splitSize);

      //decrease split size
      splitSize = splitSize - splitShrinkRate;
    }
    //declare finished
    else {
      if (splitFin != true) {
        splitFin = true;
        //create leaves at end location
        leaves.add(new Leaves(splitPos, speed, this));

        //DEBUG - Mark split end points
        //resetMatrix();
        //setMatrix();
        //fill(255, 0, 0);
        //rect(splitPos.x, splitPos.y, 15, 15);
      }
    }
  }

  void setMatrix() {
    translate(originMatrix.x, originMatrix.y);
    rotate(radians(originAngle));
    translate(originPos.x, originPos.y);
    rotate(radians(splitAngle));
    
    tree.translate(originMatrix.x, originMatrix.y);
    tree.rotate(radians(originAngle));
    tree.translate(originPos.x, originPos.y);
    tree.rotate(radians(splitAngle));
  }
}
