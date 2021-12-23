

class ReusableMethods {
  static final ReusableMethods _reusableMethods = ReusableMethods._internal();
  factory ReusableMethods() {
    return _reusableMethods;
  }
  ReusableMethods._internal();

  String replaceAndCapitalizeFirstLetter(String? text) =>
      (text?.replaceAll(RegExp('_'), ' ').split(" ").map((str)=>str[0].toUpperCase() + str.substring(1)).join(" "))??"";
}
