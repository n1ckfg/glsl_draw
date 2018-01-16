void setup() {
  size(800, 600, P2D);
  bloomSetup();
  setupShaders();
  background(0);
  tex.fill(0, 10);
  tex.noStroke();
}

void draw() {
  updateShaders();
  tex.beginDraw();
  tex.blendMode(NORMAL);
  tex.rect(0,0,width,height);
  tex.blendMode(ADD);
  tex.filter(shader);
  tex.endDraw();
  bloomDraw();
}