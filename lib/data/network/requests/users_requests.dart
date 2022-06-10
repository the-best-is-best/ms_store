class LoginRequests {
  LoginRequests(this.email, this.password);

  final String email;
  final String password;
}

class RegisterRequests {
  RegisterRequests({
    required this.email,
    required this.password,
    required this.userName,
  });

  final String email;
  final String password;
  final String userName;
}

class ActiveEmailRequests {
  final String email;
  final String pin;

  ActiveEmailRequests({
    required this.email,
    required this.pin,
  });
}

class ForgetPasswordRequests {
  ForgetPasswordRequests(this.email);

  final String email;
}

class ResetPasswordRequests {
  ResetPasswordRequests(
      {required this.pin, required this.password, required this.email});

  final String email;
  final String password;
  final String pin;
}
