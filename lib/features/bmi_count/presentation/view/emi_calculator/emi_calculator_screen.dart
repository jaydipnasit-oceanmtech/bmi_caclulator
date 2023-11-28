import 'package:bmi_caclulator/features/bmi_count/presentation/cubit/emi_count_cubit.dart';
import 'package:bmi_caclulator/features/bmi_count/presentation/view/emi_calculator/emi_calculator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmiCalculatorScreen extends StatefulWidget {
  const EmiCalculatorScreen({super.key});

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends EmiCalculatorWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0XFF084277),
        leading: Icon(
          Icons.arrow_back_ios,
          size: 18.sp,
          color: const Color(0XFFFFFFFF),
        ),
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          'Loan Emi Calculator',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0XFFFFFFFF),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: BlocBuilder(
        bloc: emiCountCubit,
        builder: (context, state) {
          if (state is EmiCountLoadedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loanAmoutWidget(state: state),
                  ],
                ),
              ),
            );
          } else if (state is EmiCountLoadingState) {
            return const SizedBox.shrink();
          } else if (state is EmiCountErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
