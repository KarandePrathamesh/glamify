import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addStudents(Map<String, dynamic> SalonShopsInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("SalonShops")
        .doc(id)
        .set(SalonShopsInfoMap);
  }

  // Future<Stream<QuerySnapshot>> getStudentDetails() async {
  //   return await FirebaseFirestore.instance.collection("Students").snapshots();
  // }

  // updateAttendence(String attendenceCase, String id) async {
  //   return await FirebaseFirestore.instance
  //       .collection("Students")
  //       .doc(id)
  //       .update({attendenceCase: true});
  // }

  // deleteStudentData(String id) async {
  //   return await FirebaseFirestore.instance
  //       .collection("Students")
  //       .doc(id)
  //       .delete();
  // }
}
