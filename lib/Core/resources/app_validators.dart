import 'package:dmms/Core/extensions/string_extensions.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class AppValidators {
  static String? Function(String?) numbersOnlyValidator = (value) {
    if (value == null || value == '') {
      return AppStrings.required.tr();
    } else if (!value.isNumbersOnly) {
      return AppStrings.valueMustBeNumbersOnly.tr();
    } else {
      return null;
    }
  };

  static String? Function(String?) requiredValidator = (value) {
    if (value == null || value == '') {
      return AppStrings.required.tr();
    }
    return null;
  };
  static String? Function(String?) bloodTypeValidator = (value) {
    if (value == null || value == '') {
      return AppStrings.required.tr();
    } else if (!value.isBloodType) {
      return AppStrings.invalidBloodType.tr();
    } else {
      return null;
    }
  };

  static String? Function(String?) nationalIdValidator = (value) {
    if (value == null || value == '') {
      return AppStrings.required.tr();
    }
    if (!value.isNumbersOnly) {
      return AppStrings.nationalIdMustBeOnlyDigits.tr();
    }
    if (value.length != 11) {
      return AppStrings.nationalIdMustBe11CharOnly.tr();
    }

    return null;
  };

  static String? Function(String?) requiredPhoneNumberValidator = (value) {
    if (value == null || value == '') {
      return AppStrings.required.tr();
    }
    if (!value.isPhoneNumber) {
      return AppStrings.invalidPhoneNumber.tr();
    }

    return null;
  };
  static String? Function(String?) notRequired = (value) {
    return null;
  };
}
