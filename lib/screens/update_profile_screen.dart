import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../App_Theme/app_theme.dart';

class UpdateProfileScreen extends StatelessWidget {
   UpdateProfileScreen({super.key});

   final TextEditingController username = TextEditingController(); // to accept the username
   final TextEditingController email = TextEditingController();// to accept email
   final TextEditingController age = TextEditingController();
   //function to save user details passed to the update button

   bool isDarkModeEnabled = AppTheme.isDarkModeEnabled;

   Future <void> saveDetails(String key, String value) async{ // this saves our data in our local storage
     SharedPreferences _prefs = await SharedPreferences.getInstance();
     await _prefs.setString(key, value);
}
   void saveUserDetails() async {
      await saveDetails('username', username.text); //the '.text' shows the details we have entered
      await saveDetails('email', email.text);
      await saveDetails('age', age.text);
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isDarkModeEnabled ? Colors.black : Colors.white,
        appBar: AppBar(
          title: Text(
            "Profile Update"
        ),
      ),
      body: Column(
        children: [
          customTextField("Enter Username", username, false, ),
          customTextField("Enter Email", email, false),
          //customTextField("Enter Age", age, true),
          ElevatedButton(onPressed: (){
            saveUserDetails();
            },
              child: Text("Update"),
          ),
        ],
      ),
    );
  }

  //created to avoid repetition
  Widget customTextField(String title, TextEditingController controller, bool theAgeTextField){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        keyboardType: theAgeTextField ? TextInputType.number : null,
        controller: controller, //assigned controller to a single text field
        decoration: InputDecoration(

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isDarkModeEnabled ? Colors.white : Colors.white,
            ),
          ),
          hintText: title,
          hintStyle:  TextStyle( color: isDarkModeEnabled ? Colors.white : null), //received from the parameter
        ),
      ),
    );
  }
}
