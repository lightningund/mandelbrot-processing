final float ln2f = log(2);

float log2(float n) {
  return(log(n) / ln2f);
}

float logb(float n, float b) {
  return(log(n) / log(b));
}

float doubleLogB(float n, float b) {
  return(logb(logb(n, b), b));
}

BigDecimal big_map(BigDecimal num, BigDecimal aMin, BigDecimal aMax, BigDecimal bMin, BigDecimal bMax) {
  BigDecimal aRange = aMax.subtract(aMin);
  BigDecimal bRange = bMax.subtract(bMin);

  return num
    .subtract(aMin)
    .divide(aRange, 100, RoundingMode.HALF_UP)
    .multiply(bRange)
    .add(bMin);
}

// <T int | double | float> BigDecimal bigMap(T num, T aMin, T aMax, T bMin, T bMax) {
//   return bigMap(
//     new BigDecimal(num),
//     new BigDecimal(aMin),
//     new BigDecimal(aMax),
//     new BigDecimal(bMin),
//     new BigDecimal(bMax)
//   );
// }

BigDecimal big_map(double num, double aMin, double aMax, double bMin, double bMax) {
  //println(num, aMin, aMax, bMin, bMax);
  return big_map(
    new BigDecimal(num),
    new BigDecimal(aMin),
    new BigDecimal(aMax),
    new BigDecimal(bMin),
    new BigDecimal(bMax)
  );
}

BigDecimal big_map(float num, float aMin, float aMax, float bMin, float bMax) {
  return big_map((double)num, (double)aMin, (double)aMax, (double)bMin, (double)bMax);
}

BigDecimal big_map(int num, int aMin, int aMax, int bMin, int bMax) {
  return big_map((double)num, (double)aMin, (double)aMax, (double)bMin, (double)bMax);
}

double dmap(double num, double aMin, double aMax, double bMin, double bMax) {
  double aRange = aMax - aMin;
  double bRange = bMax - bMin;

  return (num - aMin) * bRange / aRange + bMin;
}
