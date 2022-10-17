import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_application/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireStoreController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final usersRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<Users>(
        fromFirestore: (snapshots, _) => Users.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      )
      .obs;

  final textCtrl = TextEditingController().obs;
  final textCtrl2 = TextEditingController().obs;
  final textCtrl3 = TextEditingController().obs;
  final textCtrlS = TextEditingController().obs;

  final textCtrl_1 = TextEditingController().obs;
  final textCtrl_2 = TextEditingController().obs;
  final textCtrl_3 = TextEditingController().obs;

  final name = ''.obs;
  final email = ''.obs;
  final pwd = ''.obs;

  final name1 = ''.obs;
  final email2 = ''.obs;
  final pwd3 = ''.obs;

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> addUser(BuildContext context) async {
    if (textCtrl.value.text != '' &&
        textCtrl2.value.text != '' &&
        textCtrl2.value.text != '') {
      final user = Users(
          username: name.value,
          email: email.value,
          password: pwd.value,
          createdDate: formatDate(DateTime.now()));

      await usersRef.value.add(user);

      textCtrl.value.text = '';
      textCtrl2.value.text = '';
      textCtrl3.value.text = '';

      name.value = '';
      email.value = '';
      pwd.value = '';

      // show toast flutter
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Successfuly add user"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill all field"),
      ));
    }
  }

  Query<Users> queryByUsername(String username) {
    return usersRef.value.where('username', isEqualTo: username);
  }

  Stream<QuerySnapshot<Users>> getAllUsers() {
    return usersRef.value.snapshots();
  }

  Future<void> updateUser(BuildContext context) async {
    if (textCtrl_1.value.text != '' &&
        textCtrl_2.value.text != '' &&
        textCtrl_3.value.text != '') {
      final user = Users(
          username: name1.value,
          email: email2.value,
          password: pwd3.value,
          createdDate: formatDate(DateTime.now()));

      final query = queryByUsername(name1.value);
      final doc = await query.get();
      final id = doc.docs.first.id;

      await usersRef.value.doc(id).update(user.toJson());

      textCtrl_1.value.text = '';
      textCtrl_2.value.text = '';
      textCtrl_3.value.text = '';

      name1.value = '';
      email2.value = '';
      pwd3.value = '';

      // show toast flutter
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Successfuly update user"),
      ));

      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill all field"),
      ));
      return;
    }
  }

  Future<void> deleteUser(String username) {
    return usersRef.value.doc(username).delete();
  }
}
