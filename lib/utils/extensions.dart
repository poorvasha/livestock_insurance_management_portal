extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

extension ListExtension<T> on Iterable<T> {
  Iterable<T> handleEmpty(T empty) {
    if (isEmpty) {
      return [empty];
    }
    return this;
  }
}
