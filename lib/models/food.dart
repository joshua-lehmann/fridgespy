import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String id;
  final String name;
  final String description;
  final String? imagePath;
  final DateTime? expiryDate;

  const Food({
    required this.name,
    required this.description,
    this.imagePath,
    this.expiryDate,
    this.id = '',
  });

  factory Food.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) {
      throw ArgumentError('Firestore data cannot be null');
    }
    return Food(
        id: snapshot.id,
        name: data['name'],
        description: data['description'],
        expiryDate: data['expiryDate'].toDate());
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'expiryDate': expiryDate,
        'description': description,
      };
}
