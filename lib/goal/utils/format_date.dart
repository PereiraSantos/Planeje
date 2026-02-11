import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class FormatDate {
  FormatDate() {
    initializeDateFormatting();
    Intl.defaultLocale = 'pt_BR';
  }

  static DateTime newDate() => DateTime.now();

  static String formatDataBase(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  static DateTime dateParse(String date) => DateFormat('dd/MM/yyyy').parse(date);

  static String formatDateWek(String date) => date != '' ? DateFormat("d 'de' MMMM',' y", "pt_BR").format(dateParse(date)) : '';
}
