import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_team_manager/service/database.dart';

final databaseProvider = Provider((ref) => Database());
