PGraphics drawTex;

void setup() {
  size(800, 600, P2D);
  
  drawTex = createGraphics(width, height, P2D);
  drawTex.beginDraw();
  drawTex.background(0);
  drawTex.fill(0,10);
  drawTex.noStroke();
  drawTex.endDraw();
  
  setupShaders();
  bloomSetup();
  background(0);
}

void draw() {

  drawTex.beginDraw();
  updateShaders();
  drawTex.rect(0,0,width,height);
  drawTex.filter(shader);
  drawTex.endDraw();
  
  tex.beginDraw();
  tex.image(drawTex,0,0);
  tex.endDraw();
  
  bloomDraw();
}