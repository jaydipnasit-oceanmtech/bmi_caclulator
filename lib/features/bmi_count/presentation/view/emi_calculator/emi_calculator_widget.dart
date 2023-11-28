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
          style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w400),
        ),
        commonTextfile(
          formKey: emiCountCubit.amountKey,
          onChange: (value) {
            emiCountCubit.amountKey.currentState!.validate();
          },
          controller: emiCountCubit.homeLoanController,
          hinttext: "₹ 5000000",
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
                onChange: (value) {
                  emiCountCubit.loanTenureKey.currentState!.validate();
                },
                controller: emiCountCubit.loanTenureController,
                hinttext: "10",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Loan Tenure";
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
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  commonLoanTenureOptions(
                    boxDecoration: BoxDecoration(
                      color: state.checkMonthYear == true ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    state: state,
                    tex: 'Yr',
                    onTap: () {
                      if (state.checkMonthYear == false && emiCountCubit.loanTenureController.text.isNotEmpty) {
                        emiCountCubit.yearAndMonthSelect(
                          checkTextFieldValue: false,
                          state: state,
                          value: emiCountCubit.loanTenureController.text,
                          check: true,
                        );
                      }
                    },
                  ),
                  commonLoanTenureOptions(
                      state: state,
                      tex: 'Mo',
                      boxDecoration: BoxDecoration(
                        color: state.checkMonthYear == false ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      onTap: () {
                        if (state.checkMonthYear == true && emiCountCubit.loanTenureController.text.isNotEmpty) {
                          emiCountCubit.yearAndMonthSelect(
                            checkTextFieldValue: false,
                            state: state,
                            value: emiCountCubit.loanTenureController.text,
                            check: false,
                          );
                        }
                      }),
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.grey),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            commonButton(
              bgColor: Colors.grey.shade300,
              onPressed: () {
                emiCountCubit.homeLoanController.clear();
                emiCountCubit.interestRateController.clear();
                emiCountCubit.loanTenureController.clear();
              },
              text: "Reset",
              textColors: Colors.grey.shade800,
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
                }
              },
              text: "Calculate",
              textColors: const Color(0xffFFFFFF),
            ),
          ],
        ),
        SizedBox(
          height: 90.h,
        ),
        calculateResultContainer(state: state)
      ],
    );
  }

  /// CommonLoanTenureOpptions
  Widget commonLoanTenureOptions({
    required EmiCountLoadedState state,
    required String tex,
    required VoidCallback onTap,
    Decoration? boxDecoration,
  }) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 50.w,
        margin: EdgeInsets.all(2.r),
        decoration: boxDecoration,
        child: Center(
            child: Text(
          tex,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }

  /// CommonTextFile
  Widget commonTextfile(
      {required TextEditingController controller,
      required String hinttext,
      Widget? suffixIconWidget,
      required Key formKey,
      required String? Function(String?)? validator,
      required void Function(String)? onChange}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.w),
      child: Form(
        key: formKey,
        child: TextFormField(
          validator: validator,
          onChanged: onChange,
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              counterText: "",
              suffixIcon: suffixIconWidget,
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
              hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700, fontSize: 18.sp)),
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
            height: 200.h,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Principle Amount",
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "₹ ${emiCountCubit.homeLoanController.text}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
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
          bottom: 130.h,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.h),
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
                        fontWeight: FontWeight.w500, color: const Color.fromARGB(255, 22, 17, 17), fontSize: 14.sp),
                  ),
                  Text(
                    state.emi.formatCurrency(),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.sp),
                  ),
                  Text(
                    'per month',
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey.shade700, fontSize: 14.sp),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          top: -195.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 90.w, vertical: 125.h),
            child: CircularProgressIndicator(
              value: !state.emi.isNaN ? state.pieInterest / 100 : 1.0,
              strokeCap: StrokeCap.round,
              strokeWidth: 18.0.w,
              backgroundColor: const Color(0xffDCE8F3),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0XFF084277)),
            ),
          ),
        ),
        SizedBox(height: 20.h)
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
        Container(
          height: 15.h,
          width: 15.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.r), color: color),
        ),
        SizedBox(width: 5.w),
        Text(
          text,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        Text(amounText, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700, fontSize: 16.sp)),
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
        height: 48.h,
        minWidth: 155.w,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
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
