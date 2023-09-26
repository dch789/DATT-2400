class Branch {
  private PVector originPos;
  private float originSize;

  private PVector branchPos;
  private float branchSize;
  private float branchSpeed;
  private float branchAngle;
  private float branchLimit;

  private int numOfSplits;

  FloatList branchSplit;

  private boolean branchFin;

  //args: origin x, y, size, branchSpeed
  Branch(float x, float y, float size, float speed) {
    //origin values
    originPos = new PVector(x, y);
    originSize = size;

    //branch values
    //pos at 0, 0 - grid being translated
    branchPos = new PVector(0, 0);
    branchSize = size;
    branchSpeed = speed;

    branchLimit = random(5.2, 6);

    //define branch angle
    branchAngle = random(0, 75);
    //chance to reverse angle direction
    if (random(1) < 0.5) {
      branchAngle = 360 - branchAngle;
    }

    //number of possible splits
    numOfSplits = 7;
    //initialize branch's split list
    branchSplit = new FloatList();
    //split attempts
    for (int i = 0; i < numOfSplits; i++) {

      //chance to create split
      if (random(1) < 0.5) {

        //determine and record split distance in branch
        branchSplit.append(random(0.1, 0.9));
      }
    }
  }

  void display() {

    //only draw while size of elements is above given limit
    if (branchSize > branchLimit) {
      //Reset grid
      resetMatrix();
      tree.resetMatrix();

      float randGreen = int( random(woodColG - 10, woodColG + 10) );
      float randBlue = int( random(woodColB - 10, woodColB + 10) );

      fill(woodColR, randGreen, randBlue);
      tree.fill(woodColR, randGreen, randBlue);

      //branch origin is last stem pos
      translate(originPos.x, originPos.y);
      tree.translate(originPos.x, originPos.y);
      //rotation of branch
      rotate(radians(branchAngle));
      tree.rotate(radians(branchAngle));

      //branch random walker
      branchPos.x = branchPos.x + int( random(-branchSpeed, branchSpeed) );
      branchPos.y = branchPos.y + int( random(-branchSpeed, branchSpeed/2) );
      rect(branchPos.x, branchPos.y, branchSize, branchSize);
      tree.rect(branchPos.x, branchPos.y, branchSize, branchSize);

      float x;
      float y;

      //add element to left (- branchSize) and right (+ branchSize)
      x = branchPos.x + int( random(-branchSpeed, branchSpeed) );
      y = branchPos.y + int( random(-branchSpeed, branchSpeed/2) );
      rect(x - branchSize, y, branchSize, branchSize);
      tree.rect(x + branchSize, y, branchSize, branchSize);

      x = branchPos.x + int( random(-branchSpeed, branchSpeed) );
      y = branchPos.y + int( random(-branchSpeed, branchSpeed/2) );
      rect(x + branchSize, y, branchSize, branchSize);
      tree.rect(x + branchSize, y, branchSize, branchSize);

      //decrease branch size
      branchSize = branchSize - 0.01;

      //loop branch's split list
      for (int i = 0; i < branchSplit.size(); i++) {

        //declare split distance on branch
        float spDist = branchSplit.get(i);

        //if branch has reached distance to begin split
        if (originSize - branchSize >= spDist * (originSize - branchLimit)) {

          //remove split distance from list
          branchSplit.remove(i);

          //DEBUG - Uncomment to mark split spawn points
          //resetMatrix();
          //fill(255, 0, 0);
          //setMatrix();
          //rect(branchPos.x, branchPos.y, 15, 15);

          //Construct split
          Split sp = new Split(originPos, new PVector(branchPos.x, branchPos.y), branchSize, branchSpeed, branchAngle);

          //add split to main split list (to be drawn)
          split.add(sp);
        }
      }
    }
    //branch finished
    else {
      if (branchFin != true) {
        branchFin = true;
        //create leaves at end location
        leaves.add(new Leaves(branchPos, speed, this));
      }
    }
  }

  void setMatrix() {
    translate(originPos.x, originPos.y);
    rotate(radians(branchAngle));
    
    tree.translate(originPos.x, originPos.y);
    tree.rotate(radians(branchAngle));
  }
}
