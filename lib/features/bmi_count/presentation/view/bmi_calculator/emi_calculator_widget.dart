import 'package:bmi_caclulator/di/get_it.dart';
import 'package:bmi_caclulator/features/bmi_count/presentation/cubit/emi_count_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bmi_caclulator/features/bmi_count/presentation/view/bmi_calculator/emi_calculator_screen.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

abstract class EmiCalculatorWidget extends State<EmiCalculatorScreen> {
  late EmiCountCubit emiCountCubit;

  @override
  void initState() {
    emiCountCubit = getItInstance<EmiCountCubit>();
    updateSliderValue();
    super.initState();
  }

  @override
  void dispose() {
    emiCountCubit.close();
    super.dispose();
  }

  void updateSliderValue() {
    emiCountCubit.updateEmi(
      principal: int.parse(emiCountCubit.homeLoanController.text),
      interestRate: double.parse(emiCountCubit.interestRateController.text),
      tenure: double.parse(emiCountCubit.loanTenureController.text),
    );
  }

  Widget loanAmoutWidget({required EmiCountLoadedState state}) {
    Map<String, double> dataMap = {
      "Principal Loan Amount": state.piePrincipalLoanAmount,
      "Total Interest": state.pieInterest,
    };
    return commonContainer(
      horizontalPadding: 0,
      withOpacity: 0.3,
      borderColor: Colors.black,
      text: Column(
        children: [
          SizedBox(height: 40.h),
          commonTextfile(
            onSubmitted: (value) {
              emiCountCubit.homeLoanAmountSlider(
                state: state,
                homeLoanSliderValue: double.parse(value),
                isCheck: true,
              );
              updateSliderValue();
            },
            state: state,
            controller: emiCountCubit.homeLoanController,
            hinttext: "Ex 1000",
            text: "Home Loan Amount",
            suffixWidget: commonContainer(
              width: 40.w,
              height: 35.h,
              horizontalPadding: 0.w,
              withOpacity: 0.2,
              borderColor: Colors.black,
              text: Text(
                "₹",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
          ),
          sliderWidget(
            onChanged: (value) {
              emiCountCubit.homeLoanAmountSlider(
                state: state,
                homeLoanSliderValue: value,
                isCheck: false,
              );
            },
            loanValue: (state.homeSliderValue) <= (200.0 * 100000)
                ? ((double.parse(emiCountCubit.homeLoanController.text)) / 100000)
                : 200,
            interval: 25,
            labelFormatterCallback: (value, value1) {
              return '${value.toInt()}L';
            },
            max: 200,
            min: 0,
          ),
          SizedBox(
            height: 10.h,
          ),
          commonTextfile(
            state: state,
            controller: emiCountCubit.interestRateController,
            hinttext: "Ex 2.5",
            text: "Interest Rate",
            onSubmitted: (value) {
              emiCountCubit.interestRateSliderMethod(state: state, interestRateSlider: value);
            },
            suffixWidget: commonContainer(
              width: 40.w,
              borderColor: Colors.black,
              height: 35.h,
              horizontalPadding: 0.w,
              withOpacity: 0.2,
              text: Text(
                "%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
          ),
          sliderWidget(
            onChanged: (value) {
              emiCountCubit.interestRateSliderMethod(state: state, interestRateSlider: "$value");
            },
            loanValue: double.parse(emiCountCubit.interestRateController.text) <= 20
                ? double.parse(emiCountCubit.interestRateController.text)
                : 20,
            interval: 2.5,
            max: 20,
            min: 5,
          ),
          SizedBox(
            height: 10.h,
          ),
          commonTextfile(
            state: state,
            controller: emiCountCubit.loanTenureController,
            hinttext: "Ex 4",
            text: "Loan Tenure",
            onSubmitted: (value) {
              emiCountCubit.loanTenureController = TextEditingController(text: value);
              emiCountCubit.yearAndMonthSelect(
                checkTextFieldValue: true,
                state: state,
                check: state.checkMonthYear,
                value: value,
              );
              updateSliderValue();
            },
            suffixWidget: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
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
                  child: commonContainer(
                    width: 40.w,
                    height: 35.h,
                    borderColor: Colors.black.withOpacity(0.5),
                    horizontalPadding: 0.w,
                    withOpacity: state.checkMonthYear ? 0.75 : 0.15,
                    text: Text(
                      "Yr",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (state.checkMonthYear == true) {
                      emiCountCubit.yearAndMonthSelect(
                        checkTextFieldValue: false,
                        state: state,
                        value: emiCountCubit.loanTenureController.text,
                        check: false,
                      );
                    }
                  },
                  child: commonContainer(
                    width: 40.w,
                    height: 35.h,
                    borderColor: Colors.black.withOpacity(0.5),
                    horizontalPadding: 0.w,
                    withOpacity: state.checkMonthYear == false ? 0.75 : 0.15,
                    text: Text(
                      "Mo",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
          state.checkMonthYear == true
              ? sliderWidget(
                  onChanged: (value) {
                    emiCountCubit.yearAndMonthSelect(
                      state: state,
                      check: state.checkMonthYear,
                      checkTextFieldValue: true,
                      value: "$value",
                    );
                  },
                  loanValue: state.loanTenuresYearSlider >= 30 ? 30 : state.loanTenuresYearSlider,
                  interval: 5,
                  max: 30,
                  min: 0,
                )
              : sliderWidget(
                  onChanged: (value) {
                    emiCountCubit.yearAndMonthSelect(
                      state: state,
                      check: state.checkMonthYear,
                      checkTextFieldValue: true,
                      value: "$value",
                    );
                  },
                  loanValue: state.loanTenuresMonthSlider >= 360 ? 360 : state.loanTenuresMonthSlider,
                  interval: 60,
                  max: 360,
                  min: 0,
                ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonContainer(
                  horizontalPadding: 0,
                  withOpacity: 0,
                  height: 220.h,
                  radius: 5.r,
                  width: double.infinity,
                  text: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Loan EMI",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Text(
                        state.emi.formatCurrency(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                      ),
                      const Divider(),
                      Text(
                        "Total Interest Payable",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Text(
                        state.totalInterest.formatCurrency(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                      ),
                      const Divider(),
                      Text(
                        "Total Payment \n(Principal + Interest)",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Text(
                        state.totalPayment.formatCurrency(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                      ),
                    ],
                  ),
                ),
                commonContainer(
                  horizontalPadding: 0,
                  withOpacity: 0,
                  height: 220.h,
                  radius: 5,
                  width: double.infinity,
                  text: PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 10.h,
                    chartRadius: 160.r,
                    colorList: [
                      Colors.green.shade800,
                      Colors.orange.shade700,
                    ],
                    initialAngleInDegree: 275,
                    chartType: ChartType.disc,
                    ringStrokeWidth: 10,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: true,
                      legendPosition: LegendPosition.bottom,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      chartValueStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      showChartValueBackground: false,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 2,
                    ),
                  ),
                ),
                SizedBox(height: 20.h)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget commonTextfile({
    required TextEditingController controller,
    required Widget suffixWidget,
    required String hinttext,
    required String text,
    required EmiCountLoadedState state,
    void Function(String)? onSubmitted,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 35.h,
                  child: TextField(
                    onSubmitted: onSubmitted,
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 0),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: hinttext,
                    ),
                  ),
                ),
              ),
              suffixWidget,
            ],
          ),
        ],
      ),
    );
  }

  Widget commonContainer({
    double? height,
    double? width,
    double? radius,
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
        borderRadius: BorderRadius.circular(radius ?? 0),
        color: Colors.grey.withOpacity(withOpacity),
        border: Border.all(color: borderColor ?? Colors.black.withOpacity(0.32)),
      ),
      child: text,
    );
  }

  Widget sliderWidget({
    required void Function(dynamic)? onChanged,
    required double loanValue,
    required double interval,
    required double max,
    required double min,
    String Function(dynamic, String)? labelFormatterCallback,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SfSlider(
        min: min,
        max: max,
        interval: interval,
        showLabels: true,
        showTicks: true,
        labelFormatterCallback: labelFormatterCallback,
        onChangeEnd: (value) {  
          updateSliderValue();
        },
        inactiveColor: Colors.grey.shade400,
        activeColor: Colors.orange,
        value: loanValue,
        onChanged: onChanged,
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
