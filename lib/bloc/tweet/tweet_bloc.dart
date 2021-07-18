import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';
import 'package:test_app/model/tweet.dart';

export 'package:test_app/model/tweet.dart';

part 'tweet_event.dart';
part 'tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  final BuildContext context;
  final DatabaseReference _realtimeDB = FirebaseDatabase.instance.reference();
  late DataSnapshot _readData;
  late StreamSubscription _realtimeDBSubscription;

  TweetBloc(this.context) : super(TweetInitial()) {
    final id = BlocProvider.of<AuthBloc>(context).googleId ?? '';
    _realtimeDBSubscription =
        _realtimeDB.child(id).onValue.listen((Event event) {
      if (event.snapshot.value != null) {
        if (false == this.state is TweetInitial) {
          this.add(ReadTweetEvent());
        }
      }
    });
  }

  @override
  Future<void> close() {
    _realtimeDBSubscription.cancel();
    return super.close();
  }

  @override
  Stream<TweetState> mapEventToState(
    TweetEvent event,
  ) async* {
    if (event is CreateTweetEvent) {
      try {
        final id = BlocProvider.of<AuthBloc>(context).googleId ?? '';
        if (id.isEmpty) {
          yield TweetActionFailState(error: 'could not get user id');
          return;
        }
        final data = <String, dynamic>{
          'content': event.content,
        };
        _realtimeDB.child(id).child(_timeKey).set(data);
        yield CreateTweetSuccessState();
      } catch (e) {
        debugPrint('CreateTweetEvent got exception: $e');
        yield TweetActionFailState(error: e);
      }
    }
    if (event is ReadTweetEvent) {
      try {
        final id = BlocProvider.of<AuthBloc>(context).googleId ?? '';
        if (id.isEmpty) {
          yield TweetActionFailState(error: 'could not get user id');
          return;
        }
        _readData = await _realtimeDB.once();
        yield ReadTweetState();
      } catch (e) {
        debugPrint('ReadTweetEvent got exception: $e');
        yield TweetActionFailState(error: e);
      }
    }
    if (event is UpdateTweetEvent) {
      try {
        final id = BlocProvider.of<AuthBloc>(context).googleId ?? '';
        if (id.isEmpty) {
          yield TweetActionFailState(error: 'could not get user id');
          return;
        }
        final data = <String, dynamic>{
          'content': event.content,
          'update_time': _timeKey,
        };
        _realtimeDB.child(id).child(event.refKey).update(data);
        yield UpdateTweetSuccessState();
      } catch (e) {
        debugPrint('UpdateTweetEvent got exception: $e');
        yield TweetActionFailState(error: e);
      }
    }
    if (event is DeleteTweetEvent) {
      try {
        final id = BlocProvider.of<AuthBloc>(context).googleId ?? '';
        if (id.isEmpty) {
          yield TweetActionFailState(error: 'could not get user id');
          return;
        }
        _realtimeDB.child(id).child(event.refKey).remove();
        yield DeleteTweetSuccessState();
      } catch (e) {
        debugPrint('DeleteTweetEvent got exception: $e');
        yield TweetActionFailState(error: e);
      }
    }
  }

  List<Tweet> get displayTweets {
    try {
      final id = BlocProvider.of<AuthBloc>(context).googleId ?? '';
      if (id.isEmpty) {
        return <Tweet>[];
      }
      final data = _readData.value as Map<Object?, Object?>;
      final userData = data[id] as Map<Object?, Object?>;
      final result = userData.keys.map((time) {
        final tweetData = userData[time] as Map<Object?, Object?>;
        return Tweet(
          time: DateTime.fromMicrosecondsSinceEpoch(
            int.parse(time.toString()),
          ),
          content: tweetData['content']!.toString(),
        );
      }).toList();
      result.sort((t1, t2) => t2.time.compareTo(t1.time));
      return result;
    } catch (e) {
      debugPrint('displayContent got exception: $e');
      return <Tweet>[];
    }
  }

  String get _timeKey =>
      DateTime.now().toUtc().microsecondsSinceEpoch.toString();
}
