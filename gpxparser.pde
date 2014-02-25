import processing.pdf.*;

float[] boundingBox = new float[] {
  52.59720882433758, 
  13.0133056640625,     // lat (y) lon (x) – Bereich oben links, unten rechts
  52.37685671400387, 
  13.577041625976562
};

void setup() {
  size(400, 400);
  background(255);

  beginRecord(PDF, "gps_track.pdf"); 

  XMLElement xml = new XMLElement(this, "RK_gpx _2012-10-01_1130.gpx");
  noFill();
  beginShape();
  for (int i = 0; i < xml.getChildCount(); i++) {
    XMLElement child = xml.getChild(i);
    String name = child.getName();
    if (name.equals("trkpt")) {
      float aspectRatio = (boundingBox[3] - boundingBox[1]) / (boundingBox[0] - boundingBox[2]);
      float lat = child.getFloat("lat");  // xml attribut
      float lon = child.getFloat("lon");
      float x = map(lon, boundingBox[1], boundingBox[3], 0, width);    // bereich der gps koodinaten auf den fensterbereich mappen
      float y = map(lat, boundingBox[0], boundingBox[2], 0, width/aspectRatio);
//      println(lat+" "+lon);
     vertex(x+20, y+100);
    }
  }
  endShape();

  endRecord();
}

