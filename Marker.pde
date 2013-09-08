class Marker {

  PVector pos;
  float glow;
  int status;
  int big;
  String country;
  ArrayList<PVector> tail;

  Marker (float x, float y) {

    this.pos = new PVector(x, y, 0);
    glow=0;
    status=0;
    big=0;
    tail = new ArrayList<PVector>();
  }

  Marker (PVector p, String c) {

    this.pos = p;
    glow=0;
    status=0;
    big=0;
    this.country=c;
    tail = new ArrayList<PVector>();
  }  

  void update() {

    if (glow==0 && status==0) {

      //probability to start glowing
      float r = random(1);
      if (r>0.9992) {
        glow=1;
      }
    }

    if (glow>0 && glow<180) {
      float z=90-abs(glow-90);
      hint (DISABLE_DEPTH_TEST);
      fill(180,0,0, z*2);
      noStroke();
      ellipse(pos.x, pos.y, glow/20,glow/20);
      hint (ENABLE_DEPTH_TEST);
      
      glow++;
    }

    if (glow>=180) {
      glow=0;
    }
  }
}

