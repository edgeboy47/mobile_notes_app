import 'package:mobile_notes_app/notes/data/models/note.dart';

String formattedDate(Note note) {
    final dt = note.dateTime;

    final weekday = dt.weekday;
    final hour = dt.hour;
    final min = dt.minute;

    final _weekday = <int, String>{
      DateTime.monday: 'Mon',
      DateTime.tuesday: 'Tues',
      DateTime.wednesday: 'Wed',
      DateTime.thursday: 'Thur',
      DateTime.friday: 'Fri',
      DateTime.saturday: 'Sat',
      DateTime.sunday: 'Sun',
    }[weekday];

    final _hour = hour < 10 ? '0$hour' : '$hour';
    final _min = min < 10 ? '0$min' : '$min';

    return '$_weekday, $_hour:$_min';
  }