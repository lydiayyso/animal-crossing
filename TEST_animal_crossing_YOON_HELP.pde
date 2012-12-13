
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

import processing.serial.*;
import cc.arduino.*;
Arduino arduino;




deer[] deerArray = new deer[3];
frog[] frogArray = new frog[3];
duck[] duckArray = new duck[3];
bunny[] bunnyArray = new bunny[3];
rcar[] rcarArray = new rcar[3];
ocar2[] ocar2Array = new ocar2[3];


Timer timer;
int countAmount= 0;
int speedTimer= 0;

int health= 100;
int numFrames = 2;  
int frame = 0; 

boolean redd;
boolean yellow;
boolean greenn;

PFont score;


PImage[] images = new PImage[numFrames];//deer
PImage[] images1 = new PImage[numFrames];//frog
PImage[] images2 = new PImage[numFrames];//duck
PImage[] images3 = new PImage[numFrames];//bunny


PImage rcar;
PImage ocar2;


PImage road;
PImage rules;
PImage fired;


int partCount = 1;

int restart;
int ppause;


Minim minim;
AudioPlayer groove;





//arduino.pinMode(8, Arduino.INPUT);


//section
void setup() {

  boolean redd = false;
  boolean yellow = true;
  boolean greenn  =true;




  size(600, 600);



  minim = new Minim(this);
  groove = minim.loadFile("background.wav");
  groove.loop();




  score = loadFont("score.vlw");
  textFont(score);
  textAlign(CENTER);


  timer = new Timer(1000);
  timer.start();

  frameRate(15);

  images[0] = loadImage("deer3.png");
  images[1] = loadImage("deer4.png");
  images1[0] = loadImage("frog.png");
  images1[1] = loadImage("frog2.png");
  images2[0] = loadImage("duck3.png");
  images2[1] = loadImage("duck4.png");
  images3[0] = loadImage("bunny.png");
  images3[1] = loadImage("bunny2.png");


  road = loadImage("background2.jpg");
  rules = loadImage ("rules.jpg");
  fired = loadImage("fired-02.jpg");


  rcar = loadImage("rcar.png");
  ocar2 = loadImage("ocar2.png");


  arduino = new Arduino(this, Arduino.list()[0], 57600); 

  arduino.pinMode(10, Arduino.INPUT);
  arduino.pinMode(9, Arduino.INPUT);
  arduino.pinMode(8, Arduino.INPUT);
  arduino.pinMode(6, Arduino.OUTPUT);
  arduino.pinMode(5, Arduino.OUTPUT);
  arduino.pinMode(4, Arduino.OUTPUT);



  for (int i=0;i<deerArray.length;i++) {
    deerArray[i] = new deer(random(-900, -500), random(100, 250), random(4, 8));
  }

  for (int i=0;i<frogArray.length;i++) {
    frogArray[i] = new frog(random(1000, 1400), random(160, 270), random(4, 8));
  }
  //double check on the the FIRST random part.

  for (int i=0;i<duckArray.length;i++) {
    duckArray[i] = new duck(random(-400, -200), random(150, 350), random(4, 8));
  }

  for (int i=0;i<bunnyArray.length;i++) {
    bunnyArray[i] = new bunny(random(900, 1200), random(160, 270), random(4, 8));
  }


  for (int i=0;i<rcarArray.length;i++) {
    rcarArray[i] = new rcar(random(350, 500), random(1500, 800), random(4, 8));
  }

  for (int i=0;i<ocar2Array.length;i++) {
    ocar2Array[i] = new ocar2(random(70, 200), random(-650, -300), random(4, 8));
  }
}


void draw() {




  if (partCount==1) {
    part1();
  }

  if (partCount==2) {
    part2();
  }

  if (partCount==3) {
    part3();
  }

  frame = (frame+1)%numFrames;
}// end of draw


void part1() {
  image(rules, 0, 0);

  if (mousePressed) {
    partCount=2;
  }
}//end part1




void part2() {
  image(road, 0, 0);



  for (int i=0;i<deerArray.length;i++) {
    deerArray[i].draw();
    for (int j=0;j<rcarArray.length;j++) {

      // need to do second hitTest
      if (deerArray[i].hitTest2(ocar2Array[j])) {
        health--;
        deerArray[i].reset();
      }

      if (deerArray[i].hitTest(rcarArray[j])) {
        health--;
        deerArray[i].reset();
      }
    }
  }


  for (int i=0;i<bunnyArray.length;i++) {
    bunnyArray[i].draw();
    for (int j=0;j<rcarArray.length;j++) {

      if (bunnyArray[i].hitTest2(ocar2Array[j])) {
        health--;
        bunnyArray[i].reset();
      }


      if (bunnyArray[i].hitTest(rcarArray[j])) {
        health--;
        bunnyArray[i].reset();
      }
    }
  }

  for (int i=0;i<duckArray.length;i++) {
    duckArray[i].draw();
    for (int j=0;j<rcarArray.length;j++) {

      if (duckArray[i].hitTest2(ocar2Array[j])) {
        health--;
        duckArray[i].reset();
      }


      if (duckArray[i].hitTest(rcarArray[j])) {
        health--;
        duckArray[i].reset();
      }
    }
  }

  for (int i=0;i<frogArray.length;i++) {
    frogArray[i].draw();
    for (int j=0;j<rcarArray.length;j++) {

      if (frogArray[i].hitTest2(ocar2Array[j])) {
        health--;
        frogArray[i].reset();
      }

      if (frogArray[i].hitTest(rcarArray[j])) {
        health--;
        frogArray[i].reset();
      }
    }
  }

  //=================car




  for (int i=0;i<rcarArray.length;i++) {
    rcarArray[i].draw();


    /*if (arduino.digitalRead(10)==Arduino.LOW) {
     rcarArray[i].yspeed =0;
     }
     else if (arduino.digitalRead(10)==Arduino.HIGH) {
     
     rcarArray[i].yspeed = random(4, 15);
     }
     
     //////////////=================
     
     if (arduino.digitalRead(8)==Arduino.LOW) {
     rcarArray[i].yspeed =1;
     }
     else if (arduino.digitalRead(8)==Arduino.HIGH) {
     
     rcarArray[i].yspeed = random(4, 15);
     }
     
     ////========
     
     
     
     if (arduino.digitalRead(9)==Arduino.LOW) {
     rcarArray[i].yspeed =30;
     }
     else if (arduino.digitalRead(9)==Arduino.HIGH) {
     
     rcarArray[i].yspeed = random(4, 15);
     }*/

    if (arduino.digitalRead(10)==Arduino.LOW) {
      println("stop");
      rcarArray[i].yspeed =0;
    } 
    else if (arduino.digitalRead(9)==Arduino.LOW) {
      println("go");
      rcarArray[i].yspeed =30;
    }

    else if (arduino.digitalRead(8)==Arduino.LOW) {
      println("yield");
      rcarArray[i].yspeed = 1;
    }
    else {
      rcarArray[i].yspeed = random(4, 15);
    }
    
  }





  //==============ocar

  for (int i=0;i<ocar2Array.length;i++) {
    ocar2Array[i].draw();

    /*if (arduino.digitalRead(10)==Arduino.LOW) {
     ocar2Array[i].yspeed =0;
     }
     else if (arduino.digitalRead(10)==Arduino.HIGH) {
     
     ocar2Array[i].yspeed = random(4, 15);
     } 
     
    /*else if (arduino.digitalRead(9)==Arduino.HIGH) {
     
     ocar2Array[i].yspeed = random(4, 15);
     
     }
     else if (arduino.digitalRead(8)==Arduino.HIGH) {
     
     ocar2Array[i].yspeed = random(4, 15);
     }*/


    //////////////=================

    /*if (arduino.digitalRead(8)==Arduino.LOW) {
     ocar2Array[i].yspeed = 1;
     }
     else if (arduino.digitalRead(8)==Arduino.HIGH) {
     
     ocar2Array[i].yspeed = random(4, 15);
     }*/

    ////========



    /*if (arduino.digitalRead(9)==Arduino.LOW) {
     ocar2Array[i].yspeed =30;
     }
     else if (arduino.digitalRead(9)==Arduino.HIGH) {
     
     ocar2Array[i].yspeed = random(4, 15);
     }*/


    //

    if (arduino.digitalRead(10)==Arduino.LOW) {
      ocar2Array[i].yspeed =0;
    } 
    else if (arduino.digitalRead(9)==Arduino.LOW) {
      ocar2Array[i].yspeed =30;
    }

    else if (arduino.digitalRead(8)==Arduino.LOW) {
      ocar2Array[i].yspeed = 1;
    }
    else {
      ocar2Array[i].yspeed = random(4, 15);
    }
  }



  /*
if (keyPressed) {
   if (key=='g') {
   restart();
   }
   }
   
   
   
   if (keyPressed) {
   if (key=='s') {
   restart();
   }
   }
   */


  if (timer.isFinished()) {
    //background(random(255),random(255),random(255));
    countAmount++;
    speedTimer++;
    timer.start();
  }





  if (health>0) {
    text("Hits:", 75, 25);
    text(health, 120, 25);
  }
  else {
    partCount=3;
  }
}//end part2


void part3() {

  image(fired, 0, 0);
  restart = 0;


  text("Score:", 270, 400 );
  text(countAmount, 320, 400 );


  if (keyPressed) {
    if (key=='r') {
      restart();
    }
  }
}




void stop()
{
  groove.close();
  minim.stop();
  super.stop();
}



//GAMEOVER CONDITIONS: = = = == = == = == = = = == = =    


void restart() {

  for (int i=0;i<frogArray.length;i++) {
    frogArray[i].reset();
  }
  for (int i=0;i<bunnyArray.length;i++) {
    bunnyArray[i].reset();
  }
  for (int i=0;i<deerArray.length;i++) {
    deerArray[i].reset();
  }
  for (int i=0;i<duckArray.length;i++) {
    duckArray[i].reset();
  }


  for (int i=0;i<ocar2Array.length;i++) {
    ocar2Array[i].reset();
  }
  for (int i=0;i<rcarArray.length;i++) {
    rcarArray[i].reset();
  }


  // reset all animals and cars!


  health=100;
  partCount =1;
}




/////// buttons still need to be programed
//~ 

