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
  final double emi;
  final bool isShowData;
  final double piePrincipalLoanAmount;
  final double pieInterest;
  final double totalInterest;
  final double totalPayment;
  EmiCountLoadedState({
    this.random,
    required this.checkMonthYear,
    required this.pieInterest,
    required this.isShowData,
    required this.totalInterest,
    required this.totalPayment,
    required this.piePrincipalLoanAmount,
    required this.emi,
  });
  EmiCountLoadedState copyWith({
    double? totalInterest,
    double? piePrincipalLoanAmount,
    double? totalPayment,
    int? yearAndMonthIndex,
    double? random,
    double? emi,
    bool? isShowData,
    double? pieInterest,
    bool? checkMonthYear,
  }) {
    return EmiCountLoadedState(
      emi: emi ?? this.emi,
      random: random ?? this.random,
      isShowData: isShowData??this.isShowData,
      totalPayment: totalPayment ?? this.totalPayment,
      totalInterest: totalInterest ?? this.totalInterest,
      pieInterest: piePrincipalLoanAmount ?? this.pieInterest,
      piePrincipalLoanAmount: pieInterest ?? this.piePrincipalLoanAmount,
      checkMonthYear: checkMonthYear ?? this.checkMonthYear,
    );
  }

  @override
  List<Object?> get props => [
        random,
        isShowData,
        emi,
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
