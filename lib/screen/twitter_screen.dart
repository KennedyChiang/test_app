import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';
import 'package:test_app/bloc/tweet/tweet_bloc.dart';
import 'package:test_app/screen/add_tweet_screen.dart';
import 'package:test_app/screen/edit_tweet_screen.dart';
import 'package:test_app/view/avatar.dart';
import 'package:test_app/view/tweet_cell.dart';

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
        if (tweetState is TweetInitial ||
            tweetState is CreateTweetSuccessState ||
            tweetState is UpdateTweetSuccessState ||
            tweetState is DeleteTweetSuccessState) {
          _tweetBloc.add(ReadTweetEvent());
          return Center(child: CircularProgressIndicator(strokeWidth: 1.0));
        }
        final displayTweets = _tweetBloc.displayTweets;
        return ListView.builder(
          itemCount: displayTweets.length,
          itemBuilder: (listContext, index) {
            return Dismissible(
              key: ValueKey(index),
              direction: DismissDirection.endToStart,
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 36.0,
                  ),
                ),
              ),
              child: TweetCell(
                tweet: displayTweets[index],
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (sheetContext) {
                      return CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.of(sheetContext).pop();
                              showCupertinoModalPopup(
                                context: context,
                                semanticsDismissible: true,
                                useRootNavigator: false,
                                builder: (modalContext) => BlocProvider.value(
                                  value: _authBloc,
                                  child: BlocProvider.value(
                                    value: _tweetBloc,
                                    child: EditTweetScreen(
                                      tweet: displayTweets[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text('Edit'),
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () => Navigator.of(sheetContext).pop(),
                          child: Text('cancel'),
                        ),
                      );
                    },
                  );
                },
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  _tweetBloc.add(
                    DeleteTweetEvent(
                      refKey: displayTweets[index]
                          .time
                          .microsecondsSinceEpoch
                          .toString(),
                    ),
                  );
                }
              },
            );
          },
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
