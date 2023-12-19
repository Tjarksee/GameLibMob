import 'package:flutter/material.dart';

class ButtonWithMenu extends StatefulWidget {
  @override
  _ButtonWithMenuState createState() => _ButtonWithMenuState();
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
          PopupMenuItem<String>(
            value: 'completed',
            child: Text('Completed'),
          ),
          PopupMenuItem<String>(
            value: 'in_progress',
            child: Text('In Progress'),
          ),
          PopupMenuItem<String>(
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
