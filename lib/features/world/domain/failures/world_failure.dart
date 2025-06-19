import 'package:freezed_annotation/freezed_annotation.dart';

part 'world_failure.freezed.dart';

@freezed
class WorldFailure with _$WorldFailure {
  const factory WorldFailure.unexpected() = _Unexpected;
  const factory WorldFailure.notFound() = _NotFound;
  const factory WorldFailure.invalidData() = _InvalidData;
  const factory WorldFailure.storageError() = _StorageError;
}
