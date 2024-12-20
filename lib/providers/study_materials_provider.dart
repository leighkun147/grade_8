import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyMaterial {
  final String id;
  final String title;
  final String subject;
  final String type;
  final String filePath;
  final int size;
  final DateTime uploadDate;
  final bool isDownloaded;

  StudyMaterial({
    required this.id,
    required this.title,
    required this.subject,
    required this.type,
    required this.filePath,
    required this.size,
    required this.uploadDate,
    this.isDownloaded = false,
  });

  StudyMaterial copyWith({
    String? title,
    String? subject,
    String? type,
    String? filePath,
    int? size,
    DateTime? uploadDate,
    bool? isDownloaded,
  }) {
    return StudyMaterial(
      id: id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      type: type ?? this.type,
      filePath: filePath ?? this.filePath,
      size: size ?? this.size,
      uploadDate: uploadDate ?? this.uploadDate,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }
}

final studyMaterialsProvider =
    StateNotifierProvider<StudyMaterialsNotifier, List<StudyMaterial>>((ref) {
  return StudyMaterialsNotifier();
});

class StudyMaterialsNotifier extends StateNotifier<List<StudyMaterial>> {
  StudyMaterialsNotifier() : super([]) {
    _loadMaterials();
  }

  Future<void> _loadMaterials() async {
    // TODO: Load materials from local storage or API
    state = _getMockMaterials();
  }

  List<StudyMaterial> _getMockMaterials() {
    return [
      StudyMaterial(
        id: '1',
        title: 'Algebra Basics',
        subject: 'Mathematics',
        type: 'PDF',
        filePath: 'assets/materials/algebra_basics.pdf',
        size: 2500000, // 2.5 MB
        uploadDate: DateTime.now(),
      ),
      StudyMaterial(
        id: '2',
        title: 'Chemistry Experiments',
        subject: 'Science',
        type: 'Video',
        filePath: 'assets/materials/chemistry_experiments.mp4',
        size: 65000000, // 65 MB
        uploadDate: DateTime.now(),
      ),
      // Add more materials...
    ];
  }

  List<StudyMaterial> getMaterialsBySubject(String subject) {
    return state.where((material) => material.subject == subject).toList();
  }

  List<StudyMaterial> searchMaterials(String query) {
    return state.where((material) =>
        material.title.toLowerCase().contains(query.toLowerCase()) ||
        material.subject.toLowerCase().contains(query.toLowerCase())).toList();
  }

  Future<void> toggleDownloadStatus(String materialId) async {
    state = state.map((material) {
      if (material.id == materialId) {
        return material.copyWith(isDownloaded: !material.isDownloaded);
      }
      return material;
    }).toList();
  }

  Future<void> addMaterial(StudyMaterial material) async {
    state = [...state, material];
  }

  Future<void> removeMaterial(String materialId) async {
    state = state.where((material) => material.id != materialId).toList();
  }
}

// Provider for downloaded materials
final downloadedMaterialsProvider = Provider<List<StudyMaterial>>((ref) {
  final materials = ref.watch(studyMaterialsProvider);
  return materials.where((material) => material.isDownloaded).toList();
});

// Provider for material download progress
final downloadProgressProvider =
    StateNotifierProvider<DownloadProgressNotifier, Map<String, double>>((ref) {
  return DownloadProgressNotifier();
});

class DownloadProgressNotifier extends StateNotifier<Map<String, double>> {
  DownloadProgressNotifier() : super({});

  void updateProgress(String materialId, double progress) {
    state = {...state, materialId: progress};
  }

  void completeDownload(String materialId) {
    final newState = Map<String, double>.from(state);
    newState.remove(materialId);
    state = newState;
  }

  double getProgress(String materialId) {
    return state[materialId] ?? 0.0;
  }
}

// Provider for recently viewed materials
final recentMaterialsProvider =
    StateNotifierProvider<RecentMaterialsNotifier, List<String>>((ref) {
  return RecentMaterialsNotifier();
});

class RecentMaterialsNotifier extends StateNotifier<List<String>> {
  RecentMaterialsNotifier() : super([]);
  static const int maxRecentItems = 10;

  void addRecentMaterial(String materialId) {
    state = [
      materialId,
      ...state.where((id) => id != materialId),
    ].take(maxRecentItems).toList();
  }

  void clearRecentMaterials() {
    state = [];
  }
}
