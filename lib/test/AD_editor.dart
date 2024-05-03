import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:project_1/repository/voucher_repository.dart';
import 'package:project_1/screen/mainlayout.dart';

import '../style/style.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  //repository
  VoucherRepository _voucherRepository = VoucherRepository();

  //var
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  late String _expDateController;
  late String _validDateController;

  late bool _isExtraPointController = false;
  late bool _statusController = false;
  final TextEditingController _voucherIDController = TextEditingController();
  final TextEditingController _headingController = TextEditingController();

  late DateTime _selectExp;
  late DateTime _selectValid;

  late String _formatExp = '00/00/0000';
  late String _formatVilid = '00/00/0000';

  @override
  void initState() {
    super.initState();
    _selectExp = DateTime.now();
    _formatExp = DateFormat('dd/MM/yyyy').format(_selectExp);
    _selectValid = DateTime.now();
    _formatVilid = DateFormat('dd/MM/yyyy').format(_selectValid);
  }

  Future<void> _expDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectExp,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectExp) {
      setState(() {
        _selectExp = pickedDate;
        _formatExp = DateFormat('dd/MM/yyyy').format(pickedDate);
        _expDateController = _formatExp;
      });
    }
  }

  Future<void> _validDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectValid,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectValid) {
      setState(() {
        _selectValid = pickedDate;
        _formatVilid = DateFormat('dd/MM/yyyy').format(pickedDate);
        _validDateController = _formatVilid;
      });
    }
  }

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
        // title: Text('Name movie ${widget.number}'),
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
                'Voucher',
                style: TextStyle(fontSize: 18, fontWeight: medium),
              ),
              Gap(16),
              //BODY 1
              Container(
                width: size.width,
                child: TextFormField(
                  controller: _titleController,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Title',
                    label: Text('Title'),
                    hintStyle: TextStyle(
                        color: white.withOpacity(0.6), fontWeight: light),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    prefixIconColor: white,
                  ),
                ),
              ),
              Gap(10),
              Container(
                width: size.width,
                child: TextFormField(
                  controller: _bodyController,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Body',
                    label: Text('Body'),
                    hintStyle: TextStyle(
                        color: white.withOpacity(0.6), fontWeight: light),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    prefixIconColor: white,
                  ),
                ),
              ),
              Gap(10),
              Container(
                width: size.width,
                child: TextFormField(
                  controller: _headingController,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Heading',
                    label: Text('Heading'),
                    hintStyle: TextStyle(
                        color: white.withOpacity(0.6), fontWeight: light),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    prefixIconColor: white,
                  ),
                ),
              ),
              Gap(10),
              Container(
                width: size.width,
                child: TextFormField(
                  controller: _voucherIDController,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Voucher ID',
                    label: Text('Voucher ID'),
                    hintStyle: TextStyle(
                        color: white.withOpacity(0.6), fontWeight: light),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    prefixIconColor: white,
                  ),
                ),
              ),
              Gap(10),
              Container(
                width: size.width,
                child: TextFormField(
                  controller: _valueController,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Value',
                    label: Text('Value'),
                    hintStyle: TextStyle(
                        color: white.withOpacity(0.6), fontWeight: light),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    prefixIconColor: white,
                  ),
                ),
              ),
              Gap(16),

              Row(
                children: [
                  Text('Is Extra Point', style: TextStyle(fontSize: 16)),
                  Gap(16),
                  Switch(
                    value: _isExtraPointController,
                    inactiveThumbColor: white,
                    inactiveTrackColor: white.withOpacity(0.3),
                    activeColor: yellow,
                    onChanged: (value) {
                      setState(() {
                        _isExtraPointController = value;
                      });
                    },
                  ),
                ],
              ),

              Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Valid Date', style: TextStyle(color: white.withOpacity(0.6))),
                      Gap(4),
                      Text(
                        _formatExp,
                        style:
                        TextStyle(fontWeight: semibold, fontSize: 20),
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
                        child: HeroIcon(HeroIcons.calendar, color: white,)
                    ),
                  ),
                ],
              ),

              Gap(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expiry Date', style: TextStyle(color: white.withOpacity(0.6))),
                      Gap(4),
                      Text(
                        _formatVilid,
                        style:
                        TextStyle(fontWeight: semibold, fontSize: 20),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _validDate(context);
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: HeroIcon(HeroIcons.calendar, color: white,)
                    ),
                  ),
                ],
              ),


              //UPLOAD FILE/FOLDER--------------------------------------
              // Text(
              //   'Heading',
              //   style: TextStyle(fontSize: 18, fontWeight: medium),
              // ),
              // Gap(16),
              // //BODY 2
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         Container(
              //           width: size.width / 2 + 16,
              //           margin: EdgeInsets.only(right: 8),
              //           child: TextFormField(
              //             //controller: ..,
              //             style: TextStyle(color: white),
              //             decoration: InputDecoration(
              //               border: OutlineInputBorder(
              //                 borderSide: BorderSide.none,
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //               hintText: 'Search',
              //               hintStyle: TextStyle(
              //                   color: white.withOpacity(0.6),
              //                   fontWeight: light),
              //               filled: true,
              //               fillColor: white.withOpacity(0.1),
              //               prefixIconColor: white,
              //             ),
              //           ),
              //         ),
              //         Gap(10),
              //         Container(
              //           padding: EdgeInsets.all(16),
              //           decoration: BoxDecoration(
              //             color: yellow.withOpacity(0.2),
              //             borderRadius: BorderRadius.circular(50),
              //           ),
              //           child: HeroIcon(
              //             HeroIcons.plus,
              //             color: yellow,
              //           ),
              //         ),
              //         Gap(10),
              //         Container(
              //           padding: EdgeInsets.all(16),
              //           decoration: BoxDecoration(
              //             color: pink.withOpacity(0.2),
              //             borderRadius: BorderRadius.circular(50),
              //           ),
              //           child: HeroIcon(
              //             HeroIcons.arrowUp,
              //             color: pink,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              Gap(24),

              //SAVE BUTTON
              GestureDetector(
                onTap: () {
                  setState(() {
                    _voucherRepository.createVoucher(
                        body: _bodyController.text,
                        expDate: _expDateController,
                        heading: _headingController.text,
                        isExtraPoint: _isExtraPointController,
                        status: _statusController,
                        title: _titleController.text,
                        validDate: _validDateController,
                        value: double.parse(_valueController.text.trim()),
                        voucherID: _voucherIDController.text);
                  });
                  // _createVoucher();
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

  // Future<void> _createVoucher() async {
  //   String title = _titleController.text.trim();
  //   String body = _bodyController.text.trim();
  //   double value = double.parse(_valueController.text.trim());
  //   String validDate = _validDateController;
  //   String expDate = _expDateController;
  //
  //   try {
  //     await _voucherRepository.createVoucher(
  //       title: title,
  //       body: body,
  //       value: value,
  //       validDate: validDate,
  //       expDate: expDate,
  //       status: true,
  //       heading: '',
  //       isExtraPoint: true,
  //       voucherID: '',
  //       // Add other parameters here
  //     );
  //     // Show success message or navigate to another page
  //   } catch (e) {
  //     // Show error message
  //   }
  // }
}
