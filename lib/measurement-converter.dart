//i know this is broken but i wanted to get the unit conversion written down, but
//i don't know how the units are going to be parsed yet, as well as i named it whatever for now
class MeasurementConverter {
  unitConverter(int n, String unit) {
    if (unit == "teaspoon"){
      if (n >=3 && n < 6){
        unit = "tablespoon";
        n = (n/3) as int;
      }
      if (n >=6 && n < 48){
        unit = "oz";
        n = (n/6) as int;
      }
      if (n >=48 && n<96){
        unit = "cup";
        n = (n/48) as int;
      }
      if (n>=96 && n<192){
        unit = "pint";
        n = (n/96) as int;
      }
      if (n>=192 && n<768){
        unit = "quart";
        n = (n/192) as int;
      }
      if (n>=768){
        unit = "gallon";
        n = (n/768) as int;
      }
      return n;
      return unit;
    }
    if (unit == "tablespoon"){
      if (n >=2 && n < 16){
        unit = "oz";
        n = (n/6) as int;
      }
      if (n >=16 && n<32){
        unit = "cup";
        n = (n/16) as int;
      }
      if (n>=32 && n<64){
        unit = "pint";
        n = (n/32) as int;
      }
      if (n>=64 && n<256){
        unit = "quart";
        n = (n/64) as int;
      }
      if (n>=256){
        unit = "gallon";
        n = (n/256) as int;
      }
      return n;
      return unit;
    }
    if (unit == "oz") {
      if (n >= 8 && n < 16) {
        unit = "cup";
        n = (n / 8) as int;
      }
      if (n >= 16 && n < 32) {
        unit = "pint";
        n = (n / 16) as int;
      }
      if (n >= 32 && n < 128) {
        unit = "quart";
        n = (n / 32) as int;
      }
      if (n >= 128) {
        unit = "gallon";
        n = (n / 128) as int;
      }
      return n;
      return unit;
    }
    if (unit == "cup") {
      if (n >= 2 && n < 4) {
        unit = "pint";
        n = (n / 2) as int;
      }
      if (n >= 4 && n < 8) {
        unit = "quart";
        n = (n / 4) as int;
      }
      if (n >= 16) {
        unit = "gallon";
        n = (n / 16) as int;
      }
      return n;
      return unit;
    }
    if (unit == "pint") {
      if (n >= 2 && n < 8) {
        unit = "quart";
        n = (n / 2) as int;
      }
      if (n >=8){
        unit = "gallon";
        n = (n/8) as int;
      }
      return n;
      return unit;
    }
    if (unit == "quart"){
        unit = "gallon";
        n = (n/4) as int;
    }
    return n;
    return unit;
  }
}