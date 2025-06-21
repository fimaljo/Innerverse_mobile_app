import 'package:equatable/equatable.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';

abstract class EntriesState extends Equatable {
  const EntriesState();

  @override
  List<Object?> get props => [];
}

class EntriesInitial extends EntriesState {}

class EntriesLoading extends EntriesState {}

class EntriesLoaded extends EntriesState {
  const EntriesLoaded({
    required this.entries,
    this.searchQuery,
  });
  final List<Entry> entries;
  final String? searchQuery;

  @override
  List<Object?> get props => [entries, searchQuery];

  EntriesLoaded copyWith({
    List<Entry>? entries,
    String? searchQuery,
  }) {
    return EntriesLoaded(
      entries: entries ?? this.entries,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class EntryUpdating extends EntriesState {
  const EntryUpdating({
    required this.entries,
    this.searchQuery,
  });
  final List<Entry> entries;
  final String? searchQuery;

  @override
  List<Object?> get props => [entries, searchQuery];
}

class EntryDeleting extends EntriesState {
  const EntryDeleting({
    required this.entries,
    this.searchQuery,
  });
  final List<Entry> entries;
  final String? searchQuery;

  @override
  List<Object?> get props => [entries, searchQuery];
}

class EntryUpdated extends EntriesState {
  const EntryUpdated({
    required this.entries,
    this.searchQuery,
  });
  final List<Entry> entries;
  final String? searchQuery;

  @override
  List<Object?> get props => [entries, searchQuery];
}

class EntryDeleted extends EntriesState {
  const EntryDeleted({
    required this.entries,
    this.searchQuery,
  });
  final List<Entry> entries;
  final String? searchQuery;

  @override
  List<Object?> get props => [entries, searchQuery];
}

class EntriesError extends EntriesState {
  const EntriesError({
    required this.failure,
    required this.message,
  });
  final EntriesFailure failure;
  final String message;

  @override
  List<Object?> get props => [failure, message];
}
