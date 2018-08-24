import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String firstName;
  String lastName;
  String companyName;
  String emailAddress;
  String userType;
  String password;
  String companyAddress;
  String uid;

  User( this.firstName, this.lastName, this.companyName, this.emailAddress,
      this.userType, this.password, this.companyAddress, this.uid);

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        firstName = snapshot.value["First Name"],
        lastName = snapshot.value["Last Name"],
        companyName = snapshot.value["Company Name"],
        emailAddress = snapshot.value["Email Address"],
        userType = snapshot.value["User Type"],
        password = snapshot.value["Password"],
        companyAddress = snapshot.value["Company Address"],
        uid = snapshot.value["Uid"];

  toJson() {
    return {
      "First Name": firstName,
      "Last Name": lastName,
      "Company Name": companyName,
      "Email Address": emailAddress,
      "User Type": userType,
      "Password": password,
      "Company Address": companyAddress,
      "Uid": uid,
    };
  }
}
