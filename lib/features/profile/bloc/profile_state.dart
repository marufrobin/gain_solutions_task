part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserProfileModel? profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

final class ProfileLoading extends ProfileState {}

final class ProfileError extends ProfileState {
  final String? message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
