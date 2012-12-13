class ocar2 {

  float xpos;
  float ypos;
  int width = 35;
  int height = 35;
  float yspeed;
    float speed;
   


  //setup
  ocar2(float x, float y, float s) {
    xpos = x;
    ypos = y;
    yspeed = s;
   // pre_pause_speed  = 0;
    


  }//end of setup

  void draw() {
    image(ocar2, xpos, ypos);
    ypos= ypos+yspeed;
// println(xpos);

    if (ypos> 600) {
      reset();
    }
  }//end of draw


    void reset() {
      xpos = random(70, 200);
      ypos = random(-650, -300);
      
      
      speed = random(4,15); 
      
  }
}





