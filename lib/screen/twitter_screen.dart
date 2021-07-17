import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';
import 'package:test_app/bloc/tweet/tweet_bloc.dart';
import 'package:test_app/screen/add_tweet_screen.dart';
import 'package:test_app/view/avatar.dart';

class TwitterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TwitterScreenState();
}

class _TwitterScreenState extends State<TwitterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      drawer: drawer,
      body: _body,
      floatingActionButton: _floatingActionButton,
    );
  }

  /// getter
  ///

  AppBar get _appBar => AppBar(title: Text('1-Person Twitter'));

  Widget get _body {
    return BlocBuilder<TweetBloc, TweetState>(
      builder: (tweetContext, tweetState) {
        if (tweetState is TweetInitial) {
          BlocProvider.of<TweetBloc>(context).add(ReadTweetEvent());
        }
        return Center(
          child: Text('Twitter Screen'),
        );
      },
    );
  }

  Widget get drawer => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _avatar,
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    BlocProvider.of<AuthBloc>(context).displayName ?? '-',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    BlocProvider.of<AuthBloc>(context).email ?? '-',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'SignOut',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(GoogleSignOutEvent());
              },
            ),
          ],
        ),
      );

  Widget get _floatingActionButton => FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.commentMedical),
        onPressed: () {
          showCupertinoModalPopup(
            context: context,
            semanticsDismissible: true,
            useRootNavigator: false,
            builder: (modalContext) => BlocProvider.value(
              value: _authBloc,
              child: BlocProvider.value(
                value: _tweetBloc,
                child: AddTweetScreen(),
              ),
            ),
          );
        },
      );

  Widget get _avatar => Avatar(authBloc: _authBloc);

  AuthBloc get _authBloc => BlocProvider.of<AuthBloc>(context);
  TweetBloc get _tweetBloc => BlocProvider.of<TweetBloc>(context);
}
