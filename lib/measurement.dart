class Measurement {
  String _unit;
  double _amount;

  List<List> unitTable = [
    ['pinch', 2],
    ['tsp', 3, 0.125],
    ['tbsp', 3, 0.5],
    ['cups', 4, 0.25],
    ['quarts', 4, 1],
    ['gallons', 1, 1]
  ];

  Measurement(this._unit, this._amount) {
    _simplifyUp();
    _simplifyDown();
  }

  void scale(double scale) {
    _amount = _amount * scale;

    if (scale > 1) {
      _simplifyUp();
    } else {
      _simplifyDown();
    }

    _amount = (_amount * 1000).round().toDouble() / 1000;
  }

  void _simplifyUp() {
    for (int i = 0; i < unitTable.length - 1; i++) {
      if (_unit == unitTable[i][0]) {
        while (_amount >= unitTable[i][1]) {
          _unit = unitTable[i + 1][0];
          _amount = _amount / unitTable[i][1];
        }
      }
    }
  }

  void _simplifyDown() {
    for (int i = unitTable.length - 1; i > 0; i--) {
      if (_unit == unitTable[i][0]) {
        while (_amount < unitTable[i][2]) {
          _unit = unitTable[i - 1][0];
          _amount = _amount * unitTable[i - 1][1];
        }
      }
    }
  }

  String getUnit() {
    return _unit;
  }

  double getAmount() {
    return _amount;
  }

  // returns deep copy of measurement
  Measurement getCopy() {
    return Measurement(_unit, _amount);
  }
}
