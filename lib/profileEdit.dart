import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileEdit(),
  ));
}

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Done",
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage("https://i.postimg.cc/hvCvRj8p/th.jpg")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Leonardo",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Change Profile Picture",
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWithTextField(label: "First Name", hintText: "Leonardo"),
                  SizedBox(height: 15),
                  LabelWithTextField(label: "Last Name", hintText: "Da Vinci"),
                  SizedBox(height: 15),
                  LabelWithTextField(
                      label: "Email", hintText: "leonardo@mail.com"),
                  SizedBox(height: 15),
                  LabelWithTextField(
                      label: "Phone Number", hintText: "123-456-7890"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabelWithTextField extends StatelessWidget {
  final String label;
  final String hintText;

  const LabelWithTextField({
    Key? key,
    required this.label,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
