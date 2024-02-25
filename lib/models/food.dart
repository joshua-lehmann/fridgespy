import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String id;
  final String name;
  final String description;
  final String? imagePath;
  final DateTime expiryDate;
  final String? barcode;

  const Food({
    required this.name,
    required this.description,
    this.imagePath,
    required this.expiryDate,
    this.id = '',
    this.barcode,
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
        expiryDate: data['expiryDate'].toDate(),
        imagePath: data['imagePath'],
        barcode: data['barcode']);
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'description': description,
        'expiryDate': expiryDate,
        "imagePath": imagePath,
        "barcode": barcode,
      };
}
