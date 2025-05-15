import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';

class TransactionItemWidget extends StatelessWidget {
  final String date;
  final String transactionType;
  final String amount;
  const TransactionItemWidget({
    super.key,
    required this.date,
    required this.transactionType,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110.h,
      margin: REdgeInsets.symmetric(vertical: 8),
      padding: REdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'نوع المعاملة: ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                transactionType,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              // Container يحتوي على الأيقونة والتاريخ
              Container(
                padding: REdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                      size: 16.sp,
                    ),
                    8.width,
                    Text(
                      date,
                      style: TextStyle(color: Colors.black, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('المبلغ:', style: TextStyle(fontSize: 14.sp)),
              12.width,
              Text(
                '$amount جنية',
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
