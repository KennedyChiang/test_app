import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tweet_event.dart';
part 'tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  final BuildContext context;

  TweetBloc(this.context) : super(TweetInitial());

  @override
  Stream<TweetState> mapEventToState(
    TweetEvent event,
  ) async* {
    if (event is CreateTweetEvent) {}
    if (event is ReadTweetEvent) {}
    if (event is UpdateTweetEvent) {}
    if (event is DeleteTweetEvent) {}
  }
}
