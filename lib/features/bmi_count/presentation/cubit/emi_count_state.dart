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
  double? homeSliderValue;
  double? interestRateSliderValue;
  double? loanTenuresMonthSlider;
  final int yearAndMonthIndex;
  final double emi;
  final double piePrincipalLoanAmount;
  final double pieInterest;
  final double totalInterest;
  final double totalPayment;

  EmiCountLoadedState({
    this.random,
    this.homeSliderValue,
    this.interestRateSliderValue,
    this.loanTenuresMonthSlider,
    required this.pieInterest,
    required this.totalInterest,
    required this.totalPayment,
    required this.yearAndMonthIndex,
    required this.piePrincipalLoanAmount,
    required this.emi,
  });

  EmiCountLoadedState copyWith({
    int? yearAndMonthIndex,
    double? totalInterest,
    double? piePrincipalLoanAmount,
    double? totalPayment,
    double? homeSliderValue,
    double? interestRateSliderValue,
    double? random,
    double? emi,
    double? pieInterest,
    double? loanTenuresMonthSlider,
  }) {
    return EmiCountLoadedState(
      emi: emi ?? this.emi,
      random: random ?? this.random,
      totalPayment: totalPayment ?? this.totalPayment,
      totalInterest: totalInterest ?? this.totalInterest,
      pieInterest: piePrincipalLoanAmount ?? this.pieInterest,
      homeSliderValue: homeSliderValue ?? this.homeSliderValue,
      yearAndMonthIndex: yearAndMonthIndex ?? this.yearAndMonthIndex,
      piePrincipalLoanAmount: pieInterest ?? this.piePrincipalLoanAmount,
      interestRateSliderValue: interestRateSliderValue ?? this.interestRateSliderValue,
      loanTenuresMonthSlider: loanTenuresMonthSlider ?? this.loanTenuresMonthSlider,
    );
  }

  @override
  List<Object?> get props => [
        random,
        emi,
        yearAndMonthIndex,
        homeSliderValue,
        interestRateSliderValue,
        loanTenuresMonthSlider,
        totalInterest,
        piePrincipalLoanAmount,
        totalPayment,
        pieInterest,
      ];
}

class EmiCountErrorState extends EmiCountState {
  final String errorMessage;

  const EmiCountErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
