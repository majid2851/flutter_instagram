
extension RemoveAll on String {
  String removeAll(Iterable<String> values) {
    return values.fold(
      this,
          (result, value) => result.replaceAll(value, ''),
    );
  }
}
