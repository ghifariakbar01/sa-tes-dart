// ignore_for_file: depend_on_referenced_packages

import 'package:firestore_application/firestore.dart';
import 'package:firestore_application/user.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ghifari Akbar Flutter Dev - SA Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ctrl = Get.put(FireStoreController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // update user
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("Update User"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 250,
                      width: Get.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 50,
                              width: Get.width,
                              child: TextField(
                                controller: ctrl.textCtrl_1.value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter name',
                                ),
                                onChanged: (v) {
                                  ctrl.name1.value = v;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 50,
                              width: Get.width,
                              child: TextField(
                                controller: ctrl.textCtrl_2.value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter email',
                                ),
                                onChanged: (v) {
                                  ctrl.email2.value = v;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 50,
                              width: Get.width,
                              child: TextField(
                                controller: ctrl.textCtrl_3.value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter passwd',
                                ),
                                onChanged: (v) {
                                  ctrl.pwd3.value = v;
                                },
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await ctrl.updateUser(context);
                            },
                            child: const Text("Add"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // view and delete
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 250,
                        width: Get.width,
                        child: StreamBuilder<QuerySnapshot<Users>>(
                          stream: ctrl.getAllUsers(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        Text(snapshot.data!.docs[index]
                                                .data()
                                                .username ??
                                            ""),
                                        Text(
                                            " PWD ${snapshot.data!.docs[index].data().password ?? ""}"),
                                      ],
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(snapshot.data!.docs[index]
                                                .data()
                                                .email ??
                                            ""),
                                        Text(snapshot.data!.docs[index]
                                                .data()
                                                .createdDate ??
                                            ""),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        ctrl.deleteUser(
                                            snapshot.data!.docs[index].id);
                                        // show toast flutter
                                        Fluttertoast.showToast(
                                            msg: "User deleted succesfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )),
                  ),
                  // add user
                  const Text("Add User"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 250,
                      width: Get.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 50,
                              width: Get.width,
                              child: TextField(
                                controller: ctrl.textCtrl.value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter name',
                                ),
                                onChanged: (v) {
                                  ctrl.name.value = v;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 50,
                              width: Get.width,
                              child: TextField(
                                controller: ctrl.textCtrl2.value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter email',
                                ),
                                onChanged: (v) {
                                  ctrl.email.value = v;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 50,
                              width: Get.width,
                              child: TextField(
                                controller: ctrl.textCtrl3.value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter passwd',
                                ),
                                onChanged: (v) {
                                  ctrl.pwd.value = v;
                                },
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await ctrl.addUser(context);
                              Get.back();
                            },
                            child: const Text("Add"),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
