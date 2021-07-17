import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';

const double defaultAvatarSize = 60.0;
const String _defaultAvatarPath = 'assets/images/icon-ninja-13.jpg';

class Avatar extends StatelessWidget {
  final AuthBloc authBloc;
  final double size;
  Avatar({required this.authBloc, this.size = defaultAvatarSize});

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: this.size / 2,
        child: ClipOval(
          child: SizedBox(
            width: this.size,
            height: this.size,
            child: null == authBloc.photoUrl
                ? Image.asset(
                    _defaultAvatarPath,
                    fit: BoxFit.cover,
                  )
                : FadeInImage(
                    image: NetworkImage(authBloc.photoUrl!),
                    placeholder: const AssetImage(_defaultAvatarPath),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      );
}
