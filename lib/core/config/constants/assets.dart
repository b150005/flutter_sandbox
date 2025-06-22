enum Assets {
  flutterIcon(path: 'assets/images/flutter-icon.png'),
  firebase(path: 'assets/images/firebase.png');

  const Assets({required this.path});

  final String path;
}
