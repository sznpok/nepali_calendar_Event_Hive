import 'package:flutter/material.dart' hide CalendarDatePicker;
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:flutter/painting.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:provider/provider.dart';
import 'package:task_calendar/model/task.dart';
import 'package:task_calendar/model_service/services_model.dart';

/// Calendar Picker Example
class CalendarDatePickerWidget extends StatefulWidget {
  const CalendarDatePickerWidget({Key? key}) : super(key: key);

  @override
  State<CalendarDatePickerWidget> createState() =>
      _CalendarDatePickerWidgetState();
}

class _CalendarDatePickerWidgetState extends State<CalendarDatePickerWidget> {
  final ValueNotifier<NepaliDateTime> _selectedDate =
      ValueNotifier(NepaliDateTime.now());

  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  datePicker() async {
    NepaliDateTime? _selectedDateTime = await picker.showAdaptiveDatePicker(
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
          _selectedDateTime.toIso8601String().substring(0, 10);

      setState(() {});
    }
  }

  @override
  void initState() {
    dateController.text =
        NepaliDateTime.now().toIso8601String().substring(0, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ServiceModel>(context);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Title',
                              style: TextStyle(
                                  fontSize: 1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: TextFormField(
                                controller: titleController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'title cannot be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.grey.shade300,
                                  filled: true,
                                  labelText: 'title name',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: TextFormField(
                                controller: descController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Item description cannot be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  border: InputBorder.none,
                                  fillColor: Colors.grey.shade300,
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                datePicker();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: TextFormField(
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    labelText: dateController.text,
                                    border: InputBorder.none,
                                    fillColor: Colors.grey.shade300,
                                    filled: true,
                                  ),
                                  enabled: false,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  DateTime? dateTime =
                                      DateTime.parse(dateController.text);
                                  print(dateTime);

                                  if (_formKey.currentState!.validate()) {
                                    provider.addItem(
                                      Task(
                                        description: descController.text,
                                        startDate: dateTime,
                                        title: titleController.text,
                                      ),
                                    );
                                    descController.clear();
                                    titleController.clear();

                                    provider.getTask();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('Add'),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        child: const Text(
          'Add',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalendarDatePicker(
              initialDate: NepaliDateTime.now(),
              firstDate: NepaliDateTime(2070),
              lastDate: NepaliDateTime(2090),
              onDateChanged: (date) => _selectedDate.value = date,
              initialCalendarMode: DatePickerMode.day,
              dayBuilder: (dayToBuild) {
                Color color = Colors.black;
                if (dayToBuild.weekday == 7) {
                  color = Colors.red;
                } else {
                  color = Colors.black;
                }
                List<Task>? event;
                event = provider.getListTask
                    .where((e) => _dayEquals(
                        NepaliDateTime.tryParse(e.startDate.toString()),
                        dayToBuild))
                    .toList();

                return Stack(
                  children: <Widget>[
                    Center(
                      child: Text(
                        NepaliUtils().language == Language.nepali
                            ? '${dayToBuild.day}'
                            : NepaliUnicode.convert('${dayToBuild.day}'),
                        style: TextStyle(
                          color: color,
                        ),
                      ),
                    ),
                    if (provider.getListTask.any((event) => _dayEquals(
                        NepaliDateTime.tryParse(event.startDate.toString()),
                        dayToBuild)))
                      /* Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.purple),
                        ),
                      ), */
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Material(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(2.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 2,
                            ),
                            child: Text(
                              event.length.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
              selectedDayDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 2,
                  color: Colors.blue,
                ),
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const Text(
              'Tasks',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ValueListenableBuilder<NepaliDateTime>(
              valueListenable: _selectedDate,
              builder: (context, date, _) {
                List<Task>? event;
                try {
                  // event = provider.getListTask
                  //         .firstWhere((e) => _dayEquals(e.startDate, date))
                  event = provider.getListTask
                      .where((e) => _dayEquals(
                          NepaliDateTime.tryParse(e.startDate.toString()),
                          date))
                      .toList();
                } on StateError {
                  event = null;
                }

                if (event == null) {
                  return const Center(
                    child: Text('No Events'),
                  );
                }

                return ListView.separated(
                  itemCount: event.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      event![index].title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      event[index].description,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      NepaliDateFormat.yMMMMEEEEd().format(NepaliDateTime.parse(
                          event[index].startDate.toString())),
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {},
                  ),
                  separatorBuilder: (context, _) => const Divider(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _dayEquals(NepaliDateTime? a, NepaliDateTime? b) =>
      a != null &&
      b != null &&
      a.toIso8601String().substring(0, 10) ==
          b.toIso8601String().substring(0, 10);
}
