import 'package:form_field_validator/form_field_validator.dart';

class NoWhiteSpaceStringValidator extends TextFieldValidator {
  // pass the error text to the super constructor
  NoWhiteSpaceStringValidator(
      {String errorText = 'Please enter a valid string'})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(String? value) {
    return !RegExp(r"\s").hasMatch(value.toString());
  }
}
