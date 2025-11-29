import 'package:planeje/dashboard/entities/revision_data.dart';
import 'package:planeje/dashboard/entities/year.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/utils/format_date.dart';

class BuildDataGraphic {
  List<GraphicData> buildRevisionYear(List<DateRevision> dateRevision) {
    Year year = Year()..buildMonths();

    for (DateRevision item in dateRevision) {
      if (item.dateRevision != null && !item.disable!) {
        DateTime date = FormatDate.dateTimeParse(item.dateRevision!);

        if (FormatDate.newDate().day - date.day <= 360) year = _countValue(date.month, year);
      }
    }

    return _buldGraphic(year);
  }

  List<GraphicData> buildRevisionQuizWrongAnswerYear(List<RevisionQuiz> dateRevision) {
    Year year = Year()..buildMonths();

    for (RevisionQuiz item in dateRevision) {
      if (item.dateRevision != null && !item.disable!) {
        DateTime date = FormatDate.dateTimeParse(item.dateRevision!);

        if (FormatDate.newDate().day - date.day <= 360 && !item.answer!) year = _countValue(date.month, year);
      }
    }

    return _buldGraphic(year);
  }

  List<GraphicData> buildRevisionQuizRightAnswerYear(List<RevisionQuiz> dateRevision) {
    Year year = Year()..buildMonths();

    for (RevisionQuiz item in dateRevision) {
      if (item.dateRevision != null && !item.disable!) {
        DateTime date = FormatDate.dateTimeParse(item.dateRevision!);

        if (FormatDate.newDate().day - date.day <= 360 && item.answer!) year = _countValue(date.month, year);
      }
    }

    return _buldGraphic(year);
  }

  Year _countValue(int key, Year year) {
    year.months[key - 1].value++;
    return year;
  }

  List<GraphicData> _buldGraphic(Year year) {
    List<GraphicData> graphics = [];
    for (var i = 0; i < 12; i++) {
      graphics.add(GraphicData(year.months[i].label, year.months[i].value));
    }

    return graphics;
  }
}
