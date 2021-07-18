import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/model/tweet.dart';

void main() {
  test('Test Tweet date time', () {
    final microsecondsTime = 1626610388283482; // 2021-07-18T20:13:08.283482
    final time = DateTime.fromMicrosecondsSinceEpoch(microsecondsTime);
    final testMessage = 'Test Tweet 1';
    final tweet1 = Tweet(
      time: time,
      content: testMessage,
    );
    expect(tweet1.time.microsecondsSinceEpoch, microsecondsTime);
    expect(tweet1.refKey, microsecondsTime.toString());

    // sec expect
    final compareTime = 1626610389283482; // 2021-07-18T20:13:09.283482
    expect(
      tweet1.intervalTimeWith(
        flagTime: DateTime.fromMicrosecondsSinceEpoch(compareTime),
      ),
      '1sec',
    );

    // minutes expect
    final compareTime2 = 1626610489283482; // 2021-07-18T20:14:49.283482
    expect(
      tweet1.intervalTimeWith(
        flagTime: DateTime.fromMicrosecondsSinceEpoch(compareTime2),
      ),
      '1m',
    );

    // hour expect
    final compareTime3 = 1626618389283482; // 2021-07-18T22:26:29.283482
    expect(
      tweet1.intervalTimeWith(
        flagTime: DateTime.fromMicrosecondsSinceEpoch(compareTime3),
      ),
      '2h',
    );

    // day expect
    final compareTime4 = 1626910389283482; // 2021-07-22T07:33:09.283482
    expect(
      tweet1.intervalTimeWith(
        flagTime: DateTime.fromMicrosecondsSinceEpoch(compareTime4),
      ),
      '3d',
    );

    /// negative expect
    ///

    // negative sec expect
    final compareTime5 = 1626610368283482; // 2021-07-18T20:12:48.283482
    expect(
      tweet1.intervalTimeWith(
        flagTime: DateTime.fromMicrosecondsSinceEpoch(compareTime5),
      ),
      '-20sec',
    );

    // negative minutes expect
    final compareTime6 = 1626610268283482; // 2021-07-18T20:11:08.283482
    expect(
      tweet1.intervalTimeWith(
        flagTime: DateTime.fromMicrosecondsSinceEpoch(compareTime6),
      ),
      '-2m',
    );

    // negative hour expect
    final compareTime7 = 1626602268283482; // 2021-07-18T17:57:48.283482
    expect(
      tweet1.intervalTimeWith(
        flagTime: DateTime.fromMicrosecondsSinceEpoch(compareTime7),
      ),
      '-2h',
    );

    // negative day expect
    final compareTime8 = 1616506388283482; // 2021-03-23T21:33:08.283482
    expect(
      tweet1.intervalTimeWith(
        flagTime: DateTime.fromMicrosecondsSinceEpoch(compareTime8),
      ),
      '-116d',
    );

    expect(tweet1.content, testMessage);
  });
}
