

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:opinions/features/create_module/repository/post_repository_manager.dart';
import 'package:opinions/features/registration/view_model/provider/token_storage_provider.dart';

final postRepositoryManagerProvider = Provider<PostRepositoryManager>((ref){
  final client = http.Client();
  final tokenStorage = ref.read(tokenStorageProvider);

  return PostRepositoryManager(
      client: client,
      tokenStorage: tokenStorage
  );
});