class Validators {
  static String? validateRequiredField({required String value}) {
    String? message;
    if (value.trim().isEmpty) {
      message = "Field is required";
    }
    return message;
  }

  static String? validateRequiredFieldWithLength({
    required String value,
    required int length,
  }) {
    value = value.trim();
    String? message;
    if (value.isEmpty) {
      message = "Field is required";
    } else if (value.length < length) {
      message = "Input too short";
    }
    return message;
  }

  static String? validateEmail({required String email}) {
    String? message;
    if (email.isEmpty == true) {
      message = 'Email is required';
    } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email.trim()) ==
        true) {
      message = "Invalid email";
    }
    return message;
  }

  static String? validatePasswordAndConfirmPassword({
    required String pwd,
    required String confPwd,
  }) {
    String? message;
    if (pwd.isEmpty) {
      message = 'Password is required';
      return message;
    }

    if (confPwd.isEmpty) {
      message = "Confirm password is required";
      return message;
    }
    if (pwd != confPwd) {
      message = "Passwords do not match";
      return message;
    }
    if (pwd.length < 8) {
      message = "Password must be at least 8 characters";
    }

    if (!RegExp(".*[0-9].*").hasMatch(pwd)) {
      message = 'Password must contain a number';
      return message;
    }
    if (!RegExp('.*[A-Z].*').hasMatch(pwd)) {
      message = 'Password must contain an upper case letter';
      return message;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pwd)) {
      message = 'Password must contain a special symbol eg. !@%';
      return message;
    }

    return message;
  }

  static String? validatePassword({
    required String pwd,
  }) {
    String? message;
    if (pwd.trim().isEmpty) {
      message = 'Password is required';
    }
    return message;
  }

  static String? validatePhoneNumber({required String phoneNumber}) {
    String? message;
    String patttern = r'(^(?:[+0]9)?[0-9]{10,16}$)';
    RegExp regExp = RegExp(patttern);
    if (phoneNumber.isEmpty || !regExp.hasMatch(phoneNumber)) {
      message = 'Invalid phone number';
    }
    return message;
  }
}
