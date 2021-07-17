import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';

const String _defaultAvatarPath = 'assets/images/icon-ninja-13.jpg';

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
    );
  }

  /// getter
  ///

  AppBar get _appBar => AppBar(title: Text('1-Person Twitter'));

  Widget get _body {
    return Center(
      child: Text('Twitter Screen'),
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
