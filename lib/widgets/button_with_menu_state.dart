import 'package:flutter/material.dart';

class ButtonWithMenu extends StatefulWidget {
  const ButtonWithMenu({super.key});

  @override
  State<ButtonWithMenu> createState() => _ButtonWithMenuState();
}

class _ButtonWithMenuState extends State<ButtonWithMenu> {
  String _selectedChoice = 'completed';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String choice) {
        setState(() {
          _selectedChoice = choice;
        });
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'completed',
            child: Text('Completed'),
          ),
          const PopupMenuItem<String>(
            value: 'in_progress',
            child: Text('In Progress'),
          ),
          const PopupMenuItem<String>(
            value: 'pending',
            child: Text('Pending'),
          ),
        ];
      },
      child: ElevatedButton(
        onPressed: () {},
        child: Text(_selectedChoice),
      ),
    );
  }
}
