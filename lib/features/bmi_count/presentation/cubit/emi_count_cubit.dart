import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'emi_count_state.dart';

class EmiCountCubit extends Cubit<EmiCountState> {
  EmiCountCubit()
      : super(
          EmiCountLoadedState(
            totalInterest: 0,
            totalPayment: 0,
            piePrincipalLoanAmount: 0,
            emi: 0,
            pieInterest: 0,
            yearAndMonthIndex: 0,
          ),
        );
  TextEditingController homeLoanController = TextEditingController(text: "500000");
  TextEditingController interestRateController = TextEditingController(text: "5");
  TextEditingController loanTenureController = TextEditingController(text: "10");
  double emiCount = 0.0;

  void yearAndMonthSelect({
    required EmiCountLoadedState state,
    required int yearAndMonthIndex,
    required String value,
  }) {
    double month = 0;
    double year = 0;
    year = double.parse(value);
    month = double.parse(value) * 12;
    loanTenureController = TextEditingController(
      text: yearAndMonthIndex == 0
          ? year <= 30 && year >= 0
              ? value
              : (year / 12).toStringAsFixed(1)
          : month <= 360 && month >= 0
              ? (month).toStringAsFixed(1)
              : value,
    );
    emit(
      state.copyWith(
        yearAndMonthIndex: yearAndMonthIndex,
        loanTenuresMonthSlider: yearAndMonthIndex == 0 ? year.toDouble() : month.toDouble(),
        random: Random().nextDouble(),
      ),
    );
  }

//Emi Count Method
  void updateEmi({
    required int principal,
    required double interestRate,
    required double tenure,
    required int index,
  }) {
    var loadedState = state as EmiCountLoadedState;
    double monthlyInterestRate = (interestRate / 12) / 100;
    double year = 0;
    if (index == 0) {
      year = (tenure * 12);
    } else {
      year = tenure;
    }
    double emi = (principal * monthlyInterestRate * pow(1 + monthlyInterestRate, year)) /
        (pow(1 + monthlyInterestRate, year) - 1);
    emiCount = emi;
    double totalInterest = emiCount * year - principal;
    double totalPayment = emiCount * year;
    double piePrincipalLoanAmount = totalInterest / totalPayment * 100;
    double pieInterest = principal / totalPayment * 100;
    emit(
      loadedState.copyWith(
        emi: emiCount,
        totalInterest: totalInterest,
        totalPayment: totalPayment,
        pieInterest: pieInterest,
        piePrincipalLoanAmount: piePrincipalLoanAmount,
        random: Random().nextDouble(),
      ),
    );
  }

//HomeLoanAmountSlider
  void homeLoanAmountSlider({
    required EmiCountLoadedState state,
    required double homeLoanSliderValue,
    required bool isCheck,
  }) {
    if (isCheck) {
      homeLoanController = TextEditingController(text: (homeLoanSliderValue).toStringAsFixed(0));
    } else {
      homeLoanController = TextEditingController(text: (homeLoanSliderValue * 100000).toStringAsFixed(0));
    }
    emit(state.copyWith(homeSliderValue: homeLoanSliderValue, random: Random().nextDouble()));
  }

//InTerestRatetSlider
  void interestRateSliderMethod({
    required EmiCountLoadedState state,
    required String interestRateSlider,
  }) {
    interestRateController = TextEditingController(
      text: double.parse(interestRateSlider).toStringAsFixed(1),
    );
    emit(
      state.copyWith(
        interestRateSliderValue: double.parse(interestRateSlider),
        random: Random().nextDouble(),
      ),
    );
  }

//LoanTenureSlider
  void loanTenureMethod({
    required EmiCountLoadedState state,
    required double loanTenuresMonthSliderValues,
  }) {
    int loanMonth = 0;
    loanMonth = loanTenuresMonthSliderValues ~/ 1;
    loanTenureController = TextEditingController(text: "$loanMonth");
    emit(
      state.copyWith(
        loanTenuresMonthSlider: loanTenuresMonthSliderValues,
        random: Random().nextDouble(),
      ),
    );
  }
}
