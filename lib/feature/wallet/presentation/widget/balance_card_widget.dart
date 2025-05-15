import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';

class BalanceCardWidget extends StatelessWidget {
  final String amount;
  const BalanceCardWidget({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 225.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage('assets/images/card.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'رصيدك الحالي',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Lemonada',
                fontWeight: FontWeight.w600,
              ),
            ),
            20.height,
            Text(
              '$amount جنية',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontFamily: 'Lemonada',
                fontWeight: FontWeight.bold,
              ),
            ),
            50.height,
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'FOODIA',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'Lemonada',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
