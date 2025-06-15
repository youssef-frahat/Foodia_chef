import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';
import 'package:foodia_chef/core/widgets/text_form_field/my_text_form_faield.dart';

import '../logic/cubit/Withdraw_Cubit.dart';
import '../logic/cubit/withdraw_state.dart';


class ButtonAddBalance extends StatelessWidget {
  const ButtonAddBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WithdrawCubit, WithdrawState>(
      listener: (context, state) {
        if (state is SubmitWithdrawSuccess) {
          Fluttertoast.showToast(
            msg: "تم إرسال طلب السحب بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.sp,
          );
        } else if (state is SubmitWithdrawFailure) {
          Fluttertoast.showToast(
            msg: "فشل في السحب: ${state.failure.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.sp,
          );
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.watch<WithdrawCubit>().state is SubmittingWithdrawLoading;

          return Center(
            child: ElevatedButton(
              onPressed: isLoading ? null : () => _showDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'سحب رصيد من محفظتك',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontFamily: 'Changa',
                          ),
                        ),
                        10.width,
                        SvgPicture.asset('assets/icons/add_wallet.svg'),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            'سحب مبلغًا جديدًا',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          content: Padding(
            padding: REdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextFormField(
                  controller: amountController,
                  hintText: 'ادخل المبلغ',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'يرجى إدخال المبلغ';
                    }
                    return null;
                  },
                ),
                20.height,
                CustomButton(
                  textColor: Colors.white,
                  text: 'أضف',
                  backgroundColor: Colors.orange,
                  onTap: () {
                    final amount = int.tryParse(amountController.text);
                    if (amount != null && amount > 0) {
                      Navigator.pop(dialogContext);
                      context.read<WithdrawCubit>().submitWithdraw(
                        amount: amount,
                      );
                    } else {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(content: Text('يرجى إدخال مبلغ صحيح')),
                      );
                    }
                  },
                  width: 100.w,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
