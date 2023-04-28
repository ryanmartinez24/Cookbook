import 'package:fp_recipe_book/units_of_volume.dart';

class Measurement {
  double _amount;
  UnitsOfVolume _unitOfVolume;

  Measurement(this._amount, this._unitOfVolume);

  double convert(UnitsOfVolume to) {
    _amount = _unitOfVolume.convert(_amount, to, _unitOfVolume);
    _unitOfVolume = to;
    return _amount;
  }

  void scale(double scale) {
    _amount = _amount * scale;

    for (int i = 0; i < 7; i++) {
      UnitsOfVolume newUnit = UnitsOfVolume.values[i];
      if (newUnit.inPinches < _amount * _unitOfVolume.inPinches) {
        convert(newUnit);
      }
    }
  }

  get amount => _amount;
  get unitOfVolume => _unitOfVolume;

  // returns deep copy of measurement
  Measurement getCopy() {
    return Measurement(_amount, _unitOfVolume);
  }

  Map toJson() {
    String unitName = _unitOfVolume.name;

    return {
      "amount": _amount,
      "unitOfVolume": unitName,
    };
  }

  factory Measurement.fromJson(dynamic json) {
    return Measurement(
      json['amount'] as double,
      UnitsOfVolume.values.byName(json['unitOfVolume']),
    );
  }
}
