import 'package:flutter/material.dart';


class ResultPage extends StatelessWidget {
  final double bmi;
  final String status;
  final String description;
  const ResultPage({Key? key, required this.bmi, required this.status, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("YOUR RESULT", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 140,),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text(status, style: TextStyle(fontSize: 20, color: status=="NORMAL" ? Colors.green : Colors.red),),),
                Text(bmi.toStringAsFixed(1), style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold)),
                SizedBox(height:10),
                Expanded(child: Text(description)),
                Expanded(child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top:40),
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.red
                    ),
                    child: Center(child: Text("RECALCULATE", style: const TextStyle(fontSize: 30),)),
                  ),
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
