// ignore_for_file: must_be_immutable

part of 'emi_count_cubit.dart';

abstract class EmiCountState extends Equatable {
  const EmiCountState();

  @override
  List<Object?> get props => [];
}

class EmiCountInitial extends EmiCountState {
  @override
  List<Object?> get props => [];
}

class EmiCountLoadingState extends EmiCountState {
  @override
  List<Object?> get props => [];
}

class EmiCountLoadedState extends EmiCountState {
  double? random;
  final bool checkMonthYear;
  final double homeSliderValue;
  final double interestRateSliderValue;
  final double loanTenuresYearSlider;
  final double loanTenuresMonthSlider;
  final double emi;
  final double piePrincipalLoanAmount;
  final double pieInterest;
  final double totalInterest;
  final double totalPayment;

  EmiCountLoadedState({
    this.random,
    required this.homeSliderValue,
    required this.interestRateSliderValue,
    required this.loanTenuresMonthSlider,
    required this.loanTenuresYearSlider,
    required this.checkMonthYear,
    required this.pieInterest,
    required this.totalInterest,
    required this.totalPayment,
    required this.piePrincipalLoanAmount,
    required this.emi,
  });

  EmiCountLoadedState copyWith({
    double? totalInterest,
    double? piePrincipalLoanAmount,
    double? totalPayment,
    double? homeSliderValue,
    double? interestRateSliderValue,
    double? random,
    double? emi,
    double? pieInterest,
    double? loanTenuresYearSlider,
    double? loanTenuresMonthSlider,
    bool? checkMonthYear,
  }) {
    return EmiCountLoadedState(
      emi: emi ?? this.emi,
      random: random ?? this.random,
      totalPayment: totalPayment ?? this.totalPayment,
      totalInterest: totalInterest ?? this.totalInterest,
      pieInterest: piePrincipalLoanAmount ?? this.pieInterest,
      homeSliderValue: homeSliderValue ?? this.homeSliderValue,
      piePrincipalLoanAmount: pieInterest ?? this.piePrincipalLoanAmount,
      interestRateSliderValue: interestRateSliderValue ?? this.interestRateSliderValue,
      loanTenuresYearSlider: loanTenuresYearSlider ?? this.loanTenuresYearSlider,
      loanTenuresMonthSlider: loanTenuresMonthSlider ?? this.loanTenuresMonthSlider,
      checkMonthYear: checkMonthYear ?? this.checkMonthYear,
    );
  }

  @override
  List<Object?> get props => [
        random,
        emi,
        homeSliderValue,
        interestRateSliderValue,
        totalInterest,
        piePrincipalLoanAmount,
        totalPayment,
        loanTenuresMonthSlider,
        loanTenuresYearSlider,
        pieInterest,
      ];
}

class EmiCountErrorState extends EmiCountState {
  final String errorMessage;

  const EmiCountErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
