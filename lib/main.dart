import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rss_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RssController rssController = Get.put(RssController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RSS Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('RSS Reader'),
        ),
        body: Obx(
              () {
            if (rssController.rssItems.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: rssController.rssItems.length,
                itemBuilder: (context, index) {
                  final item = rssController.rssItems[index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.description ?? 'No description available'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
