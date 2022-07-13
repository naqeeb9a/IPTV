import 'package:http/http.dart' as http;
import 'package:m3u_nullsafe/m3u_nullsafe.dart';

class Api {
  static Future<List<M3uGenericEntry>> loadChannels(link) async {
    var response = await http
        .get(Uri.parse(link));
    final List<M3uGenericEntry> m3u = await M3uParser.parse(response.body);
    return m3u;
  }
}
