import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseAPI {
  FirebaseApp? app;
  FirebaseFirestore? firestore;
  static final DatabaseAPI instance = DatabaseAPI();

  Future<void> initialize() async {
    app = await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCGekdY8ZwDLJ1_IyghTuqkPo6t8nvxRsQ",
        appId: "1:230452191551:web:9460182892b9bc1048b38a",
        messagingSenderId: "230452191551",
        projectId: "frc-scouting-testing",
        storageBucket: "frc-scouting-testing.appspot.com",
      ),
    );

    firestore = FirebaseFirestore.instanceFor(app: app!);
  }

  Future<void> uploadJson(Map<String, dynamic> jsonData, String collectionPath,
      String documentId) async {
    if (firestore == null) {
      throw Exception("Firebase not initialized");
    }

    try {
      await firestore!.collection(collectionPath).doc(documentId).set(jsonData);
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> downloadJson(
      String collectionPath, String documentId) async {
    if (firestore == null) {
      throw Exception("Firebase not initialized");
    }

    try {
      DocumentSnapshot docSnapshot =
          await firestore!.collection(collectionPath).doc(documentId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception("No data found at the specified document.");
      }
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}
