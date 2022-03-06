import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_team_manager/service/database.dart';
import 'package:sport_team_manager/service/storage_service.dart';

final databaseProvider = Provider((ref) => Database());
final storageServiceProvider = Provider((ref) => StorageService());
