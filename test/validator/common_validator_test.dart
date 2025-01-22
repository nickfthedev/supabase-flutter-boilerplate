import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter_boilerplate/shared/validators/common_validator.dart';

void main() {
  group('Common Validator Tests', () {
    test('validateIsNotEmpty returns error for empty string', () {
      expect(validateIsNotEmpty(''), 'This field is required');
    });

    test('validateIsNotEmpty returns error for null', () {
      expect(validateIsNotEmpty(null), 'This field is required');
    });

    test('validateIsNotEmpty returns null for non-empty string', () {
      expect(validateIsNotEmpty('test'), null);
    });
  });
}
