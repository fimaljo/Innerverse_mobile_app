import 'package:freezed_annotation/freezed_annotation.dart';

part 'cloud_storage_failure.freezed.dart';

@freezed
class CloudStorageFailure with _$CloudStorageFailure {
  const factory CloudStorageFailure.serverError([String? message]) =
      ServerError;
  const factory CloudStorageFailure.networkError([String? message]) =
      NetworkError;
  const factory CloudStorageFailure.authenticationError([String? message]) =
      AuthenticationError;
  const factory CloudStorageFailure.permissionError([String? message]) =
      PermissionError;
  const factory CloudStorageFailure.quotaExceeded([String? message]) =
      QuotaExceeded;
  const factory CloudStorageFailure.fileNotFound([String? message]) =
      FileNotFound;
  const factory CloudStorageFailure.syncConflict([String? message]) =
      SyncConflict;
  const factory CloudStorageFailure.unknownError([String? message]) =
      UnknownError;
}
