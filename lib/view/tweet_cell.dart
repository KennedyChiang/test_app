import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';
import 'package:test_app/model/tweet.dart';
import 'package:test_app/view/avatar.dart';

class TweetCell extends StatelessWidget {
  final Tweet tweet;
  final DateTime buildTime;
  final VoidCallback? onTap;
  TweetCell({required this.tweet, required this.buildTime, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    return ListTile(
      leading: Avatar(
        authBloc: _authBloc,
        size: 46.0,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _authBloc.displayName ?? '',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
              Text(
                '．${tweet.intervalTimeWith(flagTime: this.buildTime)}',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Text(
            tweet.content,
            maxLines: 10,
          ),
        ],
      ),
      onTap: this.onTap,
    );
  }
}
