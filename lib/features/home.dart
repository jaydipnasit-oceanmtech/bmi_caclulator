import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  bool checkButtonColor = false;
  double value = 10;
  double year = 10;
  double month = 120;
  TextEditingController txt = TextEditingController(text: "30");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: txt,
                onSubmitted: (v) {
                  txt = TextEditingController(text: v);
                  year = double.parse(txt.text);
                  setState(() {});
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (checkButtonColor) {
                    year = 0;
                    checkButtonColor = false;
                    year = double.parse(txt.text) / 12;
                    print(year);
                    txt = TextEditingController(text: "${month / 12}");

                    setState(() {});
                  } else {
                    null;
                  }
                  setState(() {});
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    checkButtonColor ? Colors.transparent : Colors.blue.shade200,
                  ),
                ),
                child: const Text("Year"),
              ),
              const Spacer(),
              Text(txt.text),
              const Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    checkButtonColor ? Colors.blue.shade200 : Colors.transparent,
                  ),
                ),
                onPressed: () {
                  if (checkButtonColor == false) {
                    month = 0;
                    checkButtonColor = true;
                    month = double.parse(txt.text) * 12;
                    print(month);
                    txt = TextEditingController(text: "${month * 12 / 12}");
                    // value = valueChange(value: value, check: checkButtonColor);
                    setState(() {});
                  } else {
                    null;
                  }
                },
                child: const Text("Month"),
              ),
              checkButtonColor
                  ? SfSlider(
                      // month
                      value: month >= 360 ? 360 : double.parse(txt.text),
                      max: 360,
                      onChanged: (v) {
                        month = v;
                        txt = TextEditingController(text: "$v");
                        // valueChange(value: checkButtonColor ? v : v, check: checkButtonColor);
                        setState(() {});
                      },
                      interval: 30,
                      min: 0,
                      showLabels: true,
                    )
                  : SfSlider(
                      value: year > 30 ? 30 : double.parse(txt.text),
                      max: 30,
                      onChanged: (v) {
                        year = v;
                        txt = TextEditingController(text: "$v");
                        setState(() {});
                      },
                      interval: 5,
                      min: 0,
                      showLabels: true,
                    ),
              const Spacer(),
              Text(checkButtonColor ? "Month" : "Year"),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  //         false = month
  //         true = year

  // double valueChange({required double value, bool? check}) {
  //   double ans;
  //   if (check == true) {
  //     print("object");
  //     ans = value * 12;
  //   } else {
  //     ans = value / 12;
  //   }
  //   print(ans);
  //   return ans;
  // }
}


//  SfSlider(
//         min: min,
//         max: max,
//         interval: interval,
//         showLabels: true,
//         showTicks: true,
//         onChangeEnd: (value) {
//           updateSliderValue();
//         },
//         inactiveColor: Colors.grey.shade400,
//         activeColor: Colors.orange,
//         value: loanValue,
//         onChanged: onChanged,
//       ),
//     );