import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter_boilerplate/features/profile/profile_model.dart';

final profileProvider =
    FutureProvider.autoDispose.family<Profile?, String>((ref, userId) async {
  try {
    final response = await Profile(id: userId).getProfile();
    return response;
  } catch (e) {
    print('Failed to fetch profile: $e');
    throw Exception('Failed to fetch profile: $e');
  }
});
