import 'package:flutter/foundation.dart';

/// 認証結果
class AuthResult {
  final bool success;
  final String? error;
  final User? user;

  const AuthResult({
    required this.success,
    this.error,
    this.user,
  });

  AuthResult.success(this.user)
      : success = true,
        error = null;

  AuthResult.failure(this.error)
      : success = false,
        user = null;
}

/// ユーザー情報
class User {
  final String id;
  final String email;
  final String name;

  const User({
    required this.id,
    required this.email,
    required this.name,
  });
}

/// モック認証サービス
class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;

  /// モックログイン処理
  Future<AuthResult> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // モック処理：2秒の遅延
    await Future.delayed(const Duration(seconds: 2));

    try {
      // モック認証ロジック
      if (_isValidCredentials(email, password)) {
        _currentUser = User(
          id: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          name: _extractNameFromEmail(email),
        );
        _isLoading = false;
        notifyListeners();
        return AuthResult.success(_currentUser);
      } else {
        _isLoading = false;
        notifyListeners();
        return AuthResult.failure('メールアドレスまたはパスワードが正しくありません');
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return AuthResult.failure('ログインに失敗しました: $e');
    }
  }

  /// ログアウト処理
  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();
  }

  /// モック認証チェック（簡単な条件）
  bool _isValidCredentials(String email, String password) {
    // テスト用アカウント
    if (email == 'test@example.com' && password == 'password') {
      return true;
    }
    // 任意の有効なメールアドレス + 6文字以上のパスワードでOK
    return RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email) && 
           password.length >= 6;
  }

  /// メールアドレスから名前を抽出（モック用）
  String _extractNameFromEmail(String email) {
    final username = email.split('@')[0];
    return username.replaceAll('.', ' ').replaceAll('_', ' ');
  }
}