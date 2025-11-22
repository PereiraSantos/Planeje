import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnderReviewNotifier with ChangeNotifier {
  int _idDateRevision = -1;
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  UnderReviewNotifier setIdDateRevision(int value) {
    _idDateRevision = value;
    prefs.setInt('id_date_revision', value);
    return this;
  }

  void resetIdDateRevision() {
    _idDateRevision = -1;
    prefs.remove('id_date_revision');
  }

  Future<int> getIdDateRevisionPref() async {
    _idDateRevision = await prefs.getInt('id_date_revision') ?? -1;
    return _idDateRevision;
  }

  int getIdDateRevision() => _idDateRevision;

  void update() => notifyListeners();
}
