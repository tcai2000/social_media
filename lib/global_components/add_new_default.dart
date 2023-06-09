import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/constants/colors.dart';

class AddNewDefault extends StatelessWidget {
  const AddNewDefault({
    super.key,
    this.isAdd = false,
    this.text,
    this.size = 62,
  });
  final bool? isAdd;
  final String? text;
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.h,
            width: size.h,
            padding: EdgeInsets.all(2.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(width: 2, color: AppColors.sliverColor),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Icon(
                  Icons.add,
                  size: 23.w,
                )),
          ),
          if (text != null)
            Text(
              text!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            )
        ],
      ),
    );
  }
}
