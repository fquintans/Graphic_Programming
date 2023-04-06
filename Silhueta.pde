size(300,300);

  background(#FFCC00);
  fill(#000000);

//body
  beginShape();
  curveVertex(30,270);
  curveVertex(270,270);
  curveVertex(270,150);
  curveVertex(150,30);
  curveVertex(30,150);
  curveVertex(30,270);
  curveVertex(270,270);
  endShape(CLOSE);
 
//left eye
  ellipseMode(CENTER);
  ellipse(100,100,100,100);

//righteye
  ellipseMode(CENTER);
  ellipse(200,100,100,100);
  
//hat
  rect(100,30,100,10);
  rect(130,0,40,30);
