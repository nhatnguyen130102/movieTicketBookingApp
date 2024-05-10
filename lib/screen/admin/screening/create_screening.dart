

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';

import '../../../style/style.dart';
import '../../mainlayout.dart';
import '../component.dart';

class CreateScreening extends StatefulWidget {
  const CreateScreening({super.key});

  @override
  State<CreateScreening> createState() => _CreateScreeningState();
}

class _CreateScreeningState extends State<CreateScreening> {
  //var
  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _room = TextEditingController();
  final TextEditingController _formatID = TextEditingController();
  final TextEditingController _movieID = TextEditingController();
  final TextEditingController _cinemaID = TextEditingController();

  late TextEditingController _dateOutPut = TextEditingController();
  late DateTime _selectDate = DateTime.now();
  late String _formatDate = '00/00/0000';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: white,
        leading: IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //HEADING 1
              Text(
                'Screening',
                style: TextStyle(fontSize: 18, fontWeight: medium),
              ),
              Gap(16),
              //BODY 1

              InputItem(
                input: _room,
                hintText: 'room',
              ),
              InputItem(
                input: _time,
                hintText: 'time',
              ),

              Gap(24),
              DateInput(
                name: 'choose date',
                outPutDate: _dateOutPut,
                formatDate: _formatDate,
                selectDate: _selectDate,
              ),
              Gap(24),

              //SAVE BUTTON
              GestureDetector(
                onTap: () {
                  setState(() {
                    // _repository.createScreening(
                    //   booked: null,
                    //   cinemaID: null,
                    //   formatID: null,
                    //   movieID: null,
                    //   room: _room.text,
                    //   date: _dateOutPut.text,
                    //   time: _time.text,
                    // );
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainLayout(),
                    ),
                  );
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'SAVE',
                    style:
                    TextStyle(fontSize: 16, color: black, fontWeight: bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
