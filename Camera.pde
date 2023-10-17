float mid_x, mid_y;

float camera_target_x = 0, camera_target_y = 0;

float smooth_camera_target_x = 0, smooth_camera_target_y = 0;
float pct = 0.0, step = 0.0005;

void Camera(float x1, float y1, float x2, float y2){
  mid_x = x1/2 + x2/2;
  mid_y = y1/2 + y2/2;
  
  if(pct < 1.0){
    smooth_camera_target_x = smooth_camera_target_x + ((mid_x - smooth_camera_target_x) * pct);
    smooth_camera_target_y = smooth_camera_target_y + ((mid_y - smooth_camera_target_y) * pct);
    pct += step;
  }else{
    pct = 0.0;
  }
  
  camera_target_x = (-smooth_camera_target_x+(width/2));
  camera_target_y = (-smooth_camera_target_y+(height/2));
}
