class Tweet {
  final DateTime time;
  final String content;
  Tweet({required this.time, required this.content});

  String get refKey => this.time.microsecondsSinceEpoch.toString();

  String get intervalTime {
    final now = DateTime.now();
    var difference;
    if ((difference = now.difference(time).inDays) > 1) {
      return '${difference.toString()}d';
    } else if ((difference = now.difference(time).inHours) > 1) {
      return '${difference.toString()}h';
    } else if ((difference = now.difference(time).inMinutes) > 1) {
      return '${difference.toString()}m';
    }
    difference = now.difference(time).inSeconds;
    return '${difference.toString()}sec';
  }
}
