import 'package:supabase_flutter_boilerplate/shared/config/supabase_config.dart';

class Profile {
  final String id;
  final String? username;
  final DateTime? updatedAt;

  Profile({
    required this.id,
    this.username,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      username: json['username'],
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Future<Profile?> getProfile() async {
    final response = await SupabaseConfig.client
        .from('profiles')
        .select()
        .eq('id', id)
        .maybeSingle();
    return response == null ? null : Profile.fromJson(response);
  }

  static Future<Profile> updateProfile({
    required String userId,
    String? username,
  }) async {
    try {
      final response = await SupabaseConfig.client
          .from('profiles')
          .update({
            'username': username,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();

      return Profile.fromJson(response);
    } catch (e) {
      print('Failed to update profile: $e');
      throw Exception('Failed to update profile: $e');
    }
  }
}
