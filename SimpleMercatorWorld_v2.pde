import peasy.*;

PImage worldMapImage;

MercatorMap mercatorMap;

int kind=1;
PVector milan;
ArrayList<Marker> marks = new ArrayList<Marker>();
ArrayList<Country> countries = new ArrayList<Country>();
ArrayList<Trail> trails = new ArrayList<Trail>();
PeasyCam cam;
int count = 0;
Country istCountry;
float jeez=-1;
float fs=5;

void setup() {
  size(1920, 1080, OPENGL);
  smooth();
  background(0);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(400);
  cam.setMaximumDistance(1000);
  cam.lookAt(width/2, height/2+50, 0);
  // World map from http://en.wikipedia.org/wiki/File:Mercator-projection.jpg 
  worldMapImage = loadImage("polimi3.png");
  // Using default bounding box
  mercatorMap = new MercatorMap(1920, 1080);
  //s = loadShape("map.svg");
  worldMapImage.loadPixels();
  milan=mercatorMap.getScreenLocation(new PVector(45.466667, 9.183333));
  smooth(5);
  loadMarkers();
  loadCountries();
}

void draw() {
  background(0);
  count++;
  //hint (DISABLE_DEPTH_TEST);
  //image(worldMapImage, 0, 0, width, height);
  //shape(s,width/2,height/2,width,height);
  //hint (ENABLE_DEPTH_TEST);
  
  drawMap();
  
  noStroke();
  fill(#0081c2);

  if (keyPressed) {

    if (key == 'z' || key == 'Z') {
      trails.clear();
      for (Marker m : marks) {
        m.status=0;
        istCountry=null;
      }
    }
    else if(key=='k') {
     if (kind==0) kind=1;
    else kind=0; 
    }
  }

  if (count>=300) {
    g.removeCache(worldMapImage);
    count=0;
  }

  for (Marker m : marks) {
    m.update();
  }

  for (Trail t : trails) {
    t.draw();
  }
  
  if(istCountry!=null) {
  cam.beginHUD();
  fill(255);
  noStroke();
  textSize(70);
  text(istCountry.name, 10, 90);
 
 textSize(35);
 if(istCountry.count<2) {
   fill(#416F6C);
   text(istCountry.count, 10, 140);
   fill(#FFFFFF);
   text("University", 40, 140);
 }
 else if(istCountry.count<10){
   fill(#416F6C);
   text(istCountry.count, 10, 140);
   fill(#FFFFFF);
   text("Universities", 40, 140); 
 }
 
 else {
   fill(#416F6C);
   text(istCountry.count, 10, 140);
   fill(#FFFFFF);
   text("Universities", 65, 140);
 }
  cam.endHUD();
  }
}

void loadMarkers() {

  String lines[] = loadStrings("out_1b.csv");
  for (String s : lines) {
    String[] list = split(s, ',');
    PVector p = mercatorMap.getScreenLocation(new PVector(Float.parseFloat(list[2]), Float.parseFloat(list[3])));
    
    marks.add(new Marker(p,list[4]));
  }
}

void loadCountries() {

  String lines[] = loadStrings("countries.csv");
  for (String s : lines) {
    String[] list = split(s, ',');
    countries.add(new Country(list[0],int(list[1])));
  }
}


void keyReleased() {
   int co= countries.size();
      int f = int(random(co));
      String n = countries.get(f).name;
      istCountry=countries.get(f);
       println(n);
      for (Marker m : marks) {
       
        if(m.country.equals(n)) {
        trails.add(new Trail(milan, m.pos));
        m.status=1;
        }
        
    }
}

void drawMap() {
 
 for (int x = 0; x<worldMapImage.width; x+=fs) {
   for (int y = 0; y<worldMapImage.height; y+=fs) {
    
    float col = red(worldMapImage.pixels[x + y*worldMapImage.width]);
    if(col>2) {
      if (kind==0) {
        stroke(col);
        strokeWeight(4);
        point(x,y,col/10);
      }
      else if (kind==1) {
        fill(col);
        noStroke();
        beginShape(TRIANGLES);
        vertex(x-fs/2,y-fs/2,col/10);
        vertex(x+fs/2,y-fs/2,col/10);
        vertex(x,y+fs/2,col/10);
        endShape();
      
      }
    }
   }
 
 } 
  
}
