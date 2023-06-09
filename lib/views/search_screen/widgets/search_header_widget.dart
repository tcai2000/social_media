import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media/constants/enum.dart';
import 'package:social_media/constants/icons.dart';
import 'package:social_media/providers/providers.dart';

class SearchHeaderWidget extends StatelessWidget {
  const SearchHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.all(14.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF767680).withOpacity(0.17),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.searchOffIcon,
            height: 18.h,
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: TextField(
              controller: searchController,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                hintText: 'Search',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                searchProvider.handleSearchUser(context,
                    inputSearch: value.trim());
              },
            ),
          ),
        ],
      ),
    );
  }
}
