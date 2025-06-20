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
  final String query;

  const SearchEntries(this.query);

  @override
  List<Object?> get props => [query];
}

class RefreshEntries extends EntriesEvent {
  const RefreshEntries();
}

class UpdateEntry extends EntriesEvent {
  final Entry entry;

  const UpdateEntry(this.entry);

  @override
  List<Object?> get props => [entry];
}

class DeleteEntry extends EntriesEvent {
  final String id;

  const DeleteEntry(this.id);

  @override
  List<Object?> get props => [id];
}
