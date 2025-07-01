import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncs/constants/Appstyle.dart';
import 'package:ncs/cubits/user_cubit.dart';
import 'package:ncs/widgets/offer_card.dart';
import 'package:ncs/widgets/phone_offers.dart';
import 'package:ncs/widgets/safe_network_image.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 33, 151, 80),
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 22, 173, 83),
                Color.fromARGB(180, 22, 173, 83),
              ],
            ),
            color: const Color.fromARGB(255, 22, 173, 83),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '    EcoDZ',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SafeNetworkImage(
                      imageUrl: BlocProvider.of<UserCubit>(
                        context,
                        listen: false,
                      ).user.profilePictureUrl,
                      radius: 25,
                      fallbackUrl: fullBackURL,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 20,
              ),
              child: Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(50, 183, 104, 0.28),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppStyle.maincolor, width: 2),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Icon(Icons.star, size: 30, color: AppStyle.maincolor),
                        Text(
                          'Total Points: ',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: AppStyle.maincolor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${BlocProvider.of<UserCubit>(context, listen: false).user.points} Pt ',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: AppStyle.maincolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Phone Offers',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Change point with credits',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color.fromRGBO(107, 114, 128, 1),
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 260,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    PhoneOffers(
                      imageUrl: 'lib/assets/images/mobilis.jpg',
                      companyName: 'Mobilis',
                      color: AppStyle.maincolor,
                      offer: 500,
                    ),
                    PhoneOffers(
                      imageUrl: 'lib/assets/images/ooredoo.png',
                      companyName: 'Ooredoo',
                      color: Colors.red,
                      offer: 600,
                    ),
                    PhoneOffers(
                      imageUrl: 'lib/assets/images/djezzy.png',
                      companyName: 'Djezzy',
                      color: Colors.redAccent,
                      offer: 700,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Explore Rest of the offers',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Check the other offers',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color.fromRGBO(107, 114, 128, 1),
                ),
              ),
            ),
            SizedBox(height: 10),
            OfferCard(),
            OfferCard(),
            OfferCard(),
            const SizedBox(height: 20),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
