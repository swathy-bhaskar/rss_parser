import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class RssItem {
  String title= ' ';
  String? description;
// Add other properties as needed


}


class RssController extends GetxController {
  final List<RssItem> rssItems = <RssItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRssData();
  }

  Future<void> fetchRssData() async {
    final url = 'https://anchor.fm/s/6c1d9dec/podcast/rss'; //  RSS feed URL
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final rssXml = xml.XmlDocument.parse(response.body);
      final channelTitle = rssXml.findAllElements('channel').first.findElements('title').single.text;
      print('Channel Title: $channelTitle');

      final items = rssXml.findAllElements('item');
      final parsedItems = items.map((item) {
        final rssItem = RssItem();
        rssItem.title = item.findElements('title').single.text;
        rssItem.description = item.findElements('description').single.text;
        // Set other properties
        return rssItem;
      }).toList();

      rssItems.assignAll(parsedItems);
    } else {
      print('Failed to fetch RSS data. Status code: ${response.statusCode}');
    }
  }
}
