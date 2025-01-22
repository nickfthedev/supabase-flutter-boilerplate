// Password Validator
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }

  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
  bool hasLowerCase = value.contains(RegExp(r'[a-z]'));
  bool hasDigits = value.contains(RegExp(r'[0-9]'));
  bool hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  if (!hasUpperCase) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!hasLowerCase) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!hasDigits) {
    return 'Password must contain at least one number';
  }
  if (!hasSpecialCharacters) {
    return 'Password must contain at least one special character';
  }

  return null;
}

// Email Validator
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      .hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}
