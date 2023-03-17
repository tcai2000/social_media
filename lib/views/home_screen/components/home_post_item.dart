import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:social_media/constants/index.dart';
import 'package:social_media/global_components/index.dart';

class HomePostItem extends StatefulWidget {
  const HomePostItem({
    super.key,
    required this.imageList,
  });

  final List<String> imageList;

  @override
  State<HomePostItem> createState() => _HomePostItemState();
}

class _HomePostItemState extends State<HomePostItem> {
  int _currentIndexImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            children: [
              UserAvatarDefault(
                size: 32.h,
              ),
              SizedBox(width: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "joshua_l",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Tokyo, Japan",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              const Spacer(),
              SvgPicture.asset(AppIcons.moreIcon)
            ],
          ),
        ),
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 375.h,
                viewportFraction: 1,
                initialPage: _currentIndexImage,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  _currentIndexImage = index;
                  if (mounted) setState(() {});
                },
              ),
              items: widget.imageList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return CachedNetworkImage(
                      imageUrl: i,
                      fit: BoxFit.cover,
                    );
                  },
                );
              }).toList(),
            ),
            Positioned(
              right: 14.h,
              top: 14.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF121212).withOpacity(.7),
                  borderRadius: BorderRadius.circular(13.r),
                ),
                child: Text(
                  "${_currentIndexImage + 1}/${widget.imageList.length}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
          child: Stack(
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        print("OK");
                      },
                      child: SvgPicture.asset(AppIcons.heartOffIcon)),
                  SizedBox(width: 16.w),
                  SvgPicture.asset(AppIcons.commentIcon),
                  SizedBox(width: 16.w),
                  SvgPicture.asset(AppIcons.shareIcon),
                  const Spacer(),
                  SvgPicture.asset(AppIcons.bookMarkIcon),
                ],
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...widget.imageList.map((e) {
                      int index = widget.imageList.indexOf(e);
                      return Container(
                        height: 6.h,
                        width: 6.h,
                        margin: EdgeInsets.symmetric(horizontal: 2.h),
                        decoration: BoxDecoration(
                          color: index == _currentIndexImage
                              ? const Color(0xFF3897F0)
                              : const Color(0xFFD8D8D8),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "2 likes",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ReadMoreText(
                "The game in Japan was amazing and I want to share some photos",
                trimLines: 1,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Show more',
                trimExpandedText: ' Show less',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
