class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$");
    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email address";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    if (value.trim().length < 2) {
      return "Enter a valid name";
    }
    return null;
  }

  static String? validateNotEmpty(String? value, [String message = "Required"]) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }
}
