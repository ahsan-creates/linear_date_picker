import 'package:flutter/material.dart';
import 'package:linear_date_picker/linear_date_picker.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Dob());
  }
}

class Dob extends StatefulWidget {
  const Dob({super.key});

  @override
  State<Dob> createState() => _DobState();
}

class _DobState extends State<Dob> {
  final dobTxtCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    dobTxtCtrl.text = _calculateAge(
      DateTime(DateTime.now().year - 18),
    ).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight),
              Text(
                'What\'s your date of birth?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF2A2A2A),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 100),

              //
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: dobTxtCtrl,
                  enabled: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2A2A2A),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFD4452),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xFFFD4452),
                        width: 0.2,
                      ),
                    ),
                  ),
                ),
              ),

              //
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: LinearDatePicker(
                  startDate: DateTime(1900),
                  endDate: DateTime.now(),
                  initialDate: DateTime(DateTime.now().year - 18),
                  dateChangeListener: (DateTime selectedDate) {
                    dobTxtCtrl.text = _calculateAge(selectedDate).toString();
                    setState(() {});
                  },
                  showDay: true,
                  dayDecoration: _getDecoration(context, 'day'),
                  monthDecoration: _getDecoration(context, 'month'),
                  yearDecoration: _getDecoration(context, 'year'),
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFD4452),
                  ),
                  selectedRowStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  unselectedRowStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2A2A2A),
                  ),
                  columnWidth: 100,
                  showMonthName: true,
                  debounceDuration: Duration(milliseconds: 300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateAge(DateTime dob) {
    final now = DateTime.now();
    final age = now.year - dob.year;
    return age;
  }

  Decoration _getDecoration(BuildContext context, String type) {
    double topLeft = 0;
    double bottomLeft = 0;
    double topRight = 0;
    double bottomRight = 0;

    if (type == 'month') {
      topLeft = 10;
      bottomLeft = 10;
    }
    if (type == 'year') {
      topRight = 10;
      bottomRight = 10;
    }

    return BoxDecoration(
      color: Color(0xFFFD4452),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        bottomLeft: Radius.circular(bottomLeft),
        topRight: Radius.circular(topRight),
        bottomRight: Radius.circular(bottomRight),
      ),
    );
  }
}
