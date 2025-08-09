import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/auth_service.dart';

/// 認証サービスのプロバイダー
final authServiceProvider = ChangeNotifierProvider<AuthService>((ref) {
  return AuthService();
});

/// 現在のユーザー情報プロバイダー
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authServiceProvider).currentUser;
});

/// ログイン状態プロバイダー
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(authServiceProvider).isLoggedIn;
});

/// ローディング状態プロバイダー
final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authServiceProvider).isLoading;
});