class Tweet {
  final DateTime time;
  final String content;
  Tweet({required this.time, required this.content});

  String get refKey => this.time.microsecondsSinceEpoch.toString();
}
