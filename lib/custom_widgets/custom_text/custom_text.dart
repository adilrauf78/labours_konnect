import 'package:flo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MainText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const MainText({super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color?? AppColor.black,
        fontSize: fontSize?? 18..sp,
        fontWeight: fontWeight?? FontWeight.w500,
        overflow: TextOverflow.ellipsis
      ),
    );
  }
}
class SubText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const SubText({super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color?? AppColor.black,
        fontSize: fontSize?? 16..sp,
        fontWeight: fontWeight?? FontWeight.w400,
          overflow: TextOverflow.ellipsis
      ),
    );
  }
}

class Text14 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const Text14({super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      maxLines: 2,
      style: TextStyle(
        color: color?? AppColor.black,
        fontSize: fontSize?? 14..sp,
        fontWeight: fontWeight?? FontWeight.w500,
        overflow: TextOverflow.ellipsis
      ),
    );
  }
}


class Text18 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const Text18({super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color?? AppColor.black,
          fontSize: fontSize?? 18..sp,
          fontWeight: fontWeight?? FontWeight.w500,
      ),
    );
  }
}

class Text24 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const Text24({super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: TextStyle(
          color: color?? AppColor.black,
          fontSize: fontSize?? 24..sp,
          fontWeight: fontWeight?? FontWeight.w700,
      ),
    );
  }
}