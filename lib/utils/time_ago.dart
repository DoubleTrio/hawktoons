import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:history_app/l10n/l10n.dart';
import 'package:intl/intl.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class TimeAgo implements TimeConverter {
  const TimeAgo({this.locale = 'en', required this.l10n});

  final AppLocalizations l10n;

  @override
  final String locale;

  @override
  String timeAgoSinceDate(Timestamp timestamp, {bool numericDates = true}) {
    var notificationDate = timestamp.toDate();
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      var dateString =
          DateFormat('dd MMM yyyy', locale).format(notificationDate);
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? l10n.oneWeekNumeric : l10n.oneWeek;
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} ${l10n.daysAgo}';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? l10n.oneDay : l10n.oneDayNumeric;
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} ${l10n.hoursAgo}';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? l10n.oneHourNumeric : l10n.oneHour;
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} ${l10n.hoursAgo}';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? l10n.oneMinuteNumeric : l10n.oneMinute;
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} ${l10n.secondsAgo}';
    } else {
      return l10n.justNow;
    }
  }
}
