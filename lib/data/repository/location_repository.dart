import 'package:dio/dio.dart';
import 'package:regional_search/data/model/location.dart';
import 'package:regional_search/data/model/location.dart';

class LocationRepository {
  final Dio _dio = Dio();

  // 네이버 지역 검색 API 기본 URL
  final String _baseUrl = 'https://openapi.naver.com/v1/search/local.json';

  // 네이버 API 클라이언트 아이디
  final String clientId = 'GXD0lXDZvrrTIeIII4KZ';
  final String clientSecret = '9P41oXZFjO';

  Future<List<Location>> searchLocations(String query) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'query': query, 'display': 5},
        options: Options(
          headers: {
            'X-Naver-Client-Id': clientId,
            'X-Naver-Client-Secret': clientSecret,
          },
        ),
      );

      if (response.statusCode == 200) {
        final List results = response.data['items'];
        print("검색 결과: ${results.length}개 항목");
        return results.map((json) => Location.fromJson(json)).toList();
      } else {
        print("API 호출 실패: ${response.statusCode}");
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      print("예외 발생: $e");
      throw Exception('Failed to load locations');
    }
  }
}
