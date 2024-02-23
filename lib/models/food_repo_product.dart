class FoodRepoProduct {
  final int id;
  final String barcode;
  final String displayNameDe;
  final String displayNameEn;
  final String? frontImageUrl;

  FoodRepoProduct({
    required this.id,
    required this.barcode,
    required this.displayNameDe,
    required this.displayNameEn,
    this.frontImageUrl,
  });

  factory FoodRepoProduct.fromJson(Map<String, dynamic> json) {
    final data = json['data'][0] as Map<String, dynamic>;
    final images = data['images'] as List<dynamic>;
    String? frontImageUrl; // Declare as nullable

    // Try to find a front image, but it's okay if we don't find one
    final frontImage = images.firstWhere(
      (image) => (image['categories'] as List<dynamic>).contains('Front'),
      orElse: () => images.isNotEmpty
          ? images.first
          : null, // Take the first image if no 'Front' category image is found
    );

    if (frontImage != null) {
      frontImageUrl = frontImage['thumb'] as String?;
    }

    return FoodRepoProduct(
      id: data['id'],
      barcode: data['barcode'],
      displayNameDe: data['display_name_translations']['de'],
      displayNameEn: data['display_name_translations']['en'],
      frontImageUrl: frontImageUrl,
    );
  }
}
