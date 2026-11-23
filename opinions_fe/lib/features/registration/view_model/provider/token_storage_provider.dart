
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opinions/features/registration/repository/services/token_storge_service.dart';

final tokenStorageProvider = Provider<TokenStorgeService>((ref){
  return TokenStorgeService();
});