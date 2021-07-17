import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';

const String _defaultAvatarPath = 'assets/images/icon-ninja-13.jpg';
const navigationBarItemWithConstraints = BoxConstraints.expand(width: 60.0);

class AddTweetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTweetScreenState();
}

class _AddTweetScreenState extends State<AddTweetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  /// getter
  ///

  AppBar get _appBar => AppBar(
        elevation: 0.0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Text('Cancel'),
          constraints: navigationBarItemWithConstraints,
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: Text('Tweet'),
            constraints: navigationBarItemWithConstraints,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              print('did pressed Tweet');
            },
          ),
        ],
      );

  Widget get _body {
    return Center(
      child: Text('Add Tweet Screen'),
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
                children: [
                  SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: null == BlocProvider.of<AuthBloc>(context).photoUrl
                        ? Image.asset(
                            _defaultAvatarPath,
                            fit: BoxFit.cover,
                          )
                        : FadeInImage(
                            image: NetworkImage(
                              BlocProvider.of<AuthBloc>(context).photoUrl!,
                            ),
                            placeholder: const AssetImage(_defaultAvatarPath),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Text(BlocProvider.of<AuthBloc>(context).googleId ?? '-'),
                  Text(BlocProvider.of<AuthBloc>(context).email ?? '-'),
                ],
              ),
            ),
            ListTile(
              title: Text('SignOut'),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(GoogleSignOutEvent());
              },
            ),
          ],
        ),
      );
}
