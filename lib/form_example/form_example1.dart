import 'package:flutter/material.dart';

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String firstname = "";
  String lastname = "";
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  String? selectedGender;
  bool isAccepted   = false;
  String? marriedStatus;
  bool isReceive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Example")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Name
              TextFormField(
                controller: firstnameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Please enter your name" : null,
              ),
        
              // Lastname
              TextFormField(
                controller: lastnameController,
                decoration: const InputDecoration(labelText: "Lastname"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Please enter your lastname" : null,
              ),
              DropdownButtonFormField(
                value: selectedGender,
                items: [ 'Male', 'Female', 'Other' ]
                    .map((String item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        )).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
                validator: (String? value) =>
                    value == null || value.isEmpty ? "Please select your gender" : null,
              ),
              Column(
                children: [
                  RadioListTile(
                    title: Text("Married"),
                    value: "Married",
                    groupValue: marriedStatus,
                    onChanged: (value) {
                      setState(() {
                        marriedStatus = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Single"),
                    value: "Single",
                    groupValue: marriedStatus,
                    onChanged: (value) {
                      setState(() {
                        marriedStatus = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Separated"),
                    value: "Separated",
                    groupValue: marriedStatus,
                    onChanged: (value) {
                      setState(() {
                        marriedStatus = value;
                      });
                    },
                  ),
                ],
              ),
              SwitchListTile(
                title: const Text("Enable Receive Newsletter"),
                value: isReceive,
                onChanged: (bool value) {
                  setState(() {
                    isReceive = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Accept Terms and Conditions"),
                value: isAccepted,
                onChanged: (bool? value) {
                  setState(() {
                    isAccepted = value!;
                  });
                },
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      firstnameController.text = "Dev";
                      lastnameController.text = "Ops";
                    },
                    child: Text("Auto Fill"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      firstnameController.clear();
                      lastnameController.clear();
                    },
                    child: Text("Clear"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print(('Name: ${firstnameController.text}, Lastname: ${lastnameController.text}'));
                      }
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
