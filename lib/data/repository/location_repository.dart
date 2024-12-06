import 'package:dio/dio.dart';
import 'package:regional_search/data/model/location.dart';

// 네이버 API를 이용한 위치 검색을 담당하는 리포지토리 클래스
class LocationRepository {
  // Dio 객체 생성
  final Dio _dio = Dio();

  // 네이버 지역 검색 API 기본 URL
  final String _baseUrl = 'https://openapi.naver.com/v1/search/local.json';

  // 네이버 API 클라이언트 아이디
  final String clientId = 'GXD0lXDZvrrTIeIII4KZ';

  // 네이버 API 클라이언트 시크릿
  final String clientSecret = '9P41oXZFjO';

  // 검색어를 받아 위치 목록을 반환하는 메서드
  Future<List<Location>> searchLocations(String query) async {
    // API 호출
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {'query': query, 'display': 5},
      options: Options(
        headers: {
          'GXD0lXDZvrrTIeIII4KZ': clientId,
          '9P41oXZFjO': clientSecret,
        },
      ),
    );

    // 호출이 성공했을 때
    if (response.statusCode == 200) {
      // 응답 데이터 중 'items' 리스트를 가져옴
      final List results = response.data['items'];
      // 각 아이템을 Location 객체로 변환하여 리스트로 반환
      return results.map((json) => Location.fromJson(json)).toList();
    } else {
      // 호출 실패 시 예외 발생
      throw Exception('Failed to load locations');
    }
  }
}
