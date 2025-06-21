import 'package:equatable/equatable.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';

abstract class EntriesEvent extends Equatable {
  const EntriesEvent();

  @override
  List<Object?> get props => [];
}

class LoadEntries extends EntriesEvent {
  const LoadEntries();
}

class SearchEntries extends EntriesEvent {
  const SearchEntries(this.query);
  final String query;

  @override
  List<Object?> get props => [query];
}

class RefreshEntries extends EntriesEvent {
  const RefreshEntries();
}

class UpdateEntry extends EntriesEvent {
  const UpdateEntry(this.entry);
  final Entry entry;

  @override
  List<Object?> get props => [entry];
}

class DeleteEntry extends EntriesEvent {
  const DeleteEntry(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}
