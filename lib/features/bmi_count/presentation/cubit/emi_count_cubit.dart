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
            checkMonthYear: true,
            totalPayment: 0,
            loanTenuresMonthSlider: 120,
            loanTenuresYearSlider: 10,
            piePrincipalLoanAmount: 0,
            emi: 0,
            pieInterest: 0,
            homeSliderValue: 10,
            interestRateSliderValue: 10,
          ),
        );
  TextEditingController homeLoanController = TextEditingController(text: "5000000");
  TextEditingController interestRateController = TextEditingController(text: "10");
  TextEditingController loanTenureController = TextEditingController(text: "15");
  double emiCount = 0.0;

//Emi Count Method
  void updateEmi({
    required int principal,
    required double interestRate,
    required double tenure,

  }) {
    var loadedState = state as EmiCountLoadedState;
    double monthlyInterestRate = (interestRate / 12) / 100;
    double year = 0;
    if (loadedState.checkMonthYear == true) {
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
  void yearAndMonthSelect({
    required EmiCountLoadedState state,
    required bool check,
    required bool checkTextFieldValue,
    required String value,
  }) {
    double year = state.loanTenuresYearSlider;
    double month = state.loanTenuresMonthSlider;
    String textValue = value;
    if (check) {
      year = 0;
      if (checkTextFieldValue) {
        year = (double.parse(textValue));
        loanTenureController = TextEditingController(text: double.parse(textValue).toStringAsFixed(0));
      } else {
        year = (double.parse(textValue) / 12);
        loanTenureController = TextEditingController(text: year.toStringAsFixed(1));
      }
    } else {
      month = 0;
      if (checkTextFieldValue) {
        month = (double.parse(textValue));
        loanTenureController = TextEditingController(text: double.parse(textValue).toStringAsFixed(0));
      } else {
        month = double.parse(textValue) * 12;
        loanTenureController = TextEditingController(text: month.toStringAsFixed(0));
      }
    }

    emit(
      state.copyWith(
        loanTenuresYearSlider: year,
        loanTenuresMonthSlider: month,
        checkMonthYear: check,
        random: Random().nextDouble(),
      ),
    );
  }

}
