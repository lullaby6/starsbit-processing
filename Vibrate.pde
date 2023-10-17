float tx, ty;
int vibrate_fase = 0, time = 0, vibrate_init = 0;

void vibrate(float intesity, int time_){
  
  if (vibrate_init == 0){
    time = time_;
    vibrate_init = 1;
  }
  
  if(time > 0){
    tx = random(-intesity, intesity);
    ty = random(-intesity, intesity);
    time -= 1;
    
  }else{
    tx = 0;
    ty = 0;
    vibrate_fase = 0;
    time = 0;
    vibrate_init = 0;
  }
  
}
