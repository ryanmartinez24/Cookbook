class Measurement {
  String unit;
  double amount;

  Measurement(this.unit, this.amount) {
    _simplify();
  }

  void scale(int scale) {
    amount = amount * scale;
    _simplify();
  }

  void _simplify() {
    double n = amount;

    if (unit == "tsp") {
      if (n < 3) {}
      if (n >= 3 && n < 6) {
        unit = "tbsp";
        n = (n / 3);
      }
      if (n >= 6 && n < 48) {
        unit = "oz";
        n = (n / 6);
      }
      if (n >= 48 && n < 96) {
        unit = "cup";
        n = (n / 48);
      }
      if (n >= 96 && n < 192) {
        unit = "pint";
        n = (n / 96);
      }
      if (n >= 192 && n < 768) {
        unit = "quart";
        n = (n / 192);
      }
      if (n >= 768) {
        unit = "gallon";
        n = (n / 768);
      }
      amount = (n * 1000).round().toDouble() / 1000;
    }
    if (unit == "tbsp") {
      if (n < 1) {
        unit = "tsp";
        n = (n * 3);
      }
      if (n >= 1 && n < 2) {}
      if (n >= 2 && n < 16) {
        unit = "oz";
        n = (n / 6);
      }
      if (n >= 16 && n < 32) {
        unit = "cup";
        n = (n / 16);
      }
      if (n >= 32 && n < 64) {
        unit = "pint";
        n = (n / 32);
      }
      if (n >= 64 && n < 256) {
        unit = "quart";
        n = (n / 64);
      }
      if (n >= 256) {
        unit = "gallon";
        n = (n / 256);
      }
      amount = (n * 1000).round().toDouble() / 1000;
    }
    if (unit == "oz") {
      if (n >= 0 && n < 0.5) {
        unit = "tsp";
        n = (n * 6);
      }
      if (n >= 0.5 && n < 1) {
        unit = "tbsp";
        n = (n * 2);
      }
      if (n >= 1 && n < 8) {}
      if (n >= 8 && n < 16) {
        unit = "cup";
        n = (n / 8);
      }
      if (n >= 16 && n < 32) {
        unit = "pint";
        n = (n / 16);
      }
      if (n >= 32 && n < 128) {
        unit = "quart";
        n = (n / 32);
      }
      if (n >= 128) {
        unit = "gallon";
        n = (n / 128);
      }
      amount = (n * 1000).round().toDouble() / 1000;
    }
    if (unit == "cup") {
      if (n >= 0 && n < 0.0625) {
        n = (n * 48);
        unit = "tsp";
      }
      if (n >= 0.0625 && n < 0.125) {
        n = (n * 16);
        unit = "tbsp";
      }
      if (n >= 0.125 && n < 1) {
        n = (n * 8);
        unit = "oz";
      }
      if (n >= 1 && n < 2) {}
      if (n >= 2 && n < 4) {
        unit = "pint";
        n = (n / 2);
      }
      if (n >= 4 && n < 8) {
        unit = "quart";
        n = (n / 4);
      }
      if (n >= 16) {
        unit = "gallon";
        n = (n / 16);
      }
      amount = (n * 1000).round().toDouble() / 1000;
    }
    if (unit == "pint") {
      if (n >= 0 && n < 0.0313) {
        n = (n * 96);
        unit = "tsp";
      }
      if (n >= 0.0313 && n < 0.0625) {
        n = (n * 32);
        unit = "tbsp";
      }
      if (n >= 0.0625 && n < 0.5) {
        n = (n * 16);
        unit = "oz";
      }
      if (n >= 0.5 && n < 1) {
        n = (n * 2);
        unit = "cup";
      }
      if (n >= 1 && n < 2) {}
      if (n >= 2 && n < 8) {
        unit = "quart";
        n = (n / 2);
      }
      if (n >= 8) {
        unit = "gallon";
        n = (n / 8);
      }
      amount = (n * 1000).round().toDouble() / 1000;
    }
    if (unit == "quart") {
      if (n >= 0 && n < 0.0104) {
        n = (n * 1111111);
        unit = "tsp";
      }
      if (n >= 0.0104 && n < 0.0313) {
        n = (n * 96);
        unit = "tbsp";
      }
      if (n >= 0.0313 && n < 0.0625) {
        n = (n * 32);
        unit = "oz";
      }
      if (n >= 0.0625 && n < 0.5) {
        n = (n * 16);
        unit = "cup";
      }
      if (n >= 0.5 && n < 1) {
        n = (n * 2);
        unit = "pint";
      }
      if (n >= 1 && n < 4) {}
      if (n >= 4) {
        unit = "gallon";
        n = (n / 4);
      }
      if (unit == "gallon") {
        if (n >= 0 && n < 0.0020) {
          n = (n * 1536);
          unit = "tsp";
        }
        if (n >= 0.0020 && n < 0.0039) {
          n = (n * 512);
          unit = "tbsp";
        }
        if (n >= 0.0039 && n < 0.0313) {
          n = (n * 256);
          unit = "oz";
        }
        if (n >= 0.0313 && n < 0.25) {
          n = (n * 32);
          unit = "cup";
        }
        if (n >= 0.25 && n < 1) {
          n = (n * 4);
          unit = "quart";
        }
        if (n >= 1) {}
      }
    }
    amount = (n * 1000).round().toDouble() / 1000;
  }
}
