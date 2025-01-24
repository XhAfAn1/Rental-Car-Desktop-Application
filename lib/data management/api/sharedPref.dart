

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../all classes/person.dart';
import '../userData/currentUser.dart';


const String KEYLOGIN ="login";
SharedPreferences? sp;
getInstance() async {
  sp=await SharedPreferences.getInstance();
  await loadCurrentUser();
}
loggedin() async {
  var sharedPref = await SharedPreferences.getInstance();
  sharedPref.setBool(KEYLOGIN, true);
}
logClear() async{
  var sharedPref = await SharedPreferences.getInstance();
  sharedPref.remove(KEYLOGIN);
  sharedPref.clear();

}
Future<void> loadCurrentUser() async {
  var sharedPref = await SharedPreferences.getInstance();
  String? userJson = sharedPref.getString("user");
  print(userJson);
  if (userJson != null) {
    currentUser.CurrentUser = Person.fromJson(jsonDecode(userJson));
  }
}

Future<void> saveUser(Person user) async {
  var sharedPref = await SharedPreferences.getInstance();
  String userJson = jsonEncode(user.toJson()); // Correct JSON encoding
  await sharedPref.setString("user", userJson);
}