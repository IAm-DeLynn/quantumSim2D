
void controlEvent(ControlEvent event) {
}

void realTime() {
  if(!isObserved) timespeed = 1.0;
}

void reverseTime() {
  timespeed *= -1;
}

void takeImg() {
  pg.save((spaceW - 2) + "x" + (spaceH - 2) + " t" + nfp(t, 1, 7) + " m" + m + " dx" + dx + ".png");
}
