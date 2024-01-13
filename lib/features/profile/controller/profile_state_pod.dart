import 'package:edumarshal/features/profile/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileDataProvider = FutureProvider<ProfileData?>(
    (ref) async => await ref.read(profileRepositoryProvider).getProfileData());
