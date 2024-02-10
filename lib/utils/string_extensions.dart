extension StringX on String {
  String removeFirstWord() {
    return split(' ').skip(1).join(' ');
  }
}