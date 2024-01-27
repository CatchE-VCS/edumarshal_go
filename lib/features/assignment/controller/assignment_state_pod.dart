import 'package:edumarshal/features/assignment/model/assignment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/assignment_repository.dart';

final assignmentDataProvider =
    FutureProvider.autoDispose<List<AssignmentModel>?>((ref) async {
  final response = await ref.read(assignmentRepositoryProvider).getData();
  return response;
});
