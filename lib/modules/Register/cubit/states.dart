abstract class RegisterStates {}

class RegisterIntialState extends RegisterStates {}

class RegisterLoadinState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {
  final String error;

  CreateUserErrorState(this.error);
}

class RegChangePasswordVisibilityState extends RegisterStates {}
