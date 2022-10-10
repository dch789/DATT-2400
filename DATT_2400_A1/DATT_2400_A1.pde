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

color leafCol;
color woodCol;

Stem middleStem;
Stem leftStem;
Stem rightStem;

PGraphics tree;

void setup() {
  size(1000, 800);
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

  leafCol = color(105, int( random(140, 160) ), 105);
  woodCol = color(int( random(255) ));

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

  tree = createGraphics(width + 100, height + 100);
  tree.beginDraw();
  tree.noStroke();
}

void draw() {
  //UNCOMMENT TO SEE DRAWING PROCESS
  //=============================
  //background(51);
  //=============================

  //UPDATE STEMS ===
  middleStem.display();
  //update origin to middlestem pos
  leftStem.originPos = middleStem.stemPos;
  leftStem.display();
  //update origin to middlestem pos
  rightStem.originPos = middleStem.stemPos;
  rightStem.display();

  //bool to record if tree is done
  boolean done = true;

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
    tree.endDraw();
    //background(51);
    //image(tree, -7, -1);
    //tint(0, 153, 0);

    //UPDATE LEAVES ===
    for (int i = 0; i < leaves.size(); i++) {
      leaves.get(i).display();
    }
  }
}
