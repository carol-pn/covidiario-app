import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// For changing the language
// import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';

class DateTimeForm extends StatefulWidget {
  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<DateTimeForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BasicDateTimeField(),
          SizedBox(height: 24),
          SizedBox(height: 24),
          SizedBox(height: 24),
          RaisedButton(
            child: Text('Save'),
            onPressed: () => formKey.currentState.save(),
          ),
          RaisedButton(
            child: Text('Reset'),
            onPressed: () => formKey.currentState.reset(),
          ),
          RaisedButton(
            child: Text('Validate'),
            onPressed: () => formKey.currentState.validate(),
          ),
        ],
      ),
    );
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900, color: Colors.grey),
        decoration: InputDecoration(
          hintText: 'Horario de Saida',
          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          fillColor: Colors.white,
        ),
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },

      ),
    ]);
  }
}
