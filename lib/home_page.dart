import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regional_search/data/repository/location_repository.dart';
import 'package:regional_search/data/model/location.dart';
import 'package:regional_search/detail_page.dart';

// 위치 상태를 관리하는 StateNotifierProvider
final locationProvider =
    StateNotifierProvider<LocationNotifier, List<Location>>((ref) {
  return LocationNotifier(LocationRepository());
});

// 위치 상태를 관리하는 LocationNotifier 클래스
class LocationNotifier extends StateNotifier<List<Location>> {
  final LocationRepository _repository;
  LocationNotifier(this._repository) : super([]);

  // 검색어를 받아 위치를 검색하고 상태를 업데이트하는 메서드
  Future<void> search(String query) async {
    final locations = await _repository.searchLocations(query);
    state = locations;
  }
}

// HomePage 위젯 클래스
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 현재 위치 목록 상태를 감시
    final locations = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(hintText: '위치를 검색하세요'),
          onSubmitted: (query) {
            // 검색어 입력 후 검색 메서드 호출
            ref.read(locationProvider.notifier).search(query);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return ListTile(
            title: Text(location.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location.category),
                Text(location.roadAddress),
              ],
            ),
            onTap: () {
              // 리스트 아이템 클릭 시 DetailPage로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(link: location.link),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
