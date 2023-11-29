import 'package:bmi_caclulator/di/get_it.dart';
import 'package:bmi_caclulator/features/bmi_count/presentation/cubit/emi_count_cubit.dart';
import 'package:bmi_caclulator/features/bmi_count/presentation/view/emi_calculator/emi_calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

abstract class EmiCalculatorWidget extends State<EmiCalculatorScreen> {
  late EmiCountCubit emiCountCubit;
  @override
  void initState() {
    emiCountCubit = getItInstance<EmiCountCubit>();
    super.initState();
  }

  @override
  void dispose() {
    emiCountCubit.close();
    super.dispose();
  }

  Widget loanAmoutWidget({required EmiCountLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan Amount',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
          ),
        ),
        commonTextfile(
          perffixIconWidget: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 4.w),
            child: Text(
              "₹",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
          formKey: emiCountCubit.amountKey,
          onChange: (value) {
            emiCountCubit.amountKey.currentState!.validate();
          },
          controller: emiCountCubit.homeLoanController,
          hinttext: "5000000",
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter Amount";
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        Text(
          'Loan Tenure',
          style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w400),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: commonTextfile(
                formKey: emiCountCubit.loanTenureKey,
                maxLength: 3,
                onChange: (value) {
                  // if (emiCountCubit.loanTenureController.text.isNotEmpty) {
                  //   final enteredValue = double.parse(value);
                  //   if (state.checkMonthYear) {
                  //     if (enteredValue < 0 || enteredValue > 40) {}
                  //   } else {
                  //     if (enteredValue < 0 || enteredValue > 480) {}
                  //   }
                  // }

                  emiCountCubit.loanTenureKey.currentState!.validate();
                },
                controller: emiCountCubit.loanTenureController,
                hinttext: "10",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Loan Tenure";
                  } else if (emiCountCubit.loanTenureController.text.isNotEmpty) {
                    final enteredValue = double.parse(value);
                    if (state.checkMonthYear) {
                      if (enteredValue < 0 || enteredValue > 40) {
                        return "Year: Max 40 ";
                      }
                    } else {
                      if (enteredValue < 0 || enteredValue > 480) {
                        return "Month: Max 480";
                      }
                    }
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              height: 50.h,
              width: 110.w,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: commonLoanTenureOptions(
                      boxDecoration: BoxDecoration(
                        color: state.checkMonthYear == true ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      state: state,
                      text: 'Yr',
                      onTap: () {
                        if (state.checkMonthYear == false) {
                          emiCountCubit.yearAndMonthSelect(
                            checkTextFieldValue: false,
                            state: state,
                            value: emiCountCubit.loanTenureController.text,
                            check: true,
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: commonLoanTenureOptions(
                        state: state,
                        text: 'Mo',
                        boxDecoration: BoxDecoration(
                          color: state.checkMonthYear == false ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        onTap: () {
                          if (state.checkMonthYear == true) {
                            emiCountCubit.yearAndMonthSelect(
                              checkTextFieldValue: false,
                              state: state,
                              value: emiCountCubit.loanTenureController.text,
                              check: false,
                            );
                          }
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          'Interreast Rate',
          style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w400),
        ),
        commonTextfile(
          formKey: emiCountCubit.intereastKey,
          onChange: (value) {
            emiCountCubit.intereastKey.currentState!.validate();
          },
          controller: emiCountCubit.interestRateController,
          hinttext: "9.5",
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter Intereast Rate";
            }
            return null;
          },
          suffixIconWidget: commonContainer(
            width: 50.w,
            height: 50.h,
            horizontalPadding: 0.w,
            radius: 10.r,
            borderColor: Colors.grey.withOpacity(0.2),
            withOpacity: 0.2,
            text: Text(
              "%",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.5),
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            commonButton(
              bgColor: Colors.grey.withOpacity(0.2),
              onPressed: () {
                emiCountCubit.homeLoanController.clear();
                emiCountCubit.interestRateController.clear();
                emiCountCubit.loanTenureController.clear();
                emiCountCubit.isShowResult(isShowData: false);
              },
              text: "Reset",
              textColors: Colors.grey.withOpacity(0.8),
            ),
            commonButton(
              bgColor: const Color(0XFF084277),
              onPressed: () {
                if (emiCountCubit.amountKey.currentState!.validate() &&
                    emiCountCubit.loanTenureKey.currentState!.validate() &&
                    emiCountCubit.intereastKey.currentState!.validate()) {
                  emiCountCubit.updateEmi(
                    principal: int.parse(emiCountCubit.homeLoanController.text),
                    interestRate: double.parse(emiCountCubit.interestRateController.text),
                    tenure: double.parse(emiCountCubit.loanTenureController.text),
                  );
                  FocusManager.instance.primaryFocus?.unfocus();
                  emiCountCubit.isShowResult(isShowData: true);
                }
              },
              text: "Calculate",
              textColors: Colors.white,
            ),
          ],
        ),
        SizedBox(
          height: 90.h,
        ),
        state.isShowData ? calculateResultContainer(state: state) : const SizedBox.shrink(),
      ],
    );
  }

  /// CommonLoanTenureOpptions
  Widget commonLoanTenureOptions({
    required EmiCountLoadedState state,
    required String text,
    required VoidCallback onTap,
    Decoration? boxDecoration,
  }) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(2.r),
        decoration: boxDecoration,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  /// CommonTextFile
  Widget commonTextfile({
    required TextEditingController controller,
    required String hinttext,
    Widget? suffixIconWidget,
    Widget? perffixIconWidget,
    required Key formKey,
    int? maxLength,
    required String? Function(String?)? validator,
    required void Function(String)? onChange,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.w),
      child: Form(
        key: formKey,
        child: TextFormField(
          validator: validator,
          maxLength: maxLength,
          onChanged: onChange,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp),
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              counterText: "",
              prefixIcon: perffixIconWidget,
              suffixIcon: suffixIconWidget,
              prefixIconConstraints: BoxConstraints(
                minWidth: 10.w,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Color(0XFF084277)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey.shade500),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Color(0XFF084277)),
              ),
              hintText: hinttext,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 18.sp)),
        ),
      ),
    );
  }

  /// CalculateResultContainer
  Widget calculateResultContainer({required EmiCountLoadedState state}) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
            height: 225.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.black.withOpacity(0.4)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      principleAmountChart(text: "Principle Amount", color: const Color(0xffDCE8F3)),
                      SizedBox(width: 15.w),
                      principleAmountChart(text: "Interest Amount", color: const Color(0XFF084277)),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  totalInterestWidget(
                      amounText: double.parse(emiCountCubit.homeLoanController.text).formatCurrency(),
                      text: "Principle Amount",
                      color: const Color(0xffDCE8F3)),
                  Divider(height: 15.h),
                  totalInterestWidget(
                      amounText: state.totalInterest.formatCurrency(),
                      text: "Total Interest",
                      color: const Color(0xffDCE8F3)),
                  Divider(height: 15.h),
                  totalInterestWidget(
                      amounText: state.totalPayment.formatCurrency(),
                      text: "Total Payment",
                      color: const Color(0XFF084277)),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            )),
        Positioned(
          top: -65.h,
          bottom: 160.h,
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your EMI is ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  state.emi.formatCurrency(),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22.sp),
                ),
                Text(
                  'per month',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          top: -233.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 168.h),
            child: CircularProgressIndicator(
              value: !state.emi.isNaN ? state.pieInterest / 100 : 1.0,
              strokeCap: StrokeCap.round,
              strokeWidth: 18.0.w,
              backgroundColor: const Color(0xffDCE8F3),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0XFF084277)),
            ),
          ),
        ),
      ],
    );
  }

  Widget principleAmountChart({required Color color, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 5.h,
          width: 15.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: color),
        ),
        SizedBox(width: 3.w),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  ///Total InterescommonRow
  Widget totalInterestWidget({
    required String text,
    required Color color,
    required amounText,
  }) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Text(
          amounText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }

  ///CommonContainer
  Widget commonContainer({
    double? height,
    double? width,
    double? radius,
    double? leftRadius,
    Color? borderColor,
    required double horizontalPadding,
    required double withOpacity,
    required Widget text,
  }) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(radius ?? 0),
          left: Radius.circular(leftRadius ?? 0),
        ),
        color: Colors.grey.withOpacity(withOpacity),
        border: Border.all(color: borderColor ?? Colors.black.withOpacity(0.32)),
      ),
      child: text,
    );
  }

  ///CommonButto
  Widget commonButton({
    required void Function()? onPressed,
    required Color textColors,
    required Color bgColor,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.all(5.0.r),
      child: MaterialButton(
        onPressed: onPressed,
        textColor: textColors,
        elevation: 0,
        color: bgColor,
        highlightElevation: 0,
        height: 48.h,
        minWidth: 155.w,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

extension CurrencyFormatter on num {
  String formatCurrency() {
    final formatCurrency = NumberFormat.currency(symbol: '₹', locale: 'en_IN', decimalDigits: 0);
    return formatCurrency.format(this);
  }
}
