import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';

import '../../../../core/app_config/url_luncer.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/messages.dart';
import '../logic/cubit/get_balance_cubit.dart';
import '../widget/balance_card_widget.dart';
import '../widget/button_add_balance.dart';
import '../widget/payment_web_view.dart';
import '../widget/transaction_item_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with WidgetsBindingObserver {
  late GetBalanceCubit _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubit = getIt<GetBalanceCubit>()..getBalance();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _cubit.getBalance();
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
        child: BlocListener<GetBalanceCubit, GetBalanceState>(
          listener: (context, state) async {
            if (state is AddBalanceSuccess) {
              final rawUrl = state.addToBalanceModel.data?.paymentUrl ?? '';
              final sanitizedUrl = sanitizeUrl(rawUrl);

              await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => WebViewPaymentPage(url: sanitizedUrl),
                ),
              ).then((result) {
                _cubit.getBalance(); // ✅ يحدث البيانات دائمًا بعد العودة
                if (result == true) {
                  AppMessages.showSuccess(context, "تمت عملية الدفع بنجاح");
                } else if (result == false) {
                  AppMessages.showError(context, "تم إلغاء عملية الدفع");
                }
              });
            } else if (state is AddBalanceFailure) {
              AppMessages.showError(context, state.failure.message);
            }
          },
          child: BlocBuilder<GetBalanceCubit, GetBalanceState>(
            builder: (context, state) {
              if (state is GetBalanceLoading || state is AddingBalanceLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetBalanceFailure) {
                return Center(child: Text(state.failure.message));
              }

              if (state is GetBalanceSuccess || state is AddBalanceSuccess) {
                final balance =
                    (context.read<GetBalanceCubit>().state is GetBalanceSuccess)
                        ? (context.read<GetBalanceCubit>().state
                                as GetBalanceSuccess)
                            .getWalletModel
                        : null;

                if (balance == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.height,
                      BalanceCardWidget(
                        amount: balance.data?.balance?.amount ?? '',
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
                          itemCount: balance.data?.wallets?.length ?? 0,
                          itemBuilder: (context, index) {
                            String formattedDate = _formatDate(
                              balance.data?.wallets?[index].createdAt,
                            );
                            return TransactionItemWidget(
                              amount:
                                  balance.data?.wallets?[index].amount ?? '',
                              date: formattedDate,
                              transactionType:
                                  balance.data?.wallets?[index].type ?? '',
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
      ),
    );
  }

  String _formatDate(Object? rawDate) {
    try {
      if (rawDate is String) {
        return rawDate;
      } else if (rawDate is DateTime) {
        return DateFormat('d/MM/yyyy').format(rawDate);
      } else {
        return 'غير محدد';
      }
    } catch (e) {
      return 'غير محدد';
    }
  }
}
