import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/dependency_injection.dart';
import '../logic/cubit/Withdraw_Cubit.dart';
import '../logic/cubit/withdraw_state.dart';
import '../widget/balance_card_widget.dart';
import '../widget/button_add_balance.dart';
import '../widget/transaction_item_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with WidgetsBindingObserver {
  late WithdrawCubit _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubit = getIt<WithdrawCubit>()..getWithdraws();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _cubit.getWithdraws();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'المحفظة',
          style: TextStyle(fontFamily: 'Changa', fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: _cubit,
        child: BlocBuilder<WithdrawCubit, WithdrawState>(
          builder: (context, state) {
            if (state is WithdrawsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is WithdrawsFailure) {
              return Center(child: Text(state.failure.message));
            }

            if (state is WithdrawsSuccess) {
              final withdrawModel = state.model;

              return Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  40.height,
                    BalanceCardWidget(
                      amount: withdrawModel.data?.wallet ?? "0.0",
                    ),
                    30.height,
                    const ButtonAddBalance(),
                  25.height,
                    Text(
                      'اخر معاملاتي النقدية',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Changa',
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    15.height,
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: withdrawModel.data?.withdraws?.length ?? 0,
                        itemBuilder: (context, index) {
                          final withdraw =
                              withdrawModel.data!.withdraws![index];
                          return WithdrawTransactionItemWidget(
                            amount: withdraw.amount ?? '',
                            date: _formatDate(withdraw.createdAt),
                            status: withdraw.status ?? '',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox(); // fallback
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime? rawDate) {
  try {
    if (rawDate == null) return 'غير محدد';
    return DateFormat('d/MM/yyyy').format(rawDate);
  } catch (e) {
    return 'غير محدد';
  }
}
  
}
