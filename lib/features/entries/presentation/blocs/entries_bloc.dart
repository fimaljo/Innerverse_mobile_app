import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/core/events/app_events.dart';
import 'package:innerverse/core/services/event_bus_service.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';
import 'package:innerverse/features/entries/domain/usecases/base_usecase.dart';
import 'package:innerverse/features/entries/domain/usecases/get_all_entries_usecase.dart';
import 'package:innerverse/features/entries/domain/usecases/search_entries_usecase.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_event.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_state.dart';

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  EntriesBloc({
    required this.getAllEntriesUseCase,
    required this.searchEntriesUseCase,
  }) : super(EntriesInitial()) {
    on<LoadEntries>(_onLoadEntries);
    on<SearchEntries>(_onSearchEntries);
    on<RefreshEntries>(_onRefreshEntries);

    // Listen to global events
    _setupEventListeners();
  }
  final GetAllEntriesUseCase getAllEntriesUseCase;
  final SearchEntriesUseCase searchEntriesUseCase;
  final EventBusService _eventBus = EventBusService();
  late StreamSubscription<AppEvent> _eventSubscription;

  void _setupEventListeners() {
    _eventSubscription = _eventBus.stream.listen((event) {
      if (event is MemoryCreatedEvent ||
          event is MemoryUpdatedEvent ||
          event is MemoryDeletedEvent) {
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
    emit(EntriesLoading());

    final result = await getAllEntriesUseCase(const NoParams());

    result.fold(
      (failure) => emit(EntriesError(
        failure: failure,
        message: _getErrorMessage(failure),
      )),
      (entries) => emit(EntriesLoaded(entries: entries)),
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
      (entries) => emit(EntriesLoaded(
        entries: entries,
        searchQuery: event.query,
      )),
    );
  }

  Future<void> _onRefreshEntries(
      RefreshEntries event, Emitter<EntriesState> emit) async {
    add(const LoadEntries());
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
