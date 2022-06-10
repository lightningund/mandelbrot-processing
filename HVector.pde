class HVector {
  public double x, y;

  public HVector(double x, double y) {
    this.x = x;
    this.y = y;
  }
  
  public void set(HVector other) {
    x = other.x;
    y = other.y;
  }
}
