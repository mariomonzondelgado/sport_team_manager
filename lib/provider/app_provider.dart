import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_team_manager/service/storage_service.dart';

final isAdminProvider = Provider((ref) => true);

final fbStorageProvider = Provider((ref) => FirebaseStorageService());
