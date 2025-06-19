import 'package:equatable/equatable.dart';

abstract class CloudStorageEvent extends Equatable {
  const CloudStorageEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticateRequested extends CloudStorageEvent {
  const AuthenticateRequested();
}

class SignOutRequested extends CloudStorageEvent {
  const SignOutRequested();
}

class PerformFullSyncRequested extends CloudStorageEvent {
  const PerformFullSyncRequested();
}

class UploadHiveBoxRequested extends CloudStorageEvent {
  const UploadHiveBoxRequested({
    required this.boxName,
    required this.data,
  });

  final String boxName;
  final List<int> data;

  @override
  List<Object?> get props => [boxName, data];
}

class CheckAuthenticationStatus extends CloudStorageEvent {
  const CheckAuthenticationStatus();
}
