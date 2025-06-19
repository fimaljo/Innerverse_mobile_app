import 'package:equatable/equatable.dart';

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
