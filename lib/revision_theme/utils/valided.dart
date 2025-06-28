import 'package:planeje/utils/format_date.dart';

class Valided {
  String validDateIsNull(String? dateRevision) {
    if (dateRevision == null) return '';
    return '${FormatDate.formatDateString(dateRevision)} ${_componentDate(dateRevision)}';
  }

  String _componentDate(String dateRevision) {
    DateTime date = FormatDate.dateTimeParse(dateRevision);
    int day = FormatDate.newDate().difference(date).inDays;

    return day > 0 ? '- há $day dias' : '';
  }

  String validTitleDescriptuionIsNull(String? title, String? description) {
    if (title == null || description == null) return 'Última revisão: Não há';
    return 'Última revisão: $title - $description ';
  }
}
