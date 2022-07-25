import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceTextField extends StatelessWidget {
  final double? horizontalMargin;
  final double? verticalMargin;
  final String? hintText;
  final Color? filledColor;
  final double? borderRadius;
  final bool? showBorder;
  final TextEditingController? controller;

  const InvoiceTextField(
      {Key? key,
      this.horizontalMargin,
      this.controller,
      this.verticalMargin,
      this.hintText,
      this.filledColor,
      this.showBorder,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 44.sp,
      // width: 341.0.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 6.0.r),
        color: Colors.transparent,
        border: Border.all(
          width: 1.sp,
          color: Colors.grey,
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin ?? 16.sp,
      ),

      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
              borderSide: BorderSide(color: Colors.white, width: 1.sp),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
              borderSide: BorderSide(color: Colors.white, width: 1.sp),
            ),
            contentPadding: EdgeInsets.only(right: 8.sp, left: 8.sp),
            fillColor: filledColor ?? Colors.white,
            filled: false,
            hintStyle: GoogleFonts.nunito(
                fontSize: 12.sp,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
            hintText: hintText ?? 'Search Customers'),
      ),
    );
  }
}

class InvoiceTextFieldNoBorder extends StatelessWidget {
  final double? horizontalMargin;
  final double? verticalMargin;
  final String? hintText;
  final Color? filledColor;
  final double? borderRadius;
  final bool? showBorder;
  final TextEditingController? controller;

  const InvoiceTextFieldNoBorder(
      {Key? key,
      this.horizontalMargin,
      this.controller,
      this.verticalMargin,
      this.hintText,
      this.filledColor,
      this.showBorder,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 44.sp,
      // width: 341.0.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 6.0.r),
        color: Colors.white10,
      ),
      margin: EdgeInsets.only(left: 80.sp, bottom: 5.sp),

      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding:
                EdgeInsets.only(right: 8.sp, left: 8.sp, bottom: 8.sp),
            fillColor: filledColor ?? Colors.white,
            filled: false,
            hintStyle: GoogleFonts.nunito(
                fontSize: 12.sp,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
            hintText: hintText ?? 'Search Customers'),
      ),
    );
  }
}
