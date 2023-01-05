extension StringExtension on String {
  String? get firstLetterToUpperCase {
    return this[0].toUpperCase() + substring(1);
  }

  String? get eachFirstLetterToUpperCase {
    return split(' ').map((word) => word.firstLetterToUpperCase).join(' ');
  }
}
