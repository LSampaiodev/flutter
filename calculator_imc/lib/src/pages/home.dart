import 'package:bq_health/src/components/form_imc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
             Container(
              decoration: containerTitle,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Center (child: Text(
                'BQ HEALTH', 
                style: styleText,)),
             ),
            Container(
              decoration: containerForms,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7 - 16,
              child: const FormImc(),
            ),
          ],
        ),
      ),
    );
  }
}

const containerTitle = BoxDecoration(
  color: Color.fromARGB(255, 94, 0, 27),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);

const containerForms = BoxDecoration(
  color: Colors.amber,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);

const styleText = TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
color: Color.fromARGB(207, 255, 255, 255),
);
