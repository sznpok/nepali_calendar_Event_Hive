import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';

class AddEventCard extends StatefulWidget {
  @override
  State<AddEventCard> createState() => _AddEventCardState();
}

class _AddEventCardState extends State<AddEventCard> {
  bool valuefirst = false;
  Color currentColor = Colors.blue;
  Color pickerColor = Colors.blue;
  void changeColor(Color color) => setState(() => pickerColor = color);

  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  @override
  void initState() {
    dateController.text =
        NepaliDateFormat.yMMMMEEEEd().format(NepaliDateTime.now());
    startTimeController.text =
        NepaliDateFormat.jm().parseAndFormat(NepaliDateTime.now().toString());
    endTimeController.text =
        NepaliDateFormat.jm().parseAndFormat(NepaliDateTime.now().toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create an Event',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    isDense: true,
                    hintText: 'Title',
                    suffixIcon: Icon(
                      Icons.title,
                    )),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Text(
                    'Color',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              'Select a color',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Container(
                              child: BlockPicker(
                                pickerColor: pickerColor,
                                onColorChanged: changeColor,
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.end,
                            actionsPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            actions: [
                              MaterialButton(
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              MaterialButton(
                                child: const Text(
                                  'Got it',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() => currentColor = pickerColor);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      height: 30,
                      width: 100,
                      child: Material(
                        color: currentColor,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Date',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                readOnly: true,
                controller: dateController,
                onTap: datePicker,
                decoration: InputDecoration(
                  hintText: '${dateController.text}',
                  filled: true,
                  isDense: true,
                  suffixIcon: Icon(
                    Icons.date_range,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      readOnly: true,
                      controller: startTimeController,
                      onTap: () {
                        onTime = false;
                        _selectTime(context);
                      },
                      decoration: InputDecoration(
                        hintText: startTimeController.text,
                        filled: true,
                        isDense: true,
                        suffixIcon: Icon(
                          CupertinoIcons.chevron_down,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: TextFormField(
                      readOnly: true,
                      controller: endTimeController,
                      onTap: () {
                        onTime = true;
                        _selectTime(context);
                      },
                      decoration: InputDecoration(
                        hintText: endTimeController.text,
                        filled: true,
                        isDense: true,
                        suffixIcon: Icon(
                          CupertinoIcons.chevron_down,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CheckboxListTile(
                value: valuefirst,
                onChanged: (bool? value) {
                  valuefirst = value!;
                  setState(() {});
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
                secondary: Icon(
                  Icons.alarm,
                ),
                title: Text(
                  'Reminder',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  datePicker() async {
    NepaliDateTime? _selectedDateTime = await showAdaptiveDatePicker(
      language: NepaliUtils().language = Language.nepali,
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime(2090),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (_selectedDateTime != null) {
      print(_selectedDateTime);

      dateController.text =
          NepaliDateFormat.yMMMMEEEEd().format(_selectedDateTime);

      setState(() {});
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  bool onTime = false;
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        var s = formatTimeOfDay(selectedTime);
        if (onTime == false) {
          startTimeController.text = s;
        } else {
          endTimeController.text = s;
        }
      });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new NepaliDateTime.now();
    final dt =
        NepaliDateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = NepaliDateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }
}
