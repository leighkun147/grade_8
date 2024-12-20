import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import '../../lib/services/cache_service.dart';

class MockPathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return '/mock/path';
  }
}

void main() {
  late CacheService cacheService;

  setUp(() {
    PathProviderPlatform.instance = MockPathProviderPlatform();
    cacheService = CacheService();
  });

  group('CacheService', () {
    test('writeToCache should store data with expiry', () async {
      const testData = {'test': 'data'};
      await cacheService.writeToCache(
        key: 'test_key',
        data: testData,
      );

      final result = await cacheService.readFromCache<Map<String, dynamic>>(
        key: 'test_key',
        fromJson: (json) => json,
      );

      expect(result, equals(testData));
    });

    test('readFromCache should return null for expired data', () async {
      const testData = {'test': 'data'};
      await cacheService.writeToCache(
        key: 'test_key',
        data: testData,
        expiry: const Duration(milliseconds: 1),
      );

      await Future.delayed(const Duration(milliseconds: 2));

      final result = await cacheService.readFromCache<Map<String, dynamic>>(
        key: 'test_key',
        fromJson: (json) => json,
      );

      expect(result, isNull);
    });

    test('removeFromCache should delete cached data', () async {
      const testData = {'test': 'data'};
      await cacheService.writeToCache(
        key: 'test_key',
        data: testData,
      );

      await cacheService.removeFromCache('test_key');

      final result = await cacheService.readFromCache<Map<String, dynamic>>(
        key: 'test_key',
        fromJson: (json) => json,
      );

      expect(result, isNull);
    });

    test('clearCache should remove all cached data', () async {
      const testData1 = {'test': 'data1'};
      const testData2 = {'test': 'data2'};

      await cacheService.writeToCache(
        key: 'test_key1',
        data: testData1,
      );
      await cacheService.writeToCache(
        key: 'test_key2',
        data: testData2,
      );

      await cacheService.clearCache();

      final result1 = await cacheService.readFromCache<Map<String, dynamic>>(
        key: 'test_key1',
        fromJson: (json) => json,
      );
      final result2 = await cacheService.readFromCache<Map<String, dynamic>>(
        key: 'test_key2',
        fromJson: (json) => json,
      );

      expect(result1, isNull);
      expect(result2, isNull);
    });

    test('isCached should return correct status', () async {
      const testData = {'test': 'data'};
      
      expect(await cacheService.isCached('test_key'), isFalse);

      await cacheService.writeToCache(
        key: 'test_key',
        data: testData,
      );

      expect(await cacheService.isCached('test_key'), isTrue);
    });
  });
}
