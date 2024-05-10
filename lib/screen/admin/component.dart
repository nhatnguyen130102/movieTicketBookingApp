import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

import '../../style/style.dart';
import '../../test/test.dart';

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
class InputItem extends StatelessWidget {
  TextEditingController input;
  String hintText;

  InputItem({required this.input, required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      child: TextFormField(
        controller: input,
        style: TextStyle(color: white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          label: Text(hintText),
          hintStyle:
          TextStyle(color: white.withOpacity(0.6), fontWeight: light),
          filled: true,
          fillColor: white.withOpacity(0.1),
          prefixIconColor: white,
        ),
      ),
    );
  }
}

class InputActor extends StatefulWidget {
  TextEditingController input;
  String hintText;
  String urlLinkImage;
  TextEditingController imgOutPut;

  InputActor(
      {required this.urlLinkImage,
        required this.imgOutPut,
        required this.input,
        required this.hintText,
        super.key});

  @override
  State<InputActor> createState() => _InputActorState();
}

class _InputActorState extends State<InputActor> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
      Column(
        children: [
          Row(
            children: [
              Container(
                width: size.width / 2 + 16,
                margin: EdgeInsets.only(right: 8),
                child: TextFormField(
                  controller: widget.input,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        color: white.withOpacity(0.6),
                        fontWeight: light),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    prefixIconColor: white,
                  ),
                ),
              ),


              Gap(10),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test(
                        urlLink: widget.urlLinkImage,
                        urlOutPut: widget.imgOutPut,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: pink.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: HeroIcon(
                    HeroIcons.arrowUp,
                    color: pink,
                  ),
                ),
              ),
            ],
          ),
        ],
      );




  }
}

class InputImg extends StatefulWidget {
  TextEditingController imgOutPut;
  String urlLinkImage;

  InputImg({required this.imgOutPut, required this.urlLinkImage, super.key});

  @override
  State<InputImg> createState() => _InputImgState();
}

class _InputImgState extends State<InputImg> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 200,
          child: widget.imgOutPut.text != ''
              ? Image.network(widget.imgOutPut.text)
              : Image.network(
              'https://cdn.icon-icons.com/icons2/2248/PNG/512/null_icon_135358.png'),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Test(
                      urlLink: widget.urlLinkImage,
                      urlOutPut: widget.imgOutPut,
                    ),
                  ),
                );
              });
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: pink.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: HeroIcon(
                HeroIcons.arrowUp,
                color: pink,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class DisplayActor extends StatelessWidget {
  String img;
  String actor;
  DisplayActor({ required this.actor, required this.img, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width* 0.6,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.4,
            child: Text(
                actor
            ),
          ),
          Container(
            width: size.width * 0.2,
            height: size.width * 0.2,
            child: Image.network(img,fit: BoxFit.cover,),
          ),
        ],
      ),
    );
  }
}