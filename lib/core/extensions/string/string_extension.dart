extension StringExtension on String {
  String toConvertEnglish({bool toLowrecase = false}) {
    final turkishChars = {
      'ç': 'c',
      'ğ': 'g',
      'ı': 'i',
      'ö': 'o',
      'ş': 's',
      'ü': 'u',
      'Ç': 'C',
      'Ğ': 'G',
      'İ': 'I',
      'Ö': 'O',
      'Ş': 'S',
      'Ü': 'U',
    };

    final word = split('').map((char) => turkishChars[char] ?? char).join('');

    return toLowrecase ? word.toLowerCase() : word;
  }
}
