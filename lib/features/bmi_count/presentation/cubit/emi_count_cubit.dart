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
            piePrincipalLoanAmount: 0,
            emi: 0,
            pieInterest: 0,
          ),
        );
  TextEditingController homeLoanController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController loanTenureController = TextEditingController();
  final amountKey = GlobalKey<FormState>();
  final loanTenureKey = GlobalKey<FormState>();
  final intereastKey = GlobalKey<FormState>();
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

//Loan Tenure opetions
  void yearAndMonthSelect({
    required EmiCountLoadedState state,
    required bool check,
    required bool checkTextFieldValue,
    required String value,
  }) {
    double year;
    double month;
    String textValue = value;
    if (check) {
      year = 0;
      if (checkTextFieldValue) {
        if (textValue.isNotEmpty) {
          year = (double.parse(textValue));
          loanTenureController = TextEditingController(text: double.parse(textValue).toStringAsFixed(0));
        }
      } else {
        if (textValue.isNotEmpty) {
          year = (double.parse(textValue) / 12);
          loanTenureController = TextEditingController(text: year.toStringAsFixed(1));
        }
      }
    } else {
      month = 0;
      if (checkTextFieldValue && loanTenureController.text.isEmpty) {
        if (textValue.isNotEmpty) {
          month = (double.parse(textValue));
          loanTenureController = TextEditingController(text: double.parse(textValue).toStringAsFixed(0));
        }
      } else {
        if (textValue.isNotEmpty) {
          month = double.parse(textValue) * 12;
          loanTenureController = TextEditingController(text: month.toStringAsFixed(0));
        }
      }
    }
    emit(
      state.copyWith(
        checkMonthYear: check,
        random: Random().nextDouble(),
      ),
    );
  }
}
