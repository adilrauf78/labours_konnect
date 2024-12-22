import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labours_konnect/constants/colors.dart';


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
        fontSize: fontSize?? 20..sp,
        fontWeight: fontWeight?? FontWeight.w700,
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
        color: color?? AppColor.k0xFF818080,
        fontSize: fontSize?? 14..sp,
        fontWeight: fontWeight?? FontWeight.w400,
      ),
    );
  }
}

class Text12 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const Text12({super.key,
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
        overflow: TextOverflow.ellipsis,
        color: color?? AppColor.black.withOpacity(.5),
        fontSize: fontSize?? 12..sp,
        fontWeight: fontWeight?? FontWeight.w500,
      ),
    );
  }
}

class Text15 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const Text15({super.key,
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
        color: color?? AppColor.black.withOpacity(.5),
        fontSize: fontSize?? 15..sp,
        fontWeight: fontWeight?? FontWeight.w500,
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