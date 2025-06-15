import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodia_chef/core/app_config/app_icons.dart';
import 'package:foodia_chef/feature/home/presentation/all_order/presentation/screen/all_orders_screen.dart';
import 'package:foodia_chef/feature/home/presentation/canceled_requests/presentation/screen/canceled_requests_screen.dart';
import 'package:foodia_chef/feature/home/presentation/chef_info/chef_info.dart';
import 'package:foodia_chef/feature/home/presentation/chef_info/chef_screen.dart';
import 'package:foodia_chef/feature/home/presentation/completed_requests/presentation/screen/completed_requests_screen.dart';
import 'package:foodia_chef/feature/home/presentation/requests_in_preparation/presentation/screen/request_in_preparation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> categoryNames = [
      "طلبات قيد الانتظار",
      "طلبات قيد التحضير",
      "الطلبات المكتملة",
      "الطلبات الملغاة",
    ];

    List<Widget> allCategory = [
      AllOrdersScreen(),
      RequestsInPreparationScreen(),
      CompletedRequestsScreen(),
      CanceledRequestsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            AppIcons.notifications,
            width: 24,
            height: 24,
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              thickness: 3.h,
              color: Colors.grey[300],
            ),
            ChefScreen(),
            Divider(
              thickness: 3.h,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.sizeOf(context).width * 0.93,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            categoryNames[index],
                            style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if (selectIndex == index)
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            height: 2.h,
                            width: 110.w,
                            color: Colors.orange,
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.48,
              width: MediaQuery.sizeOf(context).width * 0.93,
              child: allCategory[selectIndex],
            ),
          ],
        ),
      ),
    );
  }
}
