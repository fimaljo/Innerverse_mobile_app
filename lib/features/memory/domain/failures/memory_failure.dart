import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_failure.freezed.dart';

@freezed
class MemoryFailure with _$MemoryFailure {
  const factory MemoryFailure.unexpected() = _Unexpected;
  const factory MemoryFailure.notFound() = _NotFound;
  const factory MemoryFailure.invalidData() = _InvalidData;
  const factory MemoryFailure.storageError() = _StorageError;
}
