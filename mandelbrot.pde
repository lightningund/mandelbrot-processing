import java.math.*;

// The number of times to loop while testing if a point leaves the circle
final int iterations = 2000;

int resolution = 1;

HVector view_start, view_end, new_view_start;

PGraphics mandelbrot;

void setup() {
  size(800, 800);
  //frameRate(100000000);

  view_start = new HVector(0, 0);
  view_end = new HVector(width, height);

  mandelbrot = createGraphics(width, height);
  calc();
}

void calc() {
  println(view_start.x, view_start.y, view_end.x, view_end.y);
  println(view_start.x - view_end.x, view_start.y - view_end.y);
  mandelbrot.beginDraw();
  mandelbrot.colorMode(HSB);
  mandelbrot.noStroke();

  for(float y = 0; y < height; y += resolution) {
    double space_y = dmap(y, 0, height, view_start.y, view_end.y);
    // BigDecimal calc_y = new BigDecimal(map(space_y, 0, height, -2, 2));
    double calc_y = dmap(space_y, 0, height, -2, 2);

    for(float x = 0; x < width; x += resolution) {
      double space_x = dmap(x, 0, width, view_start.x, view_end.x);
      // BigDecimal calc_x = new BigDecimal(map(space_x, 0, width, -2, 2));
      double calc_x = dmap(space_x, 0, width, -2, 2);

      // Complex point = new Complex(BigDecimal.ZERO, BigDecimal.ZERO);
      Complex point = new Complex(0, 0);

      mandelbrot.fill(0);
      float screen_point_x = 0, screen_point_y = 0;

      for(int i = 0; i < iterations; i ++) {
        //float temp_screen_point_x = big_math_thing_x(screen_point_x, screen_point_y) + x;
        //screen_point_y = big_math_thing_y(screen_point_x, screen_point_y) + y;
        //screen_point_x = temp_screen_point_x;
        point.square();
        // point.x = point.x.add(calc_x);
        // point.y = point.y.add(calc_y);
        point.x += calc_x;
        point.y += calc_y;

        //println(point.x, x);
        // point.x = map(screen_point_x, 0, width, -2, 2);
        // point.y = map(screen_point_y, 0, height, -2, 2);
        //println(point.x, x);

        // if(i > 0) println(i, x, y, point.sqMag());

        // if(point.sqMag().compareTo(new BigDecimal(4)) > 0)
        if(point.sqMag() > 4) {
          mandelbrot.fill(i * 8 % 256, 256, 255);
          break;
        }
      }

      mandelbrot.square(x, y, resolution);
    }
  }
  mandelbrot.endDraw();
}

// z=(x-a)*(d-c)/(b-a)
// f = -((a - b) * (c + y^2 - z^2))/(c - d)

// (b-a)*((c+y^2-((((x-a)^2)*((d-c)^2))/((b-a)^2)))/(c-d))

//float big_math_thing_x(float x, float y) {
//  float a_x = 0; // Start of the screen range
//  float b_x = width; // End of the screen range
//  float c_x = view_start.x * 4 / width - 2; // Start of the calc range
//  float d_x = view_end.x * 4 / width - 2; // End of the calc range
//  float s_x = (b_x - a_x) / (c_x - d_x); // Ratio to convert from screen to calc

//  float a_y = 0; // Start of the screen range
//  float b_y = height; // End of the screen range
//  float c_y = view_start.y * 4 / height - 2; // Start of the calc range
//  float d_y = view_end.y * 4 / height - 2; // End of the calc range
//  float s_y = (b_y - a_y) / (c_y - d_y); // Ratio to convert from screen to calc

//  return s_x * (c_x + pow((y - a_y) / s_y, 2) + pow((x - a_x) / s_x, 2));
//}

//float big_math_thing_y(float x, float y) {
//  float a_x = 0; // Start of the screen range
//  float b_x = width; // End of the screen range
//  float c_x = view_start.x * 4 / width - 2; // Start of the calc range
//  float d_x = view_end.x * 4 / width - 2; // End of the calc range
//  float s_x = (b_x - a_x) / (c_x - d_x); // Ratio to convert from screen to calc

//  float a_y = 0; // Start of the screen range
//  float b_y = height; // End of the screen range
//  float c_y = view_start.y * 4 / height - 2; // Start of the calc range
//  float d_y = view_end.y * 4 / height - 2; // End of the calc range
//  float s_y = (b_y - a_y) / (c_y - d_y); // Ratio to convert from screen to calc

//  return ((2 * ((y - a_y) / s_y) * ((x - a_x) / s_x)) - c_y) * s_y;
//}

void draw() {
  //background(255);
  image(mandelbrot, 0, 0);

  if(new_view_start != null) {
    stroke(128);
    noFill();
    float screen_x = (float)dmap(new_view_start.x, view_start.x, view_end.x, 0, width);
    float screen_y = (float)dmap(new_view_start.y, view_start.y, view_end.y, 0, height);
    float dx = mouseX - screen_x;
    float dy = mouseY - screen_y;
    rect(screen_x, screen_y, dx, dy);
  }

  //println(frameRate);
}

void mouseClicked() {
  double space_x = dmap(mouseX, 0, width, view_start.x, view_end.x);
  double space_y = dmap(mouseY, 0, height, view_start.y, view_end.y);
  HVector mouse_screen_coords = new HVector(space_x, space_y);
  if(new_view_start == null) {
    new_view_start = mouse_screen_coords;
  } else {
    view_start.set(new_view_start);
    view_end = mouse_screen_coords;
    new_view_start = null;
    
    calc();
  }
}
