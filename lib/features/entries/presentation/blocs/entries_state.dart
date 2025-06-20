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
  final List<Entry> entries;
  final String? searchQuery;

  const EntriesLoaded({
    required this.entries,
    this.searchQuery,
  });

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
  final List<Entry> entries;
  final String? searchQuery;

  const EntryUpdating({
    required this.entries,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [entries, searchQuery];
}

class EntryDeleting extends EntriesState {
  final List<Entry> entries;
  final String? searchQuery;

  const EntryDeleting({
    required this.entries,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [entries, searchQuery];
}

class EntryUpdated extends EntriesState {
  final List<Entry> entries;
  final String? searchQuery;

  const EntryUpdated({
    required this.entries,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [entries, searchQuery];
}

class EntryDeleted extends EntriesState {
  final List<Entry> entries;
  final String? searchQuery;

  const EntryDeleted({
    required this.entries,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [entries, searchQuery];
}

class EntriesError extends EntriesState {
  final EntriesFailure failure;
  final String message;

  const EntriesError({
    required this.failure,
    required this.message,
  });

  @override
  List<Object?> get props => [failure, message];
}
