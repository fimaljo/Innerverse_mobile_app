import 'package:equatable/equatable.dart';

/// Global application events for cross-feature communication
abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

/// Event emitted when a memory is successfully created
class MemoryCreatedEvent extends AppEvent {
  const MemoryCreatedEvent();
}

/// Event emitted when a memory is updated
class MemoryUpdatedEvent extends AppEvent {
  const MemoryUpdatedEvent();
}

/// Event emitted when a memory is deleted
class MemoryDeletedEvent extends AppEvent {
  const MemoryDeletedEvent();
}

/// Event emitted when entries should be refreshed
class RefreshEntriesEvent extends AppEvent {
  const RefreshEntriesEvent();
}
