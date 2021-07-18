import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';
import 'package:test_app/model/tweet.dart';
import 'package:test_app/view/avatar.dart';

class TweetCell extends StatelessWidget {
  final Tweet tweet;
  final VoidCallback? onTap;
  TweetCell({required this.tweet, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    return ListTile(
      leading: Avatar(
        authBloc: _authBloc,
        size: 40.0,
      ),
      title: Text(tweet.content),
      subtitle: Text(tweet.time.toIso8601String()),
      onTap: this.onTap,
    );
  }
}
