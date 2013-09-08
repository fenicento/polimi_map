class Trail {

  float jeez = 0;
  PVector a;
  PVector b;
  float c = 0;
  ArrayList<PVector> trail1=new ArrayList<PVector>();
  ArrayList<PVector> trail2=new ArrayList<PVector>();

  Trail(PVector a, PVector b) {
    this.a=a;
    this.b=b;
  }

  void draw() { 
    c++;
    if (c>180) {
      c=0;
    }

    if (jeez>=0 && jeez<180) {

      PVector p = PVector.lerp(a, b, jeez/180);
      PVector p2 = PVector.lerp(b, a, jeez/180);

      float z = radians(90-abs(jeez-90)); 

      trail1.add(new PVector(p.x, p.y+10*sin(z), a.dist(b)/3*sin(z)));
      trail2.add(new PVector(p2.x, p2.y-10*sin(z), a.dist(b)/3*sin(z)));

      jeez+=10;
    }

    if (jeez==180) {
      
      trail1.add(new PVector(b.x, b.y, 0));
      trail2.add(new PVector(a.x, a.y, 0));
    }
    

    beginShape();
    curveVertex(a.x, a.y, 0);
    for (PVector p_go : trail1) {

      stroke(#416F6C, 120);
      strokeWeight(2);
      noFill();
      curveVertex(p_go.x, p_go.y, p_go.z);
    }
    endShape();
    
    

    beginShape();
    curveVertex(b.x, b.y, 0);
    for (PVector p_ba : trail2) {

      stroke(#7fdad4, 120);
      strokeWeight(2);
      noFill();
      curveVertex(p_ba.x, p_ba.y, p_ba.z);
    }
    endShape();

    stroke(#416F6C,120);
    strokeWeight(2);
    ellipse(b.x, b.y, 6, 6);

    stroke(#7fdad4,120);
    strokeWeight(2);
    ellipse(b.x, b.y, 9, 9);
  }
}

