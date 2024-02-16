import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  late FirebaseFirestore firestore;

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal() {
    firestore = FirebaseFirestore.instance;
  }

// Define your Firebase methods here
}
