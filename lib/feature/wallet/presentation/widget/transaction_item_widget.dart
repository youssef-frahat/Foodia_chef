import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';

class WithdrawTransactionItemWidget extends StatelessWidget {
  final String date;
  final String status;
  final String amount;

  const WithdrawTransactionItemWidget({
    super.key,
    required this.date,
    required this.status,
    required this.amount,
  });

  String _mapStatus(String status) {
    final normalized = status.trim().toLowerCase();
    switch (normalized) {
      case 'pending':
        return 'قيد الانتظار';
      case 'accepted':
        return 'تمت الموافقة';
      case 'rejected':
        return 'مرفوضة';
      default:
        return 'غير معروف';
    }
  }

  Color _getStatusColor(String status) {
    final normalized = status.trim().toLowerCase();
    switch (normalized) {
      case 'pending':
        return Colors.amber;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String translatedStatus = _mapStatus(status);
    final Color statusColor = _getStatusColor(status);

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
                'حالة السحب: ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                translatedStatus,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'المبلغ:',
                style: TextStyle(fontSize: 14.sp),
              ),
              12.width,
              Text(
                '$amount جنيه',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
