import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      state = User.fromJson(Map<String, dynamic>.from(
        // ignore: unnecessary_cast
        jsonDecode(userData) as Map,
      ));
    }
  }

  Future<void> updateUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
    state = user;
  }

  Future<void> updateProgress(String subject, double progress) async {
    if (state == null) return;
    
    final updatedProgress = Map<String, double>.from(state!.subjectProgress);
    updatedProgress[subject] = progress;
    
    final updatedUser = state!.copyWith(subjectProgress: updatedProgress);
    await updateUser(updatedUser);
  }

  Future<void> addCoins(int amount) async {
    if (state == null) return;
    
    final updatedUser = state!.copyWith(coins: state!.coins + amount);
    await updateUser(updatedUser);
  }

  Future<void> levelUp() async {
    if (state == null) return;
    
    final updatedUser = state!.copyWith(level: state!.level + 1);
    await updateUser(updatedUser);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    state = null;
  }
}
