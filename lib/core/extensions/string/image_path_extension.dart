extension ImageExtension on String {
  String get toJPG => 'assets/images/jpg/$this.jpg';
  String get toJPEG => 'assets/images/jpg/$this.jpeg';
  String get toPNG => 'assets/images/png/$this.png';
  // required package flutter_svg ⬇️
  String get toSVG => 'assets/images/svg/$this.svg';
  // String get toGIF => 'assets/gif/$this.gif';
  // String get toICON => 'assets/icons/$this.png';
}
