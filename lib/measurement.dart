class Measurement {
  String unit;
  double amount;

  List<List> unitTable = [
    ['pinch', 2],
    ['tsp', 3, 0.125],
    ['tbsp', 3, 0.5],
    ['cups', 4, 0.25],
    ['quarts', 4, 1],
    ['gallons', 1, 1]
  ];

  Measurement(this.unit, this.amount) {
    _simplifyUp();
    _simplifyDown();
  }

  void scale(double scale) {
    amount = amount * scale;

    if (scale > 1) {
      _simplifyUp();
    } else {
      _simplifyDown();
    }

    amount = (amount * 1000).round().toDouble() / 1000;
  }

  void _simplifyUp() {
    for (int i = 0; i < unitTable.length - 1; i++) {
      if (unit == unitTable[i][0]) {
        while (amount >= unitTable[i][1]) {
          unit = unitTable[i + 1][0];
          amount = amount / unitTable[i][1];
        }
      }
    }
  }

  void _simplifyDown() {
    for (int i = unitTable.length - 1; i > 0; i--) {
      if (unit == unitTable[i][0]) {
        while (amount < unitTable[i][2]) {
          unit = unitTable[i - 1][0];
          amount = amount * unitTable[i - 1][1];
        }
      }
    }
  }
}
