import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter_boilerplate/shared/validators/user_validator.dart';

void main() {
  group('Password Validation Tests', () {
    test('empty password returns error message', () {
      expect(validatePassword(''), 'Password is required');
      expect(validatePassword(null), 'Password is required');
    });

    test('password length less than 8 returns error message', () {
      expect(validatePassword('Abc1!'),
          'Password must be at least 8 characters long');
    });

    test('password without uppercase returns error message', () {
      expect(validatePassword('abc123!@#'),
          'Password must contain at least one uppercase letter');
    });

    test('password without lowercase returns error message', () {
      expect(validatePassword('ABC123!@#'),
          'Password must contain at least one lowercase letter');
    });

    test('password without numbers returns error message', () {
      expect(validatePassword('AbcDef!@#'),
          'Password must contain at least one number');
    });

    test('password without special characters returns error message', () {
      expect(validatePassword('Abcd1234'),
          'Password must contain at least one special character');
    });

    test('valid password returns null', () {
      expect(validatePassword('Abcd123!@#'), null);
    });
  });

  group('Email Validation Tests', () {
    test('empty email returns error message', () {
      expect(validateEmail(''), 'Email is required');
      expect(validateEmail(null), 'Email is required');
    });

    test('invalid email format returns error message', () {
      expect(
          validateEmail('invalid.email'), 'Please enter a valid email address');
      expect(validateEmail('invalid@'), 'Please enter a valid email address');
      expect(
          validateEmail('@domain.com'), 'Please enter a valid email address');
      expect(validateEmail('invalid@domain'),
          'Please enter a valid email address');
    });

    test('valid email returns null', () {
      expect(validateEmail('test@example.com'), null);
      expect(validateEmail('user.name@domain.co.uk'), null);
      expect(validateEmail('user+label@domain.com'), null);
    });
  });
}
