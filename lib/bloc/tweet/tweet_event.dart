part of 'tweet_bloc.dart';

@immutable
abstract class TweetEvent {}

class CreateTweetEvent extends TweetEvent {
  final String content;
  CreateTweetEvent({required this.content});
}

class ReadTweetEvent extends TweetEvent {}

class UpdateTweetEvent extends TweetEvent {
  final String content;
  final String refKey;
  UpdateTweetEvent({required this.content, required this.refKey});
}

class DeleteTweetEvent extends TweetEvent {
  final String refKey;
  DeleteTweetEvent({required this.refKey});
}
