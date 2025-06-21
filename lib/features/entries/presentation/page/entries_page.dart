import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/constants/emoji_options.dart';
import 'package:innerverse/core/navigation/route_constants.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_bloc.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_event.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_state.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:innerverse/shared/widgets/custome_text_field.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:rive/rive.dart' as rive;

class DateGroupedEntries {
  DateGroupedEntries({
    required this.date,
    required this.entries,
    required this.dateHeader,
    required this.monthHeader,
  });
  final DateTime date;
  final List<Entry> entries;
  final String dateHeader;
  final String monthHeader;
}

class EntriesPage extends StatefulWidget {
  const EntriesPage({super.key});

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();
  bool _isCalendarExpanded = false;
  bool _showCalendar = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<EntriesBloc>().add(const LoadEntries());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollPosition = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    // Show calendar when near top, hide when scrolling down
    if (scrollPosition > 50) {
      if (_showCalendar) {
        setState(() {
          _showCalendar = false;
        });
      }
    } else {
      if (!_showCalendar) {
        setState(() {
          _showCalendar = true;
        });
      }
    }
  }

  List<DateGroupedEntries> _groupEntriesByDate(List<Entry> entries) {
    // Sort entries by date (newest first)
    final sortedEntries = List<Entry>.from(entries)
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    final Map<String, List<Entry>> groupedMap = {};
    final Map<String, String> monthHeaders = {};

    for (final entry in sortedEntries) {
      final date = DateTime(
          entry.dateTime.year, entry.dateTime.month, entry.dateTime.day);
      final dateKey = date.toIso8601String().split('T')[0];

      if (!groupedMap.containsKey(dateKey)) {
        groupedMap[dateKey] = [];

        // Create month header
        final monthYear = DateFormat('MMMM yyyy').format(date);
        monthHeaders[dateKey] = monthYear;
      }

      groupedMap[dateKey]!.add(entry);
    }

    final List<DateGroupedEntries> groupedEntries = [];

    for (final entry in groupedMap.entries) {
      final date = DateTime.parse(entry.key);
      final dayOfWeek = DateFormat('EEEE').format(date);
      final dayOfMonth = date.day;
      final dateHeader = '$dayOfMonth $dayOfWeek';

      groupedEntries.add(DateGroupedEntries(
        date: date,
        entries: entry.value,
        dateHeader: dateHeader,
        monthHeader: monthHeaders[entry.key]!,
      ));
    }

    // Sort by date (newest first)
    groupedEntries.sort((a, b) => b.date.compareTo(a.date));

    return groupedEntries;
  }

  String _getMonthImageName(String monthHeader) {
    // Extract the month name from the header (e.g., "December 2024" -> "dec")
    final monthName = monthHeader.split(' ')[0].toLowerCase();

    // Map full month names to short names
    switch (monthName) {
      case 'january':
        return 'jan';
      case 'february':
        return 'feb';
      case 'march':
        return 'mar';
      case 'april':
        return 'apr';
      case 'may':
        return 'may';
      case 'june':
        return 'jun';
      case 'july':
        return 'jul';
      case 'august':
        return 'aug';
      case 'september':
        return 'sep';
      case 'october':
        return 'oct';
      case 'november':
        return 'nov';
      case 'december':
        return 'dec';
      default:
        return 'jan'; // fallback
    }
  }

  List<Color> _getMonthColor(String monthHeader) {
    // Extract the month name from the header (e.g., "December 2024" -> "dec")
    final monthName = monthHeader.split(' ')[0].toLowerCase();

    // Map full month names to gradient colors
    switch (monthName) {
      case 'january':
        return [const Color(0xFFE1BEE7), const Color(0xFFCE93D8)];
      case 'february':
        return [const Color(0xFFFFF3E0), const Color(0xFFFFE0B2)];
      case 'march':
        return [const Color(0xFFFFCC80), const Color(0xFFFFB74D)];
      case 'april':
        return [const Color(0xFFFFF9C4), const Color(0xFFFFF59D)];
      case 'may':
        return [const Color(0xFFC8E6C9), const Color(0xFFA5D6A7)];
      case 'june':
        return [const Color(0xFFB2DFDB), const Color(0xFF80CBC4)];
      case 'july':
        return [const Color(0xFFB3E5FC), const Color(0xFF81D4FA)];
      case 'august':
        return [const Color(0xFFC5CAE9), const Color(0xFF9FA8DA)];
      case 'september':
        return [const Color(0xFFD1C4E9), const Color(0xFFB39DDB)];
      case 'october':
        return [const Color(0xFFF8BBD9), const Color(0xFFF48FB1)];
      case 'november':
        return [const Color(0xFFFFCDD2), const Color(0xFFEF9A9A)];
      case 'december':
        return [const Color(0xFFE1BEE7), const Color(0xFFCE93D8)];
      default:
        return [const Color(0xFFE1BEE7), const Color(0xFFCE93D8)]; // fallback
    }
  }

  String _getDateNumber(String dateHeader) {
    // Extract the date number from "30 Friday" -> "30"
    return dateHeader.split(' ')[0];
  }

  String _getWeekName(String dateHeader) {
    // Extract the week name from "30 Friday" -> "Friday"
    return dateHeader.split(' ')[1];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final navBarHeight = screenHeight / 9;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: CustomeTextField(
            //     hintText: 'Search entries...',
            //     textColor: Colors.black,
            //     hintColor: Colors.grey,
            //     onChanged: (value) {
            //       context.read<EntriesBloc>().add(SearchEntries(value));
            //     },
            //   ),
            // ),
            // Calendar View
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: _showCalendar
                  ? AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _showCalendar ? 1.0 : 0.0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: _buildCalendarView(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: BlocBuilder<EntriesBloc, EntriesState>(
                builder: (context, state) {
                  if (state is EntriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is EntriesError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<EntriesBloc>()
                                  .add(const RefreshEntries());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is EntriesLoaded ||
                      state is EntryUpdating ||
                      state is EntryDeleting ||
                      state is EntryUpdated ||
                      state is EntryDeleted) {
                    final List<Entry> entries;
                    if (state is EntriesLoaded) {
                      entries = state.entries;
                    } else if (state is EntryUpdating) {
                      entries = state.entries;
                    } else if (state is EntryDeleting) {
                      entries = state.entries;
                    } else if (state is EntryUpdated) {
                      entries = state.entries;
                    } else if (state is EntryDeleted) {
                      entries = state.entries;
                    } else {
                      entries = [];
                    }

                    // Filter entries by selected date
                    final filteredEntries = entries.where((entry) {
                      final entryDate = DateTime(
                        entry.dateTime.year,
                        entry.dateTime.month,
                        entry.dateTime.day,
                      );
                      final selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        _selectedDate.day,
                      );
                      return entryDate.isAtSameMomentAs(selectedDate);
                    }).toList();

                    if (filteredEntries.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No entries for ${DateFormat('MMM dd, yyyy').format(_selectedDate)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Select a different date or create a new memory!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<EntriesBloc>().add(const RefreshEntries());
                      },
                      child: Builder(
                        builder: (context) {
                          final theme = Theme.of(context);
                          final colorScheme = theme.colorScheme;
                          final groupedEntries =
                              _groupEntriesByDate(filteredEntries);

                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: groupedEntries.length,
                            itemBuilder: (context, index) {
                              final entryGroup = groupedEntries[index];

                              // Check if we need to show month header
                              final showMonthHeader = index == 0 ||
                                  (index > 0 &&
                                      groupedEntries[index - 1].monthHeader !=
                                          entryGroup.monthHeader);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Month header
                                  if (showMonthHeader)
                                    AnimatedContainer(
                                      width: double.infinity,
                                      height: 80,
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 30),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: _getMonthColor(
                                              entryGroup.monthHeader),
                                        ),
                                      ),
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Text(
                                                entryGroup.monthHeader,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: ClipRRect(
                                              child: Image.asset(
                                                'assets/images/${_getMonthImageName(entryGroup.monthHeader)}.png',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: const Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  // Date header
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, top: 8, bottom: 8),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          // Date number - bigger font
                                          TextSpan(
                                            text: _getDateNumber(
                                                entryGroup.dateHeader),
                                            style: TextStyle(
                                              fontSize: 34,
                                              fontWeight: FontWeight.bold,
                                              color: colorScheme
                                                  .onPrimaryContainer,
                                            ),
                                          ),
                                          const TextSpan(text: ' '),
                                          // Week name - smaller font
                                          TextSpan(
                                            text: _getWeekName(
                                                entryGroup.dateHeader),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: colorScheme
                                                  .onPrimaryContainer
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Entries for this date
                                  ...entryGroup.entries
                                      .map((entry) => _EntryCard(entry: entry)),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const Center(
                    child: Text(
                      'No entries yet. Create your first memory!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AppPrimaryButton(
        height: 60,
        minWidth: 60,
        maxWidth: 60,
        radius: 30,
        gradientColors: const [Colors.blue, Colors.purple],
        onTap: () {
          context.pushNamed(RouteConstants.selectMemoryTypeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCalendarView() {
    return BlocBuilder<EntriesBloc, EntriesState>(
      builder: (context, state) {
        final List<Entry> entries = [];
        if (state is EntriesLoaded) {
          entries.addAll(state.entries);
        } else if (state is EntryUpdating) {
          entries.addAll(state.entries);
        } else if (state is EntryDeleting) {
          entries.addAll(state.entries);
        } else if (state is EntryUpdated) {
          entries.addAll(state.entries);
        } else if (state is EntryDeleted) {
          entries.addAll(state.entries);
        }

        // Get dates that have entries
        final entryDates = entries.map((entry) {
          final entryDate = DateTime(
            entry.dateTime.year,
            entry.dateTime.month,
            entry.dateTime.day,
          );
          return entryDate;
        }).toSet();

        return GestureDetector(
          onTap: () {
            setState(() {
              _isCalendarExpanded = !_isCalendarExpanded;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isCalendarExpanded
                ? _buildFullCalendar(entryDates)
                : _buildWeekView(entryDates),
          ),
        );
      },
    );
  }

  Widget _buildWeekView(Set<DateTime> entryDates) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Filter entries for current month only
    final currentMonthEntries = entryDates.where((date) {
      return date.year == _currentMonth.year &&
          date.month == _currentMonth.month;
    }).toSet();

    return Column(
      children: [
        // Week header with expand icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                DateFormat('MMMM yyyy').format(_currentMonth),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${currentMonthEntries.length} entries',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Weekday Headers
        Row(
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        // Current week view
        _buildCurrentWeekRow(currentMonthEntries, today),
      ],
    );
  }

  Widget _buildCurrentWeekRow(Set<DateTime> entryDates, DateTime today) {
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));

    return Row(
      children: List.generate(7, (index) {
        final date = startOfWeek.add(Duration(days: index));
        final isToday = date.isAtSameMomentAs(today);
        final isSelected = date.isAtSameMomentAs(
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day),
        );
        final hasEntry = entryDates.contains(date);

        return Expanded(
          child: Container(
            height: 32,
            margin: const EdgeInsets.all(1),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.blue
                    : hasEntry
                        ? Colors.blue.withOpacity(0.2)
                        : isToday
                            ? Colors.blue.withOpacity(0.1)
                            : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: isToday && !isSelected
                    ? Border.all(color: Colors.blue, width: 1.5)
                    : null,
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: hasEntry || isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? Colors.white
                        : hasEntry
                            ? Colors.blue
                            : isToday
                                ? Colors.blue
                                : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFullCalendar(Set<DateTime> entryDates) {
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Filter entries for current month only
    final currentMonthEntries = entryDates.where((date) {
      return date.year == _currentMonth.year &&
          date.month == _currentMonth.month;
    }).toSet();

    return Column(
      children: [
        // Month and Year Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                DateFormat('MMMM yyyy').format(_currentMonth),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _currentMonth = DateTime(
                        _currentMonth.year,
                        _currentMonth.month - 1,
                      );
                    });
                  },
                  icon: const Icon(Icons.chevron_left),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {
                    // Only allow navigation to current month or past months
                    final nextMonth = DateTime(
                      _currentMonth.year,
                      _currentMonth.month + 1,
                    );
                    if (nextMonth.isBefore(DateTime(now.year, now.month + 1))) {
                      setState(() {
                        _currentMonth = nextMonth;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: DateTime(_currentMonth.year, _currentMonth.month + 1)
                            .isAfter(DateTime(now.year, now.month + 1))
                        ? Colors.grey[400]
                        : Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.keyboard_arrow_up,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Weekday Headers
        Row(
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        // Calendar Grid
        ...List.generate(
          ((firstWeekday - 1 + daysInMonth) / 7).ceil(),
          (weekIndex) => Row(
            children: List.generate(7, (dayIndex) {
              final dayNumber =
                  weekIndex * 7 + dayIndex - (firstWeekday - 1) + 1;
              final isCurrentMonth = dayNumber > 0 && dayNumber <= daysInMonth;
              final currentDate =
                  DateTime(_currentMonth.year, _currentMonth.month, dayNumber);
              final isToday = currentDate.isAtSameMomentAs(today);
              final isSelected = currentDate.isAtSameMomentAs(
                DateTime(
                    _selectedDate.year, _selectedDate.month, _selectedDate.day),
              );
              final hasEntry =
                  isCurrentMonth && currentMonthEntries.contains(currentDate);
              final isFutureDate = currentDate.isAfter(today);

              return Expanded(
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(1),
                  child: isCurrentMonth
                      ? GestureDetector(
                          onTap: isFutureDate
                              ? null // Disable tap for future dates
                              : () {
                                  setState(() {
                                    _selectedDate = currentDate;
                                    _isCalendarExpanded =
                                        false; // Collapse calendar when date is selected
                                  });
                                },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue
                                  : hasEntry
                                      ? Colors.blue.withOpacity(0.2)
                                      : isToday
                                          ? Colors.blue.withOpacity(0.1)
                                          : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: isToday && !isSelected
                                  ? Border.all(color: Colors.blue, width: 2)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                dayNumber.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: hasEntry || isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isFutureDate
                                      ? Colors
                                          .grey[400] // Grey out future dates
                                      : isSelected
                                          ? Colors.white
                                          : hasEntry
                                              ? Colors.blue
                                              : isToday
                                                  ? Colors.blue
                                                  : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              );
            }),
          ),
        ),
        // Selected Date Info
        if (_selectedDate != null)
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Selected: ${DateFormat('MMM dd, yyyy').format(_selectedDate)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${currentMonthEntries.contains(DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)) ? "Has entries" : "No entries"}',
                  style: TextStyle(
                    fontSize: 12,
                    color: currentMonthEntries.contains(DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day))
                        ? Colors.green
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _EntryCard extends StatefulWidget {
  const _EntryCard({required this.entry});
  final Entry entry;

  @override
  State<_EntryCard> createState() => _EntryCardState();
}

class _EntryCardState extends State<_EntryCard> with TickerProviderStateMixin {
  bool _showIcons = true;

  void _showEditDialog(BuildContext context) {
    context.pushNamed(
      RouteConstants.editEntryName,
      extra: widget.entry,
    );
  }

  void _showDeleteConfirmation(BuildContext context, EntriesBloc entriesBloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Entry'),
          content: const Text(
            'Are you sure you want to delete this entry? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                entriesBloc.add(DeleteEntry(widget.entry.id));
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.entry.riveAsset; // fallback to avoid null
    final gradient = emojiOptions
        .firstWhere((option) => option.riveAsset == label,
            orElse: () => emojiOptions.first) // fallback if no match
        .gradient;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 12, top: 20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side - Emotion card
            Flexible(
              flex: 2,
              child: BlocBuilder<EntriesBloc, EntriesState>(
                builder: (context, state) {
                  final isUpdating = state is EntryUpdating;
                  final isDeleting = state is EntryDeleting;
                  return InkWell(
                    onTap: (isUpdating || isDeleting)
                        ? null
                        : () => _showOptionsBottomSheet(context),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: gradient,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 50,
                              child: Center(
                                child: Text(
                                  widget.entry.emotionSliderValue
                                      .toInt()
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 140,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        // First letter - current size
                                        TextSpan(
                                          text:
                                              widget.entry.emojiLabel.isNotEmpty
                                                  ? widget.entry.emojiLabel[0]
                                                  : '',
                                          style:
                                              textTheme.displayMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        // Remaining letters - smaller size
                                        TextSpan(
                                          text:
                                              widget.entry.emojiLabel.length > 1
                                                  ? widget.entry.emojiLabel
                                                      .substring(1)
                                                  : '',
                                          style:
                                              textTheme.displayMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: (textTheme.displayMedium
                                                        ?.fontSize ??
                                                    49.4) *
                                                0.6, // 60% of original size
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex:
                                      3, // Give even more space to the animation
                                  child: SizedBox(
                                    height:
                                        150, // Increase height significantly
                                    child: rive.RiveAnimation.asset(
                                      'assets/rive/innerverse3.riv',
                                      artboard:
                                          widget.entry.riveAsset ?? 'positive',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 10,
                              right: 20,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.entry.time.format(context),
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ),
                            // More vert icon positioned at the top right with higher z-index
                            Positioned(
                              top: 0,
                              right: 10,
                              bottom: 50,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Right side - Content and images
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  // Title and description container - only show if content exists
                  if ((widget.entry.title != null &&
                          widget.entry.title!.isNotEmpty) ||
                      (widget.entry.description != null &&
                          widget.entry.description!.isNotEmpty))
                    GestureDetector(
                      onTap: () => _showFullTextDialog(context,
                          widget.entry.title, widget.entry.description),
                      child: Container(
                        width: double.infinity, // Take full width
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: gradient,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.entry.title != null &&
                                widget.entry.title!.isNotEmpty)
                              Text(
                                widget.entry.title!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            if (widget.entry.description != null &&
                                widget.entry.description!.isNotEmpty)
                              Text(
                                widget.entry.description!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                          ],
                        ),
                      ),
                    ),
                  // Images container - only show if images or icons exist
                  if (widget.entry.images!.isNotEmpty ||
                      widget.entry.worldIcons.isNotEmpty)
                    Expanded(
                      child: Container(
                        width: double.infinity, // Take full width
                        margin: EdgeInsets.only(
                            top: (widget.entry.title != null &&
                                        widget.entry.title!.isNotEmpty) ||
                                    (widget.entry.description != null &&
                                        widget.entry.description!.isNotEmpty)
                                ? 10
                                : 0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: gradient,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          child: SizedBox.expand(
                            child: _showIcons
                                ? _buildIconsSection(widget.entry.worldIcons,
                                    widget.entry.images!)
                                : _buildImagesSection(
                                    widget.entry.images!,
                                    widget.entry.worldIcons,
                                  ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIconsSection(
      List<WorldIconModel> worldIcons, List<String> images) {
    if (worldIcons.isEmpty) return const SizedBox.shrink();

    // If there are no images, center the icons since no toggle button will be shown
    if (widget.entry.images!.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: worldIcons.map((worldIcon) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      worldIcon.icon,
                      color: Colors.white,
                      size: 100,
                    ),
                    Text(
                      worldIcon.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );
    }

    // If there are images, include the toggle button in the row
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Toggle button at the beginning of the row
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  _showIcons = !_showIcons;
                });
              },
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      '(${images.length})',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          ...worldIcons.map((worldIcon) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    worldIcon.icon,
                    color: Colors.white,
                    size: 100,
                  ),
                  Text(
                    worldIcon.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildImagesSection(
    List<String> images,
    List<WorldIconModel> worldIcons,
  ) {
    if (images.isEmpty) return const SizedBox.shrink();

    return Builder(
      builder: (context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Toggle button at the beginning of the row
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _showIcons = !_showIcons;
                  });
                },
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.public_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      Text(
                        '(${worldIcons.length})',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            ...images.map((imagePath) {
              return Container(
                width: 120,
                height: 120,
                margin: const EdgeInsets.only(right: 8, top: 8),
                child: GestureDetector(
                  onTap: () => _showImageFullScreen(context, imagePath),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        // Main image
                        Image.file(
                          File(imagePath),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.grey!, Colors.grey[400]!],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey[600],
                                size: 32,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showImageFullScreen(BuildContext context, String imagePath) {
    context.pushNamed(
      RouteConstants.entryImageViewerName,
      extra: imagePath,
    );
  }

  void _showFullTextDialog(
      BuildContext context, String? title, String? description) {
    context.pushNamed(
      RouteConstants.entryTextViewerName,
      extra: {
        'title': title,
        'description': description,
      },
    );
  }

  void _showOptionsBottomSheet(BuildContext context) {
    // Capture the EntriesBloc reference before showing the bottom sheet
    final entriesBloc = context.read<EntriesBloc>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StreamBuilder<EntriesState>(
          stream: entriesBloc.stream,
          initialData: entriesBloc.state,
          builder: (context, snapshot) {
            final state = snapshot.data;
            final isUpdating = state is EntryUpdating;
            final isDeleting = state is EntryDeleting;

            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(top: 12, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  ListTile(
                    leading: isUpdating
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.edit_outlined, color: Colors.grey),
                    title: Text(
                      isUpdating ? 'Updating...' : 'Edit',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: isUpdating || isDeleting
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            _showEditDialog(context);
                          },
                  ),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  ListTile(
                    leading: isDeleting
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.delete_outline, color: Colors.grey),
                    title: Text(
                      isDeleting ? 'Deleting...' : 'Delete',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: isUpdating || isDeleting
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            _showDeleteConfirmation(context, entriesBloc);
                          },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
