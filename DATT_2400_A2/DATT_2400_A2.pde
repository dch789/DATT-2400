PVector origin;
float growth;
int ringCount;

ExpandRing expRing;
ArrayList<Ring> ring;
ArrayList<Pulse> pulse;

void setup() {
  size(500, 500);
  rectMode(CENTER);
  background(0);
  noStroke();

  origin = new PVector(width/2, height/2);
  //growth amount
  growth = 0.5;
  //number of rings
  ringCount = 10;

  expRing = new ExpandRing();
  ring = new ArrayList<Ring>();
  for (int i = 0; i < ringCount; i++) {
    ring.add(new Ring());
  }
  pulse = new ArrayList<Pulse>();
}

void draw() {
  background(0);

  for (int i = 0; i < ring.size(); i++) {
    ring.get(i).display();
  }
  
  expRing.display();
  
  for (int i = 0; i < pulse.size(); i++) {
    pulse.get(i).display();
  }

  //print numbered frame
  //saveFrame("####_out.png");
}
