import 'package:flutter/material.dart';
import 'package:ncs/constants/Appstyle.dart';

class PhoneOffers extends StatelessWidget {
  const PhoneOffers({
    super.key,
    required this.imageUrl,
    required this.companyName,
    required this.color,
    required this.offer,
  });
  final String imageUrl;
  final String companyName;
  final Color color;
  final double offer;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppStyle.textColor, width: 1.5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // <-- Important!
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container
          Container(
            width: 200,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Text content with padding
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ).copyWith(color: color),
                ),
                const SizedBox(height: 5),
                Text(
                  '500 Pt -> ${offer.toString()} DZD',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
