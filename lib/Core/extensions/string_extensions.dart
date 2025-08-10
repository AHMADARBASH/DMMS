// ignore_for_file: unnecessary_string_escapes

var numbersOnly = RegExp(r"^\d+$");
var complexPassword =
    RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[A-Za-z\d\W]{8,}');
var bloodType = RegExp(r'^(A|B|AB|O)[+-]$');
var phoneNumber = RegExp(r'^09\d{8}$');

extension NumbersOnly on String {
  bool get isNumbersOnly => numbersOnly.hasMatch(this);
}

extension PasswordString on String {
  bool get isComplexPassword => complexPassword.hasMatch(this);
}

extension BloodType on String {
  bool get isBloodType => bloodType.hasMatch(this);
}

extension PhoneNumber on String {
  bool get isPhoneNumber => phoneNumber.hasMatch(this);
}
