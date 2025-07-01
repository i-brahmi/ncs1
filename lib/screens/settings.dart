import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncs/constants/Appstyle.dart';
import 'package:ncs/cubits/user_cubit.dart';
import 'package:ncs/widgets/safe_network_image.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SafeNetworkImage(
                  imageUrl: BlocProvider.of<UserCubit>(
                    context,
                    listen: false,
                  ).user.profilePictureUrl,
                  radius: 25,
                  fallbackUrl: fullBackURL,
                ),

                const SizedBox(width: 16), // spacing between avatar and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        BlocProvider.of<UserCubit>(
                              context,
                              listen: false,
                            ).user.firstName.isNotEmpty
                            ? BlocProvider.of<UserCubit>(
                                context,
                                listen: false,
                              ).user.firstName
                            : 'Guest User',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        BlocProvider.of<UserCubit>(
                              context,
                              listen: false,
                            ).user.email.isNotEmpty
                            ? BlocProvider.of<UserCubit>(
                                context,
                                listen: false,
                              ).user.email
                            : 'Guest User',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                IconTyping(iconPath: Icons.person, title: 'Account Settings'),
                IconTyping(iconPath: Icons.language, title: 'Language'),
                IconTyping(iconPath: Icons.feed, title: 'Feedback'),
                IconTyping(iconPath: Icons.star, title: 'Rate us'),
                IconTyping(
                  iconPath: Icons.arrow_upward_outlined,
                  title: 'New version',
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              InkWell(
                onTap: () {
                  BlocProvider.of<UserCubit>(context).logout();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFEB4646), // Blue color
                  ),

                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 110),
        ],
      ),
    );
  }
}

class IconTyping extends StatelessWidget {
  const IconTyping({super.key, required this.iconPath, required this.title});
  final IconData iconPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: [
          Icon(iconPath, size: 35),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
        ],
      ),
    );
  }
}
