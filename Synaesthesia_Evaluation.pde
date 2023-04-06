
AudioReactiveLooper audio;
int save_counter = 0;
String sketch_id;
PImage img;

int beat_counter = 0;
int noBeat_counter = 0;
int pos;
boolean record = false;
boolean first_frame = false;
boolean first_time_noBeat = false;

void setup() {
  size(1000,1000);
  img = loadImage("brain.jpeg");
  background(img);
  audio = new AudioReactiveLooper(this, "drum go dum full.mp3");
  sketch_id = make_sketch_id();
  strokeWeight(3);
}

void draw() {
  // get audio data
  boolean beat = audio.beat();
  float energy = audio.energy();
  float low = audio.low();
  float mid = audio.mid();
  float high = audio.high();
  
  // draw from audio data
  println(beat, energy, low, mid, high);
  
  //
  
  int beat_polygon_size = 50;
  float beat_grow_factor = 0.5;
  int max_beat_growth_counter = 10;
  float beat_size_factor = min((beat_counter+1), max_beat_growth_counter) * beat_grow_factor;
  float noBeat_size_factor = min((noBeat_counter+1), max_beat_growth_counter) * beat_grow_factor;
  float circle_max_size = beat_polygon_size + beat_polygon_size*(max_beat_growth_counter*beat_grow_factor);
  // translate to mid
  translate(width/2, height/2);
  // correct translation based on beat polygon size
  int beatSet_translation_offset = - (beat_polygon_size/2);
  
  // this code runs in the first "frame"
  if (first_frame==false) {
    strokeWeight(3);
    // BEAT
    fill(#ffff00); // AMARELO
    circle(-width/5 - beatSet_translation_offset,-height/4 - beatSet_translation_offset,circle_max_size);
    // NO-BEAT
    fill(#00ffff); // CYAN
    circle(width/5 + beatSet_translation_offset,-height/4 - beatSet_translation_offset,circle_max_size);
  }
 
  //beat code 
  if (beat) {
    beat_counter++;
    noBeat_counter = 0;
    strokeWeight(3);
    if (beat_counter == 1) {
      fill(#ff0000); // VERMELHO
    } else if (beat_counter == 2) {
      fill(#ff1f00);
    } else if (beat_counter == 3) {
      fill(#ff3f00);
    } else if (beat_counter == 4) {
      fill(#ff5f00);
    } else if (beat_counter == 5) {
      fill(#ff7f00);
    } else if (beat_counter == 6) {
      fill(#ff9f00);
    } else if (beat_counter == 7) {
      fill(#ffbf00);
    } else if (beat_counter == 8) {
      fill(#ffdf00);
    } else {
      fill(#ffff00); // AMARELO
    }
    
    circle(-width/5 - beatSet_translation_offset,-height/4 - beatSet_translation_offset,beat_polygon_size + beat_polygon_size*beat_size_factor);
  }
  //no beat code
  else {
    if (frameCount%8==0) {
      noBeat_counter++;
      beat_counter = 0;
      strokeWeight(3);
      if (noBeat_counter == 1) {
        fill(#0000ff); // AZUL
      } else if (noBeat_counter == 2) {
        fill(#001fff);
      } else if (noBeat_counter == 3) {
        fill(#003fff);
      } else if (noBeat_counter == 4) {
        //fill(#5f00ff);
        fill(#005fff);
      } else if (noBeat_counter == 5) {
        fill(#007fff);
      } else if (noBeat_counter == 6) {
        fill(#009fff);
      } else if (noBeat_counter == 7) {
        fill(#00bfff);
      } else if (noBeat_counter == 8) {
        fill(#00dfff);
      } else {
        fill(#00ffff); // CYAN
      }
      
      circle(width/5 + beatSet_translation_offset, -height/4 - beatSet_translation_offset,beat_polygon_size + beat_polygon_size*noBeat_size_factor);
    }
  }
  
  
  // teeth
  float tooth_width = circle_max_size/2;
  float tooth_height = height/4;
  float tooth_color_ratio = 1;
  float tooth_max_height = tooth_height*tooth_color_ratio;
  float tooth_start_positionX = - circle_max_size;
  translate(tooth_start_positionX, 0);
  
  if (first_frame == false) {
    strokeWeight(3);
    fill(#ffffff);
    // energy tooth
    rect(0, height/8, tooth_width, tooth_height);
    // low tooth
    rect(tooth_width, height/8, tooth_width, tooth_height);
    // mid tooth
    rect(tooth_width*2, height/8, tooth_width, tooth_height);
    // high tooth
    rect(tooth_width*3, height/8, tooth_width, tooth_height);
  }
  
  // energy tooth movement
  float energy_growth = max(-tooth_max_height, -energy*750);
  tooth_movement(tooth_width, tooth_height, energy_growth, #ff0000, #ff8000, #ffff00, 0);
  // low tooth movement
  float low_growth = max(-tooth_max_height, -low*2);
  tooth_movement(tooth_width, tooth_height, low_growth, #80ff00, #00ff00, #00ff80, tooth_width);
  // mid tooth movement
  float mid_growth = max(-tooth_max_height, -mid*30);
  tooth_movement(tooth_width, tooth_height, mid_growth, #00ffff, #0080ff, #0000ff, tooth_width*2);
  // high tooth movement
  float high_growth = max(-tooth_max_height, -high*200);
  tooth_movement(tooth_width, tooth_height, high_growth, #8000ff, #ff00ff, #ff0080, tooth_width*3);
  strokeWeight(3);
  
  // END
  if (record) {
    saveFrame("frame-" + sketch_id + "-####.png");
  }
  first_frame = true;
}

void tooth_movement(float tooth_width, float tooth_height, float variable_growth, color sector1, color sector2, color sector3, float tooth_start_x) {
  // Sets the fill according to the variable "growth", and returns said "growth"
  strokeWeight(1);
  float sector1_start = 0;
  float sector2_start = -tooth_height/3;
  float sector3_start = -tooth_height*2/3;
  float sector3_end = -tooth_height;
  Boolean variable_sector1 = (variable_growth <= sector1_start) && (variable_growth > sector2_start);
  Boolean variable_sector2 = (variable_growth <= sector2_start) && (variable_growth > sector3_start);
  Boolean variable_sector3 = (variable_growth <= sector3_start) && (variable_growth > sector3_end);
  if (variable_sector1) {
    fill(sector1);
  } else if (variable_sector2) {
    fill(sector2);
  } else if (variable_sector3) {
    fill(sector3);
  } else {
    fill(#ffffff); // default: dentinho branco
  }
  rect(tooth_start_x, height/8 + tooth_height, tooth_width, variable_growth);
}


void keyPressed() {
  if (key == 's') {
    save("img-" + sketch_id + "-" + save_counter + ".png");
    save_counter++;
  }
  else if (key == ' ') {
    record = !record;
  }
}

String make_sketch_id() {
  return new String(year() + "-" + month() + "-" + day() + "-" +
                    hour() + "" + minute() + "" + second());
}
