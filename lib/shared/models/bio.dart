import 'package:formz/formz.dart';

enum BioValidationError {
  invalid,
  empty,
}

class Bio extends FormzInput<String, BioValidationError> {
  const Bio.pure() : super.pure('');
  const Bio.dirty([super.value = '']) : super.dirty();

  @override
  BioValidationError? validator(String value) {
    if (value.isEmpty) {
      return BioValidationError.empty;
    }

    return null;
  }
}
