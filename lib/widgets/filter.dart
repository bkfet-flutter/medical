import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  String _selectedOption = 'All'; // Default selected option

  void _showFilterMenu(BuildContext context) async {
    final selectedOption = await showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(0, 100, 0, 0),
      items: <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'All',
          child: Text('All'),
        ),
        const PopupMenuItem<String>(
          value: 'Option 1',
          child: Text('Option 1'),
        ),
        const PopupMenuItem<String>(
          value: 'Option 2',
          child: Text('Option 2'),
        ),
        const PopupMenuItem<String>(
          value: 'Option 3',
          child: Text('Option 3'),
        ),
      ],
    );

    if (selectedOption != null) {
      setState(() {
        _selectedOption = selectedOption;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Filter Menu Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showFilterMenu(context);
          },
          child: const Text('Show Filter Menu'),
        ),
      ),
    );
  }
}
