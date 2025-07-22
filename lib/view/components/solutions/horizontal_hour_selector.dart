import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/primary.dart';

class HorizontalHourSelector extends StatefulWidget {
  final DateTime initialDate;
  final Function(int) onHourSelected;

  const HorizontalHourSelector({
    super.key,
    required this.initialDate,
    required this.onHourSelected,
  });

  @override
  _HorizontalHourSelectorState createState() => _HorizontalHourSelectorState();
}

class _HorizontalHourSelectorState extends State<HorizontalHourSelector> {
  final List<String> hours =
      List.generate(24, (i) => '${i.toString().padLeft(2, '0')}:00');
  late PageController _pageController;
  int _selectedIndex = 0;

  final double itemFraction = 1 / 5;

  @override
  void initState() {
    super.initState();
    // Set initial index based on the provided initialDate
    _selectedIndex = widget.initialDate.hour;

    _pageController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: itemFraction,
    );

    _pageController.addListener(() {
      int newIndex = (_pageController.page ?? 0).round();
      if (_selectedIndex != newIndex) {
        setState(() => _selectedIndex = newIndex);
        widget.onHourSelected(
          int.parse(hours[newIndex].split(':')[0]),
        );
      }
    });
  }

  void _onItemTap(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget _buildItem(int index) {
    final isCentered = index == _selectedIndex;

    return GestureDetector(
      onTap: () => _onItemTap(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        alignment: Alignment.center,
        child: Text(
          hours[index],
          style: TextStyle(
            fontSize: 18,
            fontWeight: isCentered ? FontWeight.bold : FontWeight.normal,
            color: isCentered
                ? Primary.normal
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width * itemFraction;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 80,
          child: PageView.builder(
            controller: _pageController,
            itemCount: hours.length,
            physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
            itemBuilder: (context, index) => SizedBox(
              width: itemWidth,
              child: _buildItem(index),
            ),
          ),
        ),
        // Center overlay "lens"
        IgnorePointer(
          child: Container(
            height: 60,
            width: itemWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Primary.lightest2,
            ),
          ),
        ),
      ],
    );
  }
}
