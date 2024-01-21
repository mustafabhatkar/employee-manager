import 'package:employee_manager/ui/widgets/date_picker/header.dart';
import 'package:employee_manager/ui/widgets/date_picker/month_picker/month_view.dart';
import 'package:flutter/material.dart';

class MonthPicker extends StatefulWidget {
  MonthPicker({
    super.key,
    required this.minDate,
    required this.maxDate,
    this.initialDate,
    this.currentDate,
    this.selectedDate,
    this.enabledCellsTextStyle,
    this.enabledCellsDecoration = const BoxDecoration(),
    this.disbaledCellsTextStyle,
    this.disbaledCellsDecoration = const BoxDecoration(),
    this.currentDateTextStyle,
    this.currentDateDecoration,
    this.selectedCellTextStyle,
    this.selectedCellDecoration,
    this.onLeadingDateTap,
    this.onDateSelected,
    this.leadingDateTextStyle,
    this.slidersColor,
    this.slidersSize,
    this.highlightColor,
    this.splashColor,
    this.splashRadius,
  }) {
    assert(!minDate.isAfter(maxDate), "minDate can't be after maxDate");

    assert(
      () {
        if (initialDate == null) return true;
        final init =
            DateTime(initialDate!.year, initialDate!.month, initialDate!.day);

        final min = DateTime(minDate.year, minDate.month, minDate.day);

        return init.isAfter(min) || init.isAtSameMomentAs(min);
      }(),
      'initialDate $initialDate must be on or after minDate $minDate.',
    );
    assert(
      () {
        if (initialDate == null) return true;
        final init =
            DateTime(initialDate!.year, initialDate!.month, initialDate!.day);

        final max = DateTime(maxDate.year, maxDate.month, maxDate.day);
        return init.isBefore(max) || init.isAtSameMomentAs(max);
      }(),
      'initialDate $initialDate must be on or before maxDate $maxDate.',
    );
  }

  final DateTime? initialDate;

  final DateTime? currentDate;

  final DateTime? selectedDate;

  final ValueChanged<DateTime>? onDateSelected;

  final DateTime minDate;

  final DateTime maxDate;

  final VoidCallback? onLeadingDateTap;

  final TextStyle? enabledCellsTextStyle;

  final BoxDecoration enabledCellsDecoration;

  final TextStyle? disbaledCellsTextStyle;

  final BoxDecoration disbaledCellsDecoration;

  final TextStyle? currentDateTextStyle;

  final BoxDecoration? currentDateDecoration;

  final TextStyle? selectedCellTextStyle;

  final BoxDecoration? selectedCellDecoration;

  final TextStyle? leadingDateTextStyle;

  final Color? slidersColor;

  final double? slidersSize;

  final Color? splashColor;

  final Color? highlightColor;

  final double? splashRadius;

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  DateTime? _displayedYear;
  DateTime? _selectedDate;

  final GlobalKey _pageViewKey = GlobalKey();
  late final PageController _pageController;

  int get yearsCount => (widget.maxDate.year - widget.minDate.year) + 1;

  @override
  void initState() {
    _displayedYear = DateUtils.dateOnly(widget.initialDate ?? DateTime.now());
    _selectedDate = widget.selectedDate != null
        ? DateUtils.dateOnly(widget.selectedDate!)
        : null;
    _pageController = PageController(
      initialPage: (_displayedYear!.year - widget.minDate.year),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MonthPicker oldWidget) {
    // there is no need to check for the displayed month because it changes via
    // page view and not the initial date.
    // but for makeing debuging easy, we will navigate to the initial date again
    // if it changes.
    if (oldWidget.initialDate != widget.initialDate) {
      _displayedYear = DateUtils.dateOnly(widget.initialDate ?? DateTime.now());
      _pageController.jumpToPage(_displayedYear!.year - widget.minDate.year);
    }

    if (oldWidget.selectedDate != _selectedDate) {
      _selectedDate = widget.selectedDate != null
          ? DateUtils.dateOnly(widget.selectedDate!)
          : null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    //
    //! enabled
    //
    //

    final TextStyle enabledCellsTextStyle = widget.enabledCellsTextStyle ??
        textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface,
        );

    final BoxDecoration enabledCellsDecoration = widget.enabledCellsDecoration;

    //
    //! disabled
    //
    //

    final TextStyle disbaledCellsTextStyle = widget.disbaledCellsTextStyle ??
        textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface.withOpacity(0.30),
        );

    final BoxDecoration disbaledCellsDecoration =
        widget.disbaledCellsDecoration;

    //
    //! current
    //
    //

    final TextStyle currentDateTextStyle = widget.currentDateTextStyle ??
        textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: colorScheme.primary,
        );

    final BoxDecoration currentDateDecoration = widget.currentDateDecoration ??
        BoxDecoration(
          border: Border.all(color: colorScheme.primary),
          shape: BoxShape.circle,
        );

    //
    //! selected.
    //
    //

    final TextStyle selectedCellTextStyle = widget.selectedCellTextStyle ??
        textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: colorScheme.onPrimary,
        );

    final BoxDecoration selectedCellDecoration =
        widget.selectedCellDecoration ??
            BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            );

    //
    //
    //
    //! header
    final leadingDateTextStyle = widget.leadingDateTextStyle ??
        TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        );

    final slidersColor =
        widget.slidersColor ?? Theme.of(context).colorScheme.primary;

    final slidersSize = widget.slidersSize ?? 20;

    //
    //! splash
    final splashColor = widget.splashColor ??
        selectedCellDecoration.color?.withOpacity(0.3) ??
        colorScheme.primary.withOpacity(0.3);

    final highlightColor =
        widget.highlightColor ?? Theme.of(context).highlightColor;
    //
    //

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Header(
          leadingDateTextStyle: leadingDateTextStyle,
          slidersColor: slidersColor,
          slidersSize: slidersSize,
          onDateTap: () => widget.onLeadingDateTap?.call(),
          displayedDate: _displayedYear!.year.toString(),
          onNextPage: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          onPreviousPage: () {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
        const SizedBox(height: 10),
        SizedBox(
          key: const ValueKey<double>(78 * 4),
          height: 78 * 4,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            key: _pageViewKey,
            controller: _pageController,
            itemCount: yearsCount,
            onPageChanged: (yearPage) {
              final DateTime year = DateTime(
                widget.minDate.year + yearPage,
                widget.minDate.month,
                widget.minDate.day,
              );

              setState(() {
                _displayedYear = year;
              });
            },
            itemBuilder: (context, index) {
              final DateTime year = DateTime(
                widget.minDate.year + index,
                widget.minDate.month,
                widget.minDate.day,
              );

              return MonthView(
                key: ValueKey<DateTime>(year),
                currentDate:
                    DateUtils.dateOnly(widget.currentDate ?? DateTime.now()),
                maxDate: DateUtils.dateOnly(widget.maxDate),
                minDate: DateUtils.dateOnly(widget.minDate),
                displayedDate: year,
                selectedDate: _selectedDate,
                enabledCellsDecoration: enabledCellsDecoration,
                enabledCellsTextStyle: enabledCellsTextStyle,
                disbaledCellsDecoration: disbaledCellsDecoration,
                disbaledCellsTextStyle: disbaledCellsTextStyle,
                currentDateDecoration: currentDateDecoration,
                currentDateTextStyle: currentDateTextStyle,
                selectedCellDecoration: selectedCellDecoration,
                selectedCellTextStyle: selectedCellTextStyle,
                highlightColor: highlightColor,
                splashColor: splashColor,
                splashRadius: widget.splashRadius,
                onChanged: (value) {
                  widget.onDateSelected?.call(value);
                  setState(() {
                    _selectedDate = value;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
