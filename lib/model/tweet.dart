class Tweet {
  final DateTime time;
  final String content;
  Tweet({required this.time, required this.content});

  /// method
  ///

  String intervalTimeWith({required DateTime flagTime}) {
    var difference;
    if ((difference = flagTime.difference(time).inDays) >= 1) {
      return '${difference.toString()}d';
    } else if ((difference = flagTime.difference(time).inHours) >= 1) {
      return '${difference.toString()}h';
    } else if ((difference = flagTime.difference(time).inMinutes) >= 1) {
      return '${difference.toString()}m';
    } else if ((difference = flagTime.difference(time).inSeconds) >= 0) {
      return '${difference.toString()}sec';
    } else if ((difference = flagTime.difference(time).inDays) < 0) {
      return '${difference.toString()}d';
    } else if ((difference = flagTime.difference(time).inHours) < 0) {
      return '${difference.toString()}h';
    } else if ((difference = flagTime.difference(time).inMinutes) < 0) {
      return '${difference.toString()}m';
    } else if ((difference = flagTime.difference(time).inSeconds) < 0) {
      return '${difference.toString()}sec';
    }
    return 'unknown time difference: ${difference.toString()}';
  }

  /// getter
  ///

  String get refKey => this.time.microsecondsSinceEpoch.toString();
}
