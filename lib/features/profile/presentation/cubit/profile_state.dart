class ProfileState {}
class ProfileInitial extends ProfileState {}
class ProfileUpdating extends ProfileState {}
class ProfileUpdated extends ProfileState {}
class ProfileUpdateError extends ProfileState {
  final String message;
  ProfileUpdateError(this.message);
}
class PasswordChanged extends ProfileState {}
class PasswordChanging extends ProfileState {}
class PasswordChangedError extends ProfileState {
  final String message;
  PasswordChangedError(this.message);
}
class PasswordVisibilityChanged extends ProfileState {}