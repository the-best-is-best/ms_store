class LoginRequests {
  LoginRequests(this.email, this.password);

  final String email;
  final String password;
}

class LoginBySocialRequests {
  final String email;
  final String userName;
  final String tokenSocial;
  final int loginBySocial;

  LoginBySocialRequests({
    required this.email,
    required this.userName,
    required this.tokenSocial,
    required this.loginBySocial,
  });
}

class RegisterRequests {
  final String email;
  final String password;
  final String userName;
  RegisterRequests({
    required this.email,
    required this.password,
    required this.userName,
  });
}

class ActiveEmailRequests {
  final String email;
  final String pin;

  ActiveEmailRequests({
    required this.email,
    required this.pin,
  });
}

class DeleteUserRequests {
  DeleteUserRequests(this.userId);

  final int userId;
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

class UpdateUserRequests {
  final int id;
  final String password;
  final String userName;
  final String phone;
  final int phoneVerify;

  UpdateUserRequests({
    required this.id,
    required this.userName,
    required this.phoneVerify,
    required this.password,
    required this.phone,
  });
}
