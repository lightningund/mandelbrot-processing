class Complex {
  // public BigDecimal x, y;

  // public Complex(BigDecimal cx, BigDecimal cy) {
  //   x = cx;
  //   y = cy;
  // }

  // public void square() {
  //   BigDecimal temp_x = x.pow(2).subtract(y.pow(2));
  //   y = x.multiply(y).multiply(new BigDecimal(2));
  //   x = temp_x;
  // }

  // public float sqMag() {
  //   return x.pow(2).add(y.pow(2)).floatValue();
  // }
  public double x, y;

  public Complex(double cx, double cy) {
    x = cx;
    y = cy;
  }

  public void square() {
    double temp_x = x * x - y * y;
    y = 2 * x * y;
    x = temp_x;
  }

  public double sqMag() {
    return x * x + y * y;
  }
}