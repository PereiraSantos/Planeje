class Month {
  int value;
  String label;

  Month(this.value, this.label);

  static dynamic getLabelMonth(int index) {
    List<String> labelMonths = ['Jan.', 'Fev.', 'Mar.', 'Abr.', 'Mai.', 'Jun.', 'Jul.', 'Ago.', 'Set.', 'Out.', 'Nov.', 'Dez.'];
    return labelMonths[index];
  }
}
