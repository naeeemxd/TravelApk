import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          title: const Text(
            'Notification',
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Clear all',
                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(text: "Recent"),
              Tab(text: "Earlier"),
              Tab(text: "Archived"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NotificationList(),
            Center(child: Text('Earlier Notifications')),
            Center(child: Text('Archived Notifications')),
          ],
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  final List<Map<String, String>> notifications = const [
    {'title': 'Super Offer', 'subtitle': 'Get 60% off in our first booking', 'time': 'Sun, 12:40 PM'},
    {'title': 'Super Offer', 'subtitle': 'Get 60% off in our first booking', 'time': 'Mon, 11:50 PM'},
    {'title': 'Super Offer', 'subtitle': 'Get 60% off in our first booking', 'time': 'Tue, 10:56 PM'},
    {'title': 'Super Offer', 'subtitle': 'Get 60% off in our first booking', 'time': 'Wed, 12:40 PM'},
    {'title': 'Super Offer', 'subtitle': 'Get 60% off in our first booking', 'time': 'Fri, 11:50 PM'},
    {'title': 'Super Offer', 'subtitle': 'Get 60% off in our first booking', 'time': 'Sat, 10:56 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(Icons.person, size: 30, color: Colors.grey.shade700),
          ),
          title: Text(
            notification['title']!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(notification['subtitle']!),
          trailing: Text(
            notification['time']!,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        );
     },
);
}
}
