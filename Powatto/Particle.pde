class Particle {
  boolean alive;
  float size = 10.0;
  float wander;
  float theta;
  float drag;
  color col;
  PVector location;
  PVector velocity;
  float wander1 = 0.5;
  float wander2 = 2.0;
  float drag1 = 0.9;
  float drag2 = 0.99;
  float force1 = 2;
  float force2 = 8;
  float theta1 = -0.5;
  float theta2 = 0.5;
  float sizeScalar = 0.97;
  
  Particle(float x, float y, float SIZE) {
    alive = true;
    size = SIZE;
    wander = 0.15;
    theta = random( TWO_PI );
    //drag = 0.92;
    drag = 92;
    col = color(255);
    location = new PVector(x, y);
    velocity = new PVector(0.0, 0.0);

    float force;
    this.wander = random( wander1, wander2 );
    this.col = COLORS[round(random(0, colState))];
    this.drag = random( drag1, drag2 );
    theta = random( TWO_PI );
    force = random( force1, force2 );
    this.velocity.x = sin( theta ) * force;
    this.velocity.y = cos( theta ) * force;
  }

  void move() {
    location.add(velocity);
    velocity.mult(drag);
    theta += random(theta1, theta2) * wander;
    velocity.x += sin(theta) * 0.1;
    velocity.y += cos(theta) * 0.1;
    size *= sizeScalar;
    alive = size > 0.5;
  }  

  void show() {
    fill(col);
    noStroke();
    smooth();
    ellipse(location.x, location.y, size, size);
  }
}