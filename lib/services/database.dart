import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/brew.dart';
import '../models/user.dart';

class DatabaseService{

  final String? uid;

  DatabaseService({
      this.uid,
  });
  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection("brews"); 


  Future updateUserData(int sugars,String name, String strength) async {
    return brewCollection.doc(uid).set({
      "sugar":sugars,
      "name":name,
      "strength":strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(name: doc.get("name") ?? "", sugar: doc.get("sugar") ?? 0, strength: doc.get("strength") ?? "");
    } ).toList();
  }

  // userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid!, name: snapshot.get("name"), strength: snapshot.get("strength"), sugars: snapshot.get("sugar"));

  }

 // get brew strean
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map((snapshot) {
      return _brewListFromSnapshot(snapshot);
    });
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot) ;
  }
}