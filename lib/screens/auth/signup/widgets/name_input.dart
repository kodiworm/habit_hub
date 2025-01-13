import 'package:formz/formz.dart';

// Define the validation error for NameInput
enum NameValidationError { empty }

// Create the NameInput class
class NameInput extends FormzInput<String, NameValidationError> {
  // Constructor for the pure state
  const NameInput.pure() : super.pure('');

  // Constructor for the dirty state
  const NameInput.dirty([String value = '']) : super.dirty(value);

  // Validation logic for name
  @override
  NameValidationError? validator(String value) {
    return value.isNotEmpty ? null : NameValidationError.empty;
  }
}
