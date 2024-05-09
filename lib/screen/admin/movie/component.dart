import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

import '../../../style/style.dart';

class DateInput extends StatefulWidget {
  late TextEditingController outPutDate;
  late DateTime selectDate;
  late String formatDate;
  late String name;

  DateInput(
      {required this.name,
        required this.outPutDate,
        required this.formatDate,
        required this.selectDate,
        super.key});

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  @override
  void initState() {
    super.initState();
    widget.selectDate = DateTime.now();
    widget.formatDate = DateFormat('dd/MM/yyyy').format(widget.selectDate);
  }

  Future<void> _expDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != widget.selectDate) {
      setState(() {
        widget.selectDate = pickedDate;
        widget.formatDate = DateFormat('dd/MM/yyyy').format(pickedDate);
        widget.outPutDate.text = widget.formatDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name, style: TextStyle(color: white.withOpacity(0.6))),
            Gap(4),
            Text(
              widget.formatDate,
              style: TextStyle(fontWeight: semibold, fontSize: 20),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            _expDate(context);
          },
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: HeroIcon(
                HeroIcons.calendar,
                color: white,
              )),
        ),
      ],
    );
  }
}
