import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_config/app_colors.dart';


class CustomButtonDesign extends StatefulWidget {
  const CustomButtonDesign({super.key});

  @override
  State<CustomButtonDesign> createState() => _CustomButtonDesignState();
}

class _CustomButtonDesignState extends State<CustomButtonDesign> {
  int selectedIndex = 0;

  final List<Widget> allCategory = [
    SizedBox(),
SizedBox(),
    SizedBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container for buttons (Tabs)
        Container(
          height: 60.h,
          width: MediaQuery.of(context).size.width * 0.93,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(12.0.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width * 0.25,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? AppColors.pajeText
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0.r),
                    border: Border.all(
                      color: selectedIndex == index
                          ? AppColors.pajeText
                          : AppColors.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      ["الطلبات الملغاة","الطلبات المكتملة", "طلبات قيد التحضير", "طلبات قيد الانتظار"][index],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        // Add a SingleChildScrollView only for the selected category content
        Expanded(
          child: SingleChildScrollView(
            child: allCategory[selectedIndex], // Display selected category content
          ),
        ),
      ],
    );
  }
}
