class Food {
  final String id;
  final String name;
  final String description;
  final String? imagePath;
  final DateTime? expiryDate;

  const Food({
    required this.id,
    required this.name,
    required this.description,
    this.imagePath,
    this.expiryDate,
  });

  factory Food.fromFirestore(Map<String, dynamic> firestore) => Food(
      id: firestore['id'],
      name: firestore['name'],
      description: firestore['description'],
      expiryDate: firestore['expiryDate'].toDate());

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'expiryDate': expiryDate,
        'description': description,
      };
}
