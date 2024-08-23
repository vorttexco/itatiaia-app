extension ListExtension on List {
  String getDay(int index) {
    switch (index) {
      case 1:
        return 'domingos';
      case 2:
        return 'Segundas';
      case 3:
        return 'terças';
      case 4:
        return 'quartas';
      case 5:
        return 'quintas';
      case 6:
        return 'sextas';
      case 7:
        return 'sábados';

      default:
        return '';
    }
  }

  String get toWeekName => _toWeekName();

  String _toWeekName() {
    final days = [0, 1, 2, 3, 4, 5, 6]
        .map(
          (e) => getDay(e),
        )
        .toString()
        .replaceAll('(', '')
        .replaceAll(')', '');
    return 'Aos $days';
  }
}
