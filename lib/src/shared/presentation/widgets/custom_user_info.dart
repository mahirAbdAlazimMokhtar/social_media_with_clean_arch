import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';

class CustomUserInformation extends StatelessWidget {
  const CustomUserInformation({
    super.key,
    required this.user,
  });
  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          backgroundImage:
              (user.imagePath == null) ? null : AssetImage(user.imagePath!),
        ),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:75.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildUserInfo(context,'Followers',user.followers.toString()),
              _buildUserInfo(context,'Followings',user.followings.toString()),
            ],
          ),
        )
      ],
    );
  }

  Column _buildUserInfo(BuildContext context, String type, String value) {
    return Column(children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5,),
        Text(
         type,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(letterSpacing: 1.5),
        ),
      ],);
  }
}
