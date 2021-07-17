part of 'tweet_bloc.dart';

@immutable
abstract class TweetEvent {}

class CreateTweetEvent extends TweetEvent {}

class ReadTweetEvent extends TweetEvent {}

class UpdateTweetEvent extends TweetEvent {}

class DeleteTweetEvent extends TweetEvent {}
