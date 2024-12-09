import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// 위치 세부 정보를 보여주는 DetailPage 위젯 클래스
class DetailPage extends StatelessWidget {
  final String link;

  DetailPage({required this.link});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('위치 세부 정보'),
      ),
      body: InAppWebView(
        // 초기 URL을 설정하여 WebView 로드
        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(link))),
      ),
    );
  }
}
