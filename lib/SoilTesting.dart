// SoilTesting.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class SoilTestingScreen extends StatefulWidget {
  const SoilTestingScreen({super.key});

  @override
  _SoilTestingScreenState createState() => _SoilTestingScreenState();
}

class _SoilTestingScreenState extends State<SoilTestingScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        datecontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        timecontroller.text = picked.format(context);
      });
    }
  }

void clearfield(){
    setState(() {
      namecontroller.clear();
      addresscontroller.clear();
      datecontroller.clear();
      timecontroller.clear();
      phonecontroller.clear();
    });
}


  ///setvalues//

final databaseRef=FirebaseDatabase.instance.ref("Soil Appointment");
int index=1;
TextEditingController namecontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();
  TextEditingController datecontroller=TextEditingController();
  TextEditingController timecontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soil Testing Appoinment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: addresscontroller,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: datecontroller,
                    decoration: InputDecoration(labelText: 'Appointment Date'),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the appointment date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: timecontroller,
                    decoration: InputDecoration(labelText: 'Appointment Time'),
                    readOnly: true,
                    onTap: () => _selectTime(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the appointment time';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phonecontroller,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10)
                    ],
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if(value.length != 10){
                        return 'Phone number should 10 digit only';
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {

                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        databaseRef.child(DateTime.now().microsecondsSinceEpoch.toString()).set({
                          "name":namecontroller.text.toString(),
                          "address":addresscontroller.text.toString(),
                          "date":datecontroller.text.toString(),
                          "time":timecontroller.text.toString(),
                          "phone":phonecontroller.text.toString()
                        });
                        Fluttertoast.showToast(
                          msg: "Form submitted successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,

                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        clearfield();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    namecontroller.dispose();
    addresscontroller.dispose();
    datecontroller.dispose();
    timecontroller.dispose();
    phonecontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
