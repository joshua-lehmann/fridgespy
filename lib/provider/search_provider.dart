import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
class Search extends _$Search {
  @override
  String build() {
    return "";
  }

  void search(String searchValue) {
    state = searchValue;
  }
}
