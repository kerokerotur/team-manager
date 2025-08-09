import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/auth/auth_header.dart';
import '../widgets/auth/login_form.dart';
import '../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  String? _errorMessage;

  Future<void> _handleLogin(String email, String password) async {
    setState(() {
      _errorMessage = null;
    });

    final authService = ref.read(authServiceProvider);
    final result = await authService.login(email, password);

    if (result.success) {
      // ログイン成功時はホーム画面に遷移
      if (mounted) {
        context.go('/');
      }
    } else {
      // エラーメッセージを表示
      setState(() {
        _errorMessage = result.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authLoadingProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // ヘッダー
              const AuthHeader(
                title: 'Team Manager',
                subtitle: 'チーム管理アプリにログイン',
                icon: Icon(
                  Icons.groups,
                  size: 64,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 48),
              // ログインフォーム
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: LoginForm(
                      onLogin: _handleLogin,
                      isLoading: isLoading,
                      errorMessage: _errorMessage,
                    ),
                  ),
                ),
              ),
              // テスト用アカウント情報
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'テスト用アカウント',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('メール: test@example.com'),
                    const Text('パスワード: password'),
                    const SizedBox(height: 4),
                    Text(
                      '※任意の有効なメールアドレス + 6文字以上のパスワードでもOK',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}