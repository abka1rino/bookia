class AppRegex {
  static final RegExp email = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp password = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  static final RegExp phone = RegExp(r'^\+?[0-9]{10,13}$');
  static final RegExp name = RegExp(r"^[a-zA-Z ,.'-]+$");
  static final RegExp username = RegExp(r'^[a-zA-Z0-9_]{3,15}$');
}
