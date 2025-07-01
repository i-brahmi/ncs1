import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ncs/constants/Appstyle.dart';

class OfferCard extends StatefulWidget {
  const OfferCard({super.key});

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  bool showDescription = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppStyle.textColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with image and details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: AppStyle.maincolor, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    'lib/assets/images/defaultcar.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              // Info + toggle button
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lm Chakhchakh',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Image.asset(
                            'lib/assets/images/locationpin.png',
                            height: 16,
                            width: 16,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            '9odam 9osa t3 BAB lghrbi',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Toggle button
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showDescription = !showDescription;
                          });
                        },
                        child: Transform.rotate(
                          angle: showDescription ? math.pi : 0,
                          child: Icon(
                            Icons.arrow_circle_down_outlined,
                            color: AppStyle.maincolor,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Description section
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    '500 Pt -> 2000 DZD',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Colors.grey,
                    ),
                  ),
                  Divider(),
                  Text(
                    '300 Pt -> 1000 DZD',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Colors.grey,
                    ),
                  ),
                  Divider(),
                  Text(
                    '200 Pt -> 500 DZD',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Colors.grey,
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
            crossFadeState: showDescription
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
