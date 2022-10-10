class Stem {
  private PVector originPos;
  private float originSize;

  private PVector stemPos;
  private float stemSize;
  private float stemOffset;
  private float stemSpeed;
  private float stemShrinkHeight;

  private float shrinkFactor;
  private float stemExpandHeight;
  private boolean branched;

  //args: origin x, y, size, offset (-1 left, 0 mid, 1 right), speed, shrinkheight
  Stem(float x, float y, float size, float offset, float speed, float shrink) {
    //origin values
    originPos = new PVector(x, y);
    originSize = size;

    //stem values
    stemPos = new PVector(x, y);
    stemSize = size;
    stemOffset = offset;
    stemSpeed = speed;
    stemShrinkHeight = shrink;
    //random expand height
    stemExpandHeight = random(stemShrinkHeight - 0.1, stemShrinkHeight - 0.18);
  }

  void display() {

    //current ypos is above expand height of stem --> branches
    if (stemPos.y < rootPos.y * stemExpandHeight) {

      //only create branch if not created one yet
      if (branched != true) {
        //add new branch to list
        //args: origin x, y, size, speed
        branch.add(new Branch(stemPos.x, stemPos.y, stemSize, stemSpeed));
        branched = true;
      }
    }

    //current ypos is below expand height of stem --> no branches
    else {

      fill(255);
      tree.fill(255);

      //is middle stem
      if (stemOffset == 0) {
        //stem random walker
        stemPos.x = stemPos.x + int( random(-stemSpeed, stemSpeed) );
        stemPos.y = stemPos.y + int( random(-stemSpeed, stemSpeed/2) );

        rect(stemPos.x, stemPos.y, stemSize, stemSize);
        tree.rect(stemPos.x, stemPos.y, stemSize, stemSize);
      }

      //is left or right stem
      else {
        //random walker 1
        stemPos.x = originPos.x + int( random(-stemSpeed, stemSpeed) );
        stemPos.y = originPos.y + int( random(-stemSpeed, stemSpeed) );

        //diff between root ypos and shrink height ypos
        int yDiffMax = int(rootPos.y - (rootPos.y * stemShrinkHeight));
        //diff between root ypos and current draw ypos
        int yDiffNow = int(rootPos.y - stemPos.y);

        shrinkFactor = float(yDiffMax)/float(yDiffNow);

        //draw inner stem
        rect(stemPos.x + (stemOffset * stemSize), stemPos.y, stemSize, stemSize);
        tree.rect(stemPos.x + (stemOffset * stemSize), stemPos.y, stemSize, stemSize);

        //current ypos is below shrink height of stem --> draw roots
        if (stemPos.y > rootPos.y * stemShrinkHeight) {

          float spacing;

          //random walker 2
          stemPos.x = originPos.x + int( random(-stemSpeed, 0) );
          stemPos.y = originPos.y + int( random(-stemSpeed, stemSpeed) );
          rect(stemPos.x + (stemOffset * stemSize * 2) * shrinkFactor, stemPos.y, stemSize, stemSize);
          tree.rect(stemPos.x + (stemOffset * stemSize * 2) * shrinkFactor, stemPos.y, stemSize, stemSize);

          //random spacing
          spacing = randSpacing(1.5);
          //random walker 3
          stemPos.x = originPos.x + int( random(-stemSpeed, 0) );
          stemPos.y = originPos.y + int( random(-stemSpeed, stemSpeed) );
          rect(stemPos.x + (spacing * stemSize * stemOffset) * shrinkFactor, stemPos.y, stemSize, stemSize);
          tree.rect(stemPos.x + (spacing * stemSize * stemOffset) * shrinkFactor, stemPos.y, stemSize, stemSize);

          //random spacing
          spacing = randSpacing(1);
          //random walker 4
          stemPos.x = originPos.x + int( random(-stemSpeed, 0) );
          stemPos.y = originPos.y + int( random(-stemSpeed, stemSpeed) );
          rect(stemPos.x + (spacing * stemSize * stemOffset) * shrinkFactor, stemPos.y, stemSize, stemSize);
          tree.rect(stemPos.x + (spacing * stemSize * stemOffset) * shrinkFactor, stemPos.y, stemSize, stemSize);
        }

        //current ypos is above shrink height + below expand --> no roots, no branches
        else {
          rect(stemPos.x + (stemOffset * stemSize * 2) * shrinkFactor, stemPos.y, stemSize, stemSize);
          tree.rect(stemPos.x + (stemOffset * stemSize * 2) * shrinkFactor, stemPos.y, stemSize, stemSize);
        }
      }
    }
  }

  //generate random value for spacing between drawn elements
  float randSpacing(float val) {
    return random(val - 0.4, val + 0.4);
  }
}
