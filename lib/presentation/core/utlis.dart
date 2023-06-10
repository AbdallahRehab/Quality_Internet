import 'package:intl/intl.dart';

final devMode = false;

const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

bool isHaveArabicNum(String text) {
  for (int x = 0; x < farsi.length; x++) {
    if (text.contains(farsi[x])) {
      return true;
    }
  }
  return false;
}

String dateTimeFormat(String date) {
  final f = DateFormat('yyyy-MM-dd, hh:mm');
  return f.format(DateTime.parse(date));
}

String dateFormat(String date) {
  final f = DateFormat('yyyy-MM-dd');
  return f.format(DateTime.parse(date));
}

String dateFormatNames(String date) {
  final f = DateFormat('MMMEd');
  return f.format(DateTime.parse(date));
}
