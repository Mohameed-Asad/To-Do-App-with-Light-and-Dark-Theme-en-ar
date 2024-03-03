import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/date_time.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/core/services/snakebar_service.dart';

class FirebaseUtils {
  Future<bool> signIn(String emailAddress, String password) async {
    EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarService.showFailedMsg("No user found for that email");
      } else if (e.code == 'wrong-password') {
        SnackBarService.showFailedMsg("Wrong password provided for that user.");
      }
      return Future.value(false);
    }
  }

  Future<bool> createNewAccount(String emailAddress, String password) async {
    EasyLoading.show();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.dismiss();
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.dismiss();
        SnackBarService.showFailedMsg(
            "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
    return Future.value(false);
  }

  CollectionReference<TaskModel> getCollectionRef() {
    var db = FirebaseFirestore.instance;
    return db.collection("Task_Model").withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  Future<void> createNewTask(TaskModel task) {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  Stream<QuerySnapshot<TaskModel>> streamGetData(DateTime time) {
    var collectionRef = getCollectionRef()
        .where("date", isEqualTo: extractDateTime(time).microsecondsSinceEpoch);
    return collectionRef.snapshots();
  }

  Future<void> deleteTask(TaskModel task) {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(task.id);
    return docRef.delete();
  }

  Future<void> updateTask(TaskModel task) {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(task.id);
    return docRef.update({"isDone": true});
  }
}
