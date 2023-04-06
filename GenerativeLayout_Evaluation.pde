int NPOINTS = 100; //default: 100
color artist_text_color = #FFFFFF; //default: #FFFFFF
color album_text_color = #999999; //default: #999999
float line_start = 0.7; //default: 0.7 (starts at 70% of height)
color line_color = #FFFFFF; //default: #FFFFFF
color polygon_color = #000000; //default: #000000

PImage img;
PFont font;

void setup() {
  size(800, 800);
  img = loadImage("geometria.png");
  noLoop();
}

void draw() {
  background(#000000); //black
  tint(255, 127);
  image(img, 0, -500); //image
  
  
  //text
  fill(artist_text_color);
  font = loadFont("InkFree-48.vlw");
  textFont(font, 80);
  text("Arctic Monkeys", 160, 370);

  fill(album_text_color);
  font = loadFont("Euphorigenic-48.vlw");
  textFont(font, 50);
  text("- The Ultracheese -", 450, 450);
  
  fill(polygon_color);
  
  
  //lines
  float step = width/NPOINTS;
  float last_y = height;
  
  strokeWeight(2);
  stroke(line_color);
  
  for (float x=0; x<= width; x = x + step) {
    println(0.7*height);
    float y = line_start*height + random(height/4);
    line(x-step, last_y, x, y);
    last_y = y;
  }
  
  for (float x=2; x<= width; x = x + step) {
    println(0.7*height);
    float y = line_start*height + random(height/4);
    line(x-step, last_y, x, y);
    last_y = y;
  }
}
