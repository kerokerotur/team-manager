import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> setupFirebaseCloudMessaging() async {
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onMessage.listen((message) => {});

  // 一斉送信用のトピックをサブスクライブする
  FirebaseMessaging.instance.subscribeToTopic('all');
  // トピックの解除
  // FirebaseMessaging.instance.unsubscribeFromTopic('topic/all');

  FirebaseMessaging.instance.getToken().then(
        (token) => {
          print("===================TOKEN=================="),
          print(token),
          print("===================TOKEN==================")
        },
      );
}
