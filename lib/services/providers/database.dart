import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");

  Future saveUserData(String email, String username) async {
    return await userCollection.doc(uid).set({
      "email": email,
      "username": username,
      "profilePicture": "",
      "uid": uid,
      "current_location": "",
    });
  }

  Future getUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future getPlaceData() async {
    var placeData = FirebaseFirestore.instance.collection('place').doc().get();
  }
}
