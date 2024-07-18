import 'package:flutter/material.dart';

enum GroupedListOrder { ASC, DESC }

@immutable
class SliverGroupedListView<T, E> extends StatefulWidget {
  const SliverGroupedListView({
    super.key,
    required this.elements,
    required this.groupBy,
    required this.groupSeparatorBuilder,
    required this.itemBuilder,
    this.groupComparator,
    this.itemComparator,
    this.order = GroupedListOrder.ASC,
    this.sort = true,
    this.separator = const SizedBox.shrink(),
    this.footer,
    required this.groupTotalCalculator,
  });

  final List<T> elements;
  final E Function(T element) groupBy;
  final Widget Function(E value, double groupTotal) groupSeparatorBuilder;
  final Widget Function(BuildContext context, T element) itemBuilder;
  final int Function(E value1, E value2)? groupComparator;
  final int Function(T element1, T element2)? itemComparator;
  final GroupedListOrder order;
  final bool sort;
  final Widget separator;
  final Widget? footer;
  final double Function(List<T> groupElements) groupTotalCalculator;

  @override
  State<SliverGroupedListView<T, E>> createState() =>
      _SliverGroupedListViewState<T, E>();
}

class _SliverGroupedListViewState<T, E>
    extends State<SliverGroupedListView<T, E>> {
  late List<T> _sortedElements;
  late Map<E, List<T>> _groupedElements;

  @override
  void initState() {
    super.initState();
    _sortAndGroupElements();
  }

  @override
  void didUpdateWidget(SliverGroupedListView<T, E> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.elements != widget.elements) {
      _sortAndGroupElements();
    }
  }

  void _sortAndGroupElements() {
    _sortedElements = _sortElements();
    _groupedElements = _groupElements(_sortedElements);
  }

  List<T> _sortElements() {
    var elements = List<T>.from(widget.elements);
    if (widget.sort && elements.isNotEmpty) {
      elements.sort((e1, e2) {
        int? compareResult;
        if (widget.groupComparator != null) {
          compareResult =
              widget.groupComparator!(widget.groupBy(e1), widget.groupBy(e2));
        } else if (widget.groupBy(e1) is Comparable) {
          compareResult = (widget.groupBy(e1) as Comparable)
              .compareTo(widget.groupBy(e2) as Comparable);
        }
        if (compareResult == null || compareResult == 0) {
          if (widget.itemComparator != null) {
            compareResult = widget.itemComparator!(e1, e2);
          } else if (e1 is Comparable) {
            compareResult = e1.compareTo(e2);
          }
        }
        return compareResult ?? 0;
      });
      if (widget.order == GroupedListOrder.DESC) {
        elements = elements.reversed.toList();
      }
    }
    return elements;
  }

  Map<E, List<T>> _groupElements(List<T> elements) {
    return groupBy(elements, (T element) => widget.groupBy(element));
  }

  Widget _buildGroupSeparator(E group) {
    final groupElements = _groupedElements[group] ?? [];
    final groupTotal = widget.groupTotalCalculator(groupElements);
    return widget.groupSeparatorBuilder(group, groupTotal);
  }

  @override
  Widget build(BuildContext context) {
    // Recalculate grouped elements on every build
    _sortAndGroupElements();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index.isEven) {
            final actualIndex = index ~/ 2;
            if (actualIndex >= _sortedElements.length) {
              return widget.footer;
            }
            final group = widget.groupBy(_sortedElements[actualIndex]);
            if (actualIndex == 0 ||
                group != widget.groupBy(_sortedElements[actualIndex - 1])) {
              return _buildGroupSeparator(group);
            }
            return widget.separator;
          } else {
            return widget.itemBuilder(context, _sortedElements[index ~/ 2]);
          }
        },
        childCount:
            _sortedElements.length * 2 + (widget.footer == null ? 0 : 1),
      ),
    );
  }
}

// Helper function to group list elements
Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
  var map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}
