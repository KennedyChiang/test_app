import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';
import 'package:test_app/bloc/tweet/tweet_bloc.dart';
import 'package:test_app/view/avatar.dart';
import 'package:test_app/view/navigation_bar_item.dart';

class EditTweetScreen extends StatefulWidget {
  final Tweet tweet;
  EditTweetScreen({required this.tweet});
  @override
  State<StatefulWidget> createState() => _EditTweetScreenState();
}

class _EditTweetScreenState extends State<EditTweetScreen> {
  final _inputController = TextEditingController();
  final _inputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (_inputFocusNode.canRequestFocus) {
      _inputFocusNode.requestFocus();
    }
    _inputController.text = widget.tweet.content;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TweetBloc, TweetState>(
      listener: (_, tweetState) {
        if (tweetState is UpdateTweetSuccessState) {
          Navigator.of(context).pop();
        }
        if (tweetState is TweetActionFailState) {
          showCupertinoDialog(
            context: context,
            builder: (dialogContext) => CupertinoAlertDialog(
              title: Text('Error'),
              content: Text(tweetState.error.toString()),
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            ),
          );
        }
      },
      child: GestureDetector(
        child: Scaffold(
          appBar: _appBar,
          body: SafeArea(
            child: _body,
          ),
        ),
        onTap: () => _inputFocusNode.unfocus(),
      ),
    );
  }

  /// getter
  ///

  AppBar get _appBar => AppBar(
        elevation: 0.0,
        title: Text('Edit Tweet'),
        leading: NavigationBarItem(
          title: 'Cancel',
          onPressed: () => Navigator.of(context).pop(),
        ),
        leadingWidth: navigationBarItemWithConstraints.maxWidth,
        actions: [
          NavigationBarItem(
            title: 'Tweet',
            onPressed: _inputController.text.isEmpty ||
                    _inputController.text == widget.tweet.content
                ? null
                : () {
                    _tweetBloc.add(
                      UpdateTweetEvent(
                        refKey: widget.tweet.refKey,
                        content: _inputController.text,
                      ),
                    );
                  },
          ),
        ],
      );

  Widget get _body {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _avatar,
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: _inputController,
              focusNode: _inputFocusNode,
              maxLines: 50,
              maxLength: 280,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.black54,
                ),
                hintText: "What's happening?",
              ),
              onSubmitted: (text) {
                _inputController.text += '\n';
              },
              onChanged: (_) => setState(() {}),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _avatar => Avatar(authBloc: _authBloc, size: 40);

  AuthBloc get _authBloc => BlocProvider.of<AuthBloc>(context);

  TweetBloc get _tweetBloc => BlocProvider.of<TweetBloc>(context);
}
