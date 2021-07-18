part of 'tweet_bloc.dart';

@immutable
abstract class TweetState {}

class TweetInitial extends TweetState {}

class ReadTweetState extends TweetState {}

class CreateTweetSuccessState extends TweetState {}

class UpdateTweetSuccessState extends TweetState {}

class DeleteTweetSuccessState extends TweetState {}

class TweetActionFailState extends TweetState {
  final dynamic error;
  TweetActionFailState({this.error});
}
