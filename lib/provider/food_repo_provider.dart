import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/food_repo_product.dart';

// Necessary for code-generation to work
part 'food_repo_provider.g.dart';

@riverpod
Future<FoodRepoProduct?> foodRepoProduct(
    FoodRepoProductRef ref, String? barcode) async {
  if (barcode == null || barcode.isEmpty) {
    return Future.value(null);
  }
  final queryParams = {"excludes": "nutrients", "barcodes": barcode};
  final response = await http.get(
    Uri.https('www.foodrepo.org', '/api/v3/products', queryParams),
    headers: <String, String>{
      'Authorization': 'Bearer ${dotenv.env['FOOD_REPO_TOKEN']}',
    },
  );
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return FoodRepoProduct.fromJson(json);
}
