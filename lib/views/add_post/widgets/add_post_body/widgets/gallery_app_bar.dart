import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/config/routes.dart';
import 'package:social_media/constants/colors.dart';
import 'package:social_media/constants/index.dart';

class GalleryAppBar extends StatelessWidget {
  const GalleryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.h),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              AppIcons.closeIcon,
              height: 18.h,
            ),
          ),
          SizedBox(width: 20.w),
          Text(
            AppStrings.newPost,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.addPostFormRoute);
            },
            child: Text(
              AppStrings.next,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.pictonBlueColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
