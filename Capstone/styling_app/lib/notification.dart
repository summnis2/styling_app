import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

void initNotification() async {
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('mipmap/ic_launcher');

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await notifications.initialize(
    initializationSettings,
    //onSelectNotification: =>드롭박스 클릭하면 어플로 들어갈 수 있도록 구성해도 좋을듯
  );
}

showNotification() async {
  tz.initializeTimeZones();
  var androidDetails = const AndroidNotificationDetails(
    'my_id',
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
  );
  notifications.zonedSchedule(
      2,
      '오늘 뭐 입지?',
      '오늘의 코디를 확인 해보세요!',
      makeDate(15, 35, 0),
      NotificationDetails(
        android: androidDetails,
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

makeDate(hour, min, sec) {
  var now = tz.TZDateTime.now(tz.local);
  var when =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, min, sec);
  if (when.isBefore(now)) {
    return when.add(Duration(days: 1));
  } else {
    return when;
  }
}
