int gridSquareW = 80;
int gridSquareH = 80;
int smallSquareW = gridSquareW/2;
int smallSquareH = gridSquareH/2;

void setup() {
  size(800,800);
  background(#603522);
  noLoop();
}

void draw() {
  // Codigo inicial
  float w = 0;
  while (w < width){
    line(w, 0, w, height);
    w = w + gridSquareW;
  }
  
  float h = 0;
  while (h < height) {
    line (0, h, width, h);
    h = h + gridSquareH;
  }
  
  // Codigo novo
  int grid_n_columns = width/gridSquareW;
  int grid_n_rows = height/gridSquareH;
  
  //int spawning_pointX = gridSquareW/2 - smallSquareW/2;
  //int spawning_pointY = gridSquareH/2 - smallSquareH/2;
  
  for(int gridX=0; gridX < grid_n_columns; gridX=gridX+2) {
    for (int gridY=0; gridY < grid_n_rows; gridY=gridY+2) {
      spawn_pattern(gridX, gridY, gridSquareW, gridSquareH, #2E2E2E, "rect", gridSquareW/2, gridSquareH/2, 5, 20);
    }
  }

  for(int gridX=1; gridX < grid_n_columns; gridX=gridX+2) {
    for (int gridY=0; gridY < grid_n_rows; gridY=gridY+2) {
      spawn_pattern(gridX, gridY, gridSquareW, gridSquareH, #90EE90, "circle", 20, 20, 5, 20);
    }
  }
  
  for(int gridX=1; gridX < grid_n_columns; gridX=gridX+2) {
    for (int gridY=1; gridY < grid_n_rows; gridY=gridY+2) {
      spawn_pattern(gridX, gridY, gridSquareW, gridSquareH, #F9E076, "rect", 40, 20, 5, 20);
    }
  }
  
  for(int gridX=0; gridX < grid_n_columns; gridX=gridX+2) {
    for (int gridY=1; gridY < grid_n_rows; gridY=gridY+2) {
      spawn_pattern(gridX, gridY, gridSquareW, gridSquareH, #FF8080, "rect", 20, 40, 5, 20);
    }
  }
  //fill(#000000);
  //spawn(0,0, w, h);
}

void spawn(int i, int j, float w, float h) {
  float x = i * (w/2) - j * (w/2);
  float y = i* (h/2) + j* (h/2);
  rect(x, y, 30, 30, 5);
}

void translate_spawning_point(int gridX, int gridY, int gridSquareW, int gridSquareH) {
  int spawning_pointX = gridX*gridSquareW + gridSquareW/2 - smallSquareW/2;
  int spawning_pointY = gridY*gridSquareH + gridSquareH/2 - smallSquareH/2;
  translate(spawning_pointX, spawning_pointY);
}

void spawn_pattern(int gridX, int gridY, int gridSquareW, int gridSquareH, color figure_color, String figure_type, int figureW, int figureH, int border_radius, int circle_radius) {
  push();
  translate_spawning_point(gridX, gridY, gridSquareW, gridSquareH);
  spawn_figure(figure_color, figure_type, figureW, figureH, border_radius, circle_radius);
  pop();
}

void spawn_figure(color figure_color, String figure_type, int figureW, int figureH, int border_radius, int circle_radius) {
  fill(figure_color);
  if (figure_type=="rect") {
    rect(0, 0, figureW, figureH, border_radius);
  } else if (figure_type=="circle") {
    circle(0, 0, circle_radius);
  }
}
