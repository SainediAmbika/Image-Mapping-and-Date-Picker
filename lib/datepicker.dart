import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class DatePicker extends StatefulWidget {
//   @override
//   _DatePickerState createState() => _DatePickerState();
// }

// class _DatePickerState extends State<DatePicker> {
//   String? selectedDropdownValue =
//       'Show Date Picker'; // Change the type to String?

//   DateTime selectedDate = DateTime.now();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Date Picker Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             DropdownButton<String>(
//               value: selectedDropdownValue,
//               onChanged: (String? newValue) {
//                 // Change the parameter type to String?
//                 setState(() {
//                   selectedDropdownValue = newValue;
//                   if (newValue == 'Show Date Picker') {
//                     _selectDate(context);
//                   }
//                 });
//               },
//               items: <String>[
//                 'Show Date Picker',
//                 'Option 1',
//                 'Option 2',
//                 'Option 3'
//               ].map<DropdownMenuItem<String>>(
//                 (String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 },
//               ).toList(),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String? selectedDropdownValue = 'Show Date Picker'; // Change the type to String?

  DateTime selectedDate = DateTime.now();
  bool isPopupVisible = false;

  void _togglePopup() {
    setState(() {
      isPopupVisible = !isPopupVisible;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker Example'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  value: selectedDropdownValue,
                  onChanged: (String? newValue) {
                    // Change the parameter type to String?
                    setState(() {
                      selectedDropdownValue = newValue;
                      if (newValue == 'Show Date Picker') {
                        _togglePopup();
                      } else {
                        _togglePopup();
                      }
                    });
                  },
                  items: <String>[
                    'Show Date Picker',
                    'Option 1',
                    'Option 2',
                    'Option 3',
                  ].map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          if (isPopupVisible)
            Positioned(
              top: 5,
              right: 20,
              child: Container(
                color: Colors.grey.shade100,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'This is a popup at the top right corner.',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text('Select Date'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
