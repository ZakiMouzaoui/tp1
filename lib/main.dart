import 'dart:math';

import 'package:bmi_2/result_page.dart';
import 'package:flutter/material.dart';

import 'gender.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const CalculatorPage()));
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  int height = 180;
  int weight = 60;
  int age = 18;
  Gender gender = Gender.none;
  late String status;
  late double bmi;
  late String description;
  late Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("BMI Calculator"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = Gender.male;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: gender == Gender.male
                                ? Colors.black45
                                : Colors.black87,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.male,
                              size: 70,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "MALE",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = Gender.female;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: gender == Gender.female
                                ? Colors.black45
                                : Colors.black87,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.female,
                              size: 70,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "FEMALE",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "HEIGHT",
                      style: TextStyle(fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          height.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50),
                        ),
                        const Text("cm")
                      ],
                    ),
                    Slider(
                      value: height.toDouble(),
                      onChanged: (newValue) {
                        setState(() {
                          height = newValue.toInt();
                        });
                      },
                      min: 120,
                      max: 220,
                      inactiveColor: Colors.white,
                      activeColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "WEIGHT",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        weight.toString(),
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              if (weight > 0) {
                                setState(() {
                                  weight--;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 40,
                            ),
                            shape: const CircleBorder(),
                            fillColor: Colors.grey,
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                weight++;
                              });
                            },
                            child: const Icon(
                              Icons.add,
                              size: 40,
                            ),
                            shape: CircleBorder(),
                            fillColor: Colors.grey,
                          )
                        ],
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "AGE",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        age.toString(),
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              if (age > 3) {
                                setState(() {
                                  age--;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 40,
                            ),
                            shape: const CircleBorder(),
                            fillColor: Colors.grey,
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              if (age < 120) {
                                setState(() {
                                  age++;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.add,
                              size: 40,
                            ),
                            shape: const CircleBorder(),
                            fillColor: Colors.grey,
                          )
                        ],
                      )
                    ],
                  ),
                ))
              ],
            )),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  calculateBmi();

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResultPage(bmi: bmi, status: status, description: description,)));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                  ),
                  child: const Center(
                      child: Text(
                    "CALCULATE",
                    style: TextStyle(fontSize: 30),
                  )),
                ),
              ),
            )
          ],
        ));
  }

  void calculateBmi(){
    setState(() {
      bmi = weight/pow(height/100,2);
    });

    if(bmi<18.5){
      setState(() {
        status = "UNDER WEIGHT";
        description = "You are underweight. You can try to eat a bit more";
      });
    }
    else if(bmi>=18.5 && bmi<25){
      setState(() {
        status = "NORMAL";
        description = "Good Job! Your weight is normal";
      });
    }
    else{
      setState(() {
        status = "OVER WEIGHT";
        description = "You are overweight. You can exercice a bit more";
      });
    }
  }
}
