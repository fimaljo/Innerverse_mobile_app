import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/core/events/app_events.dart';
import 'package:innerverse/core/services/event_bus_service.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';
import 'package:innerverse/features/entries/domain/usecases/base_usecase.dart';
import 'package:innerverse/features/entries/domain/usecases/delete_entry_usecase.dart';
import 'package:innerverse/features/entries/domain/usecases/get_all_entries_usecase.dart';
import 'package:innerverse/features/entries/domain/usecases/search_entries_usecase.dart';
import 'package:innerverse/features/entries/domain/usecases/update_entry_usecase.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_event.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_state.dart';

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  EntriesBloc({
    required this.getAllEntriesUseCase,
    required this.searchEntriesUseCase,
    required this.updateEntryUseCase,
    required this.deleteEntryUseCase,
  }) : super(EntriesInitial()) {
    on<LoadEntries>(_onLoadEntries);
    on<SearchEntries>(_onSearchEntries);
    on<RefreshEntries>(_onRefreshEntries);
    on<UpdateEntry>(_onUpdateEntry);
    on<DeleteEntry>(_onDeleteEntry);

    // Listen to global events
    _setupEventListeners();
  }

  final GetAllEntriesUseCase getAllEntriesUseCase;
  final SearchEntriesUseCase searchEntriesUseCase;
  final UpdateEntryUseCase updateEntryUseCase;
  final DeleteEntryUseCase deleteEntryUseCase;
  final EventBusService _eventBus = EventBusService();
  late StreamSubscription<AppEvent> _eventSubscription;

  void _setupEventListeners() {
    _eventSubscription = _eventBus.stream.listen((event) {
      if (event is MemoryCreatedEvent ||
          event is MemoryUpdatedEvent ||
          event is MemoryDeletedEvent ||
          event is RefreshEntriesEvent) {
        // Refresh entries when any memory operation occurs
        add(const RefreshEntries());
      }
    });
  }

  @override
  Future<void> close() {
    _eventSubscription.cancel();
    return super.close();
  }

  Future<void> _onLoadEntries(
      LoadEntries event, Emitter<EntriesState> emit) async {
    print('=== LOADING ENTRIES ===');
    emit(EntriesLoading());

    final result = await getAllEntriesUseCase(const NoParams());

    result.fold(
      (failure) {
        print('❌ Load entries failed: ${failure.toString()}');
        emit(EntriesError(
          failure: failure,
          message: _getErrorMessage(failure),
        ));
      },
      (entries) {
        print('✅ Loaded ${entries.length} entries from storage');

        // Sort entries by date and time (newest first)
        final sortedEntries = List<Entry>.from(entries);
        sortedEntries.sort((a, b) {
          // First compare by date
          final dateComparison = b.dateTime.compareTo(a.dateTime);
          if (dateComparison != 0) {
            return dateComparison;
          }
          // If same date, compare by time
          final aMinutes = a.time.hour * 60 + a.time.minute;
          final bMinutes = b.time.hour * 60 + b.time.minute;
          return bMinutes.compareTo(aMinutes);
        });

        print('📋 Sorted entry details:');
        for (final entry in sortedEntries) {
          print('  - ID: ${entry.id}');
          print('    Title: "${entry.title}"');
          print('    Description: "${entry.description}"');
          print('    DateTime: ${entry.dateTime}');
          print(
              '    Time: ${entry.time.hour}:${entry.time.minute.toString().padLeft(2, '0')}');
          print('    Emoji: ${entry.emojiLabel}');
          print('    World Icons: ${entry.worldIcons.length}');
          print('    Images: ${entry.images?.length ?? 0}');
          print('    ---');
        }
        emit(EntriesLoaded(entries: sortedEntries));
      },
    );
  }

  Future<void> _onSearchEntries(
      SearchEntries event, Emitter<EntriesState> emit) async {
    if (event.query.isEmpty) {
      add(const LoadEntries());
      return;
    }

    emit(EntriesLoading());

    final result = await searchEntriesUseCase(SearchEntriesParams(event.query));

    result.fold(
      (failure) => emit(EntriesError(
        failure: failure,
        message: _getErrorMessage(failure),
      )),
      (entries) {
        // Sort search results by date and time (newest first)
        final sortedEntries = List<Entry>.from(entries);
        sortedEntries.sort((a, b) {
          // First compare by date
          final dateComparison = b.dateTime.compareTo(a.dateTime);
          if (dateComparison != 0) {
            return dateComparison;
          }
          // If same date, compare by time
          final aMinutes = a.time.hour * 60 + a.time.minute;
          final bMinutes = b.time.hour * 60 + b.time.minute;
          return bMinutes.compareTo(aMinutes);
        });

        emit(EntriesLoaded(
          entries: sortedEntries,
          searchQuery: event.query,
        ));
      },
    );
  }

  Future<void> _onRefreshEntries(
      RefreshEntries event, Emitter<EntriesState> emit) async {
    add(const LoadEntries());
  }

  Future<void> _onUpdateEntry(
      UpdateEntry event, Emitter<EntriesState> emit) async {
    print('=== UPDATING ENTRY ===');
    print('📝 Entry to update:');
    print('  - ID: ${event.entry.id}');
    print('  - Title: "${event.entry.title}"');
    print('  - Description: "${event.entry.description}"');
    print('  - DateTime: ${event.entry.dateTime}');
    print('  - Emoji: ${event.entry.emojiLabel}');
    print('  - World Icons: ${event.entry.worldIcons.length}');
    print('  - Images: ${event.entry.images?.length ?? 0}');

    // Get current state
    final currentState = state;
    if (currentState is EntriesLoaded) {
      emit(EntryUpdating(
        entries: currentState.entries,
        searchQuery: currentState.searchQuery,
      ));

      final result = await updateEntryUseCase(UpdateEntryParams(event.entry));

      result.fold(
        (failure) {
          print('❌ Update entry failed: ${failure.toString()}');
          emit(EntriesError(
            failure: failure,
            message: _getErrorMessage(failure),
          ));
        },
        (_) {
          print('✅ Update entry successful for ID: ${event.entry.id}');
          // Update the entry in the list
          final updatedEntries = currentState.entries.map((entry) {
            return entry.id == event.entry.id ? event.entry : entry;
          }).toList();

          // Sort the updated entries by date and time (newest first)
          updatedEntries.sort((a, b) {
            // First compare by date
            final dateComparison = b.dateTime.compareTo(a.dateTime);
            if (dateComparison != 0) {
              return dateComparison;
            }
            // If same date, compare by time
            final aMinutes = a.time.hour * 60 + a.time.minute;
            final bMinutes = b.time.hour * 60 + b.time.minute;
            return bMinutes.compareTo(aMinutes);
          });

          print('🔄 Updated entries list:');
          for (final entry in updatedEntries) {
            print('  - ID: ${entry.id}, Title: "${entry.title}"');
          }

          emit(EntryUpdated(
            entries: updatedEntries,
            searchQuery: currentState.searchQuery,
          ));

          // Emit global event
          print('📡 Emitting MemoryUpdatedEvent');
          _eventBus.emit(const MemoryUpdatedEvent());
        },
      );
    } else {
      print('❌ Cannot update entry: Invalid state - ${state.runtimeType}');
    }
  }

  Future<void> _onDeleteEntry(
      DeleteEntry event, Emitter<EntriesState> emit) async {
    // Get current state
    final currentState = state;
    if (currentState is EntriesLoaded) {
      emit(EntryDeleting(
        entries: currentState.entries,
        searchQuery: currentState.searchQuery,
      ));

      final result = await deleteEntryUseCase(DeleteEntryParams(event.id));

      result.fold(
        (failure) => emit(EntriesError(
          failure: failure,
          message: _getErrorMessage(failure),
        )),
        (_) {
          // Remove the entry from the list
          final updatedEntries = currentState.entries
              .where((entry) => entry.id != event.id)
              .toList();

          // Sort the remaining entries by date and time (newest first)
          updatedEntries.sort((a, b) {
            // First compare by date
            final dateComparison = b.dateTime.compareTo(a.dateTime);
            if (dateComparison != 0) {
              return dateComparison;
            }
            // If same date, compare by time
            final aMinutes = a.time.hour * 60 + a.time.minute;
            final bMinutes = b.time.hour * 60 + b.time.minute;
            return bMinutes.compareTo(aMinutes);
          });

          emit(EntryDeleted(
            entries: updatedEntries,
            searchQuery: currentState.searchQuery,
          ));

          // Emit global event
          _eventBus.emit(const MemoryDeletedEvent());
        },
      );
    }
  }

  String _getErrorMessage(EntriesFailure failure) {
    return failure.when(
      unexpected: () => 'An unexpected error occurred',
      notFound: () => 'Entries not found',
      invalidData: () => 'Invalid data',
      storageError: () => 'Storage error occurred',
    );
  }
}
