import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tweet_event.dart';
part 'tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  TweetBloc() : super(TweetInitial());

  @override
  Stream<TweetState> mapEventToState(
    TweetEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
