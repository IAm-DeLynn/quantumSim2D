
void controlEvent(ControlEvent event) {
}

void realTime() {
  if(!isObserved) timespeed = 1.0;
}

void reverseTime() {
  timespeed *= -1;
}

void takeImg() {
  pg.save(spaceW + "x" + spaceH + "_t=" + nfp(t, 1, 7) + "_m=" + m + "_dx=" + dx + ".png");
}
