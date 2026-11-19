


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:opinions/features/home%20screen/repository/all_posts_repository.dart';

final allPostsRepositoryProvider = Provider((ref) {
  return AllPostsRepository(client: http.Client());
});