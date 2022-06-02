class Helper {
  String timeDifference({required String createdTime}) {
    int totalDays =
        DateTime.now().difference(DateTime.parse(createdTime)).inDays;

    int years = totalDays ~/ 365;
    int months = (totalDays - years * 365) ~/ 30;
    int days = totalDays - years * 365 - months * 30;

    if (years == 0) {
      if (months == 0) {
        return days.toString() + ' days';
      }
      return months.toString() + ' Months ' + days.toString() + ' Days';
    }
    return years.toString() +
        ' Years ' +
        months.toString() +
        ' Months ' +
        days.toString() +
        ' Days';
  }

  String liveRestTimer({required DateTime dateTime, required int minLimit}) {
    //
    Duration limitDuration = Duration(days: 0, hours: 0, minutes: minLimit);
    //
    Duration diffDuration = DateTime.now().difference(dateTime);
    //
    Duration finalRes = limitDuration - diffDuration;
    //
    int resInSeconds = finalRes.inSeconds;

    int min = resInSeconds ~/ 60;
    int sec = resInSeconds - (min * 60);

    if (min <= 0 && sec <= 0) {
      return '00:00';
    }

    if (min < 10) {
      if (sec < 10) {
        return min.toString() + ':' + '0' + sec.toString();
      }
      return '0' + min.toString() + ':' + sec.toString();
    }

    if (sec < 10) {
      return min.toString() + ':' + '0' + sec.toString();
    }

    return min.toString() + ':' + sec.toString();
  }
}
