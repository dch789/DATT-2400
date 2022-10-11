PVector middle;
PVector rootPos;

int ground;

float speed;
float size;
float stemShrinkHeight;
float stemMidExpandHeight;

ArrayList<Branch> branch;
ArrayList<Split> split;
ArrayList<Leaves> leaves;
ArrayList<PVector> leavesCoords;

int leafCol;
int woodColR;
int woodColG;
int woodColB;

color petalCol;

Stem middleStem;
Stem leftStem;
Stem rightStem;

boolean startFlowering;
boolean printTree;

PGraphics tree;

void setup() {
  size(1200, 800);
  noStroke();
  background(51);
  rectMode(CENTER);

  //middle of screen stored as pvector
  middle = new PVector(width/2, height/2);

  //speed of anim
  speed = 4;

  //distance from bottom of screen to begin anim
  ground = 25;

  //size of elements
  size = random(9, 11);

  //fraction of screen height to remove roots/shrink width towards
  stemShrinkHeight = random(0.7, 0.85);

  //define location of tree root
  rootPos = new PVector(middle.x, height + ground);

  //Stems (Mid, Left, Right)
  //args: origin x, y, size, offset of (-1 left, 0 mid, 1 right), speed, shrinkfactor
  middleStem = new Stem(rootPos.x, rootPos.y, size, 0, speed, stemShrinkHeight);
  leftStem = new Stem(middleStem.stemPos.x, middleStem.stemPos.y, size, -1, speed, stemShrinkHeight);
  rightStem = new Stem(middleStem.stemPos.x, middleStem.stemPos.y, size, 1, speed, stemShrinkHeight);

  //create arraylist for branches
  branch = new ArrayList<Branch>();

  //create arraylist for splits
  split = new ArrayList<Split>();

  //create arraylist for splits
  leaves = new ArrayList<Leaves>();

  //create arraylist to record coordinates of leaves objects
  //added to by Branch and Split
  leavesCoords = new ArrayList<PVector>();

  //generate green value for leaf colour
  leafCol = int( random(100, 175) );
  //generate values for wood colour
  woodColR = int( random(100, 255) );
  woodColG = int( random(woodColR - 30, woodColR - 30) );
  woodColB = int( random(woodColR - 60, woodColR - 60) );

  petalCol = color(int( random(205, 255) ), int( random(205, 255) ), int( random(205, 255) ));

  //pick random element of petalCol to modify
  float randCol = random (0, 1);
  if (randCol < 0.25) {
    red(petalCol - 40);
  } else if (randCol < 0.50) {
    green(petalCol - 40);
  } else if (randCol < 0.75) {
    blue(petalCol - 40);
  }

  //setup PGraphics
  tree = createGraphics(width + 100, height + 100);
  tree.beginDraw();
  tree.noStroke();
}

void draw() {
  //UNCOMMENT TO SEE DRAWING PROCESS
  //=============================
  //background(51);
  //=============================

  //bool to record if tree is done
  boolean done = true;

  //UPDATE STEMS ===
  middleStem.display();
  //update origin to middlestem pos
  leftStem.originPos = middleStem.stemPos;
  leftStem.display();
  //update origin to middlestem pos
  rightStem.originPos = middleStem.stemPos;
  rightStem.display();

  //UPDATE BRANCHES ===
  //no branches:
  if (branch.size() == 0) {
    done = false;
  }
  //branches exist:
  else {
    for (int i = 0; i < branch.size(); i++) {
      //draw branch
      branch.get(i).display();

      //if any branches not finished
      if (branch.get(i).branchFin != true) {
        done = false;
      }
    }
  }

  //UPDATE SPLITS ===
  for (int i = 0; i < split.size(); i++) {
    //draw split
    split.get(i).display();

    //if any splits not finished
    if (split.get(i).splitFin != true) {
      done = false;
    }
  }

  //TREE FINISHED ===
  if (done) {

    //UPDATE LEAVES ===
    //check if flowering can begin
    startFlowering = true;
    printTree = true;
    for (int i = 0; i < leaves.size(); i++) {
      //leaves are not finished yet
      if (leaves.get(i).leavesFin == false) {
        startFlowering = false;
      }
      //floweres not finished yet
      if (leaves.get(i).flowered == false) {
        printTree = false;
      }
    }

    //draw leaves and flower
    for (int i = 0; i < leaves.size(); i++) {
      leaves.get(i).display();
    }

    //print tree image once everything done
    if (printTree) {
      tree.endDraw();
      background(51);
      resetMatrix();
      image(tree, 0, 0);

      //save image
      tree.save("tree.png");
      exit();
    }
  }
}
