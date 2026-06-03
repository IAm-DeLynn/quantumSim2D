
color colFromAng(float angle, float br) {
  final int q = floor(angle / HALF_PI);
  float t = angle % HALF_PI / HALF_PI;
  
  color output = #000000;
  
  switch(q) {
    case 0: // Yellow > green
    output = color(255 * (1 - t) * br, 255 * br, 0);
    break;
    
    case 1: // Green > cyan
    output = color(0, 255 * br, 255 * t * br);
    break;
    
    case 2: // cyan > purple
    output = color(255 * t * br, 255 * (1 - t) * br, 255 * br);
    break;
    
    case 3: // purple > yellow
    output = color(255 * br, 255 * t * br, 255 * (1 - t) * br);
    break;
  }
  
  return output;
}
