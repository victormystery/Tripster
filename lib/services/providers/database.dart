import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  String uid = Uuid().v4();

  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
  final CollectionReference placeCollection =
      FirebaseFirestore.instance.collection('places');

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
}
