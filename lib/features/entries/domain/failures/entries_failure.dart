import 'package:freezed_annotation/freezed_annotation.dart';

part 'entries_failure.freezed.dart';

@freezed
class EntriesFailure with _$EntriesFailure {
  const factory EntriesFailure.unexpected() = _Unexpected;
  const factory EntriesFailure.notFound() = _NotFound;
  const factory EntriesFailure.invalidData() = _InvalidData;
  const factory EntriesFailure.storageError() = _StorageError;
}
