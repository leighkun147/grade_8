import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../utils/error_handler.dart';

class CacheService {
  static const String _cacheDir = 'app_cache';
  static const Duration _defaultExpiry = Duration(days: 7);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$_cacheDir';
    await Directory(path).create(recursive: true);
    return path;
  }

  Future<File> _getFile(String key) async {
    final path = await _localPath;
    return File('$path/$key.cache');
  }

  Future<void> writeToCache<T>({
    required String key,
    required T data,
    Duration? expiry,
  }) async {
    try {
      final file = await _getFile(key);
      final cacheData = {
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
        'expiry': (expiry ?? _defaultExpiry).inMilliseconds,
      };
      await file.writeAsString(jsonEncode(cacheData));
    } catch (e, stackTrace) {
      throw AppError.unknown(e, stackTrace);
    }
  }

  Future<T?> readFromCache<T>({
    required String key,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final file = await _getFile(key);
      if (!await file.exists()) return null;

      final content = await file.readAsString();
      final cacheData = jsonDecode(content) as Map<String, dynamic>;

      final timestamp = DateTime.parse(cacheData['timestamp'] as String);
      final expiry = Duration(milliseconds: cacheData['expiry'] as int);
      final now = DateTime.now();

      if (now.difference(timestamp) > expiry) {
        await file.delete();
        return null;
      }

      final data = cacheData['data'] as Map<String, dynamic>;
      return fromJson(data);
    } catch (e, stackTrace) {
      throw AppError.unknown(e, stackTrace);
    }
  }

  Future<void> removeFromCache(String key) async {
    try {
      final file = await _getFile(key);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e, stackTrace) {
      throw AppError.unknown(e, stackTrace);
    }
  }

  Future<void> clearCache() async {
    try {
      final path = await _localPath;
      final dir = Directory(path);
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    } catch (e, stackTrace) {
      throw AppError.unknown(e, stackTrace);
    }
  }

  Future<int> getCacheSize() async {
    try {
      final path = await _localPath;
      final dir = Directory(path);
      if (!await dir.exists()) return 0;

      int size = 0;
      await for (final file in dir.list(recursive: true)) {
        if (file is File) {
          size += await file.length();
        }
      }
      return size;
    } catch (e, stackTrace) {
      throw AppError.unknown(e, stackTrace);
    }
  }

  Future<bool> isCached(String key) async {
    try {
      final file = await _getFile(key);
      return await file.exists();
    } catch (e, stackTrace) {
      throw AppError.unknown(e, stackTrace);
    }
  }
}
