void setup(){
  size(300,300);
  noLoop();
}

void draw(){
  background(#808B96);
  
  double_item(0,0);
  double_item(0,75);
  double_item(0,150);
  double_item(0,225);
  double_item(75,0);
  double_item(150,0);
  double_item(225,0);
  double_item(75,75);
  double_item(225,225);
  double_item(150,225);
  double_item(225,150);
}

void double_item(int x,int y){
  
//primeiro conjunto - square
  
  stroke(255);
  strokeWeight(2.0);
  strokeJoin(BEVEL);
  
  fill(#800000);
  square(x,y,25);

  fill(#A52A2A);
  square(x+25,y+25,25);
  
  fill(#A0522D);
  square(x+50,y+50,25);
  
  fill(#8B4513);
  square(x+75,y+75,25);
  
  fill(#D2691E);
  square(x+100,y+100,25);
  
  fill(#CD853F);
  square(x+125,y+125,25); 
  
//segundo conjunto - circle

  noFill();
  
  stroke(#556B2F);
  circle(x,y,15);
  
  stroke(#808000);
  circle(x,y+75,15);
  
  stroke(#6B8E23);
  circle(x,y+150,15);
  
  stroke(#9ACD32);
  circle(x,y+225,15);
  
  stroke(#006400);
  circle(x+75,y,15);
  
  stroke(#008000);
  circle(x+150,y,15);
  
  stroke(#228B22);
  circle(x+225,y,15);

}
