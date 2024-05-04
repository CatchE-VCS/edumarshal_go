import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/wwhd_repository.dart';

final overallDataStatsPod = FutureProvider.autoDispose<Map<String, dynamic>>(
    (ref) async =>
        ref.watch(whatWeHaveDoneRepositoryProvider).getWhatWeHaveDoneOverall());

final individualDataStatsPod = FutureProvider.autoDispose<Map<String, dynamic>>(
    (ref) async =>
        ref.watch(whatWeHaveDoneRepositoryProvider).getWhatWeHaveDoneForYou());
