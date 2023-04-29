enum UnitsOfVolume {
  pinches(1),
  tsp(16),
  tbsp(48),
  cup(768),
  pint(1536),
  quart(3072),
  gallon(12288),
  ounces(0),
  whole(0),
  pounds(0),
  unit(0);

  const UnitsOfVolume(this.inPinches);
  final double inPinches;

  double convert(double amount, UnitsOfVolume to, UnitsOfVolume from) =>
      (amount * from.inPinches) / (to.inPinches);
}
