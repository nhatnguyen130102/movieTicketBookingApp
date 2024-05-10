import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:project_1/model/voucher_model.dart';
import 'package:project_1/repository/voucher_repository.dart';

import '../../../style/style.dart';
import '../component.dart';
import 'main_voucher.dart';

class DetailVoucher extends StatefulWidget {
  String voucherID;

  DetailVoucher({required this.voucherID, super.key});

  @override
  State<DetailVoucher> createState() => _DetailVoucherState();
}

class _DetailVoucherState extends State<DetailVoucher> {
  //repository
  VoucherRepository _voucherRepository = VoucherRepository();

  //var
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _dateExpOutPut = TextEditingController();
  final TextEditingController _dateValidOutPut = TextEditingController();

  // late String _expDateController;
  // late String _validDateController;

  late bool _isExtraPointController = false;
  late bool _statusController = true;
  final TextEditingController _voucherIDController = TextEditingController();
  final TextEditingController _headingController = TextEditingController();

  late Future<VoucherModel> _itemScreening;

  late DateTime _selectExp = DateTime.now();
  late DateTime _selectValid = DateTime.now();

  late String _formatExp = '00/00/0000';
  late String _formatVilid = '00/00/0000';

  @override
  void initState() {
    super.initState();
    _itemScreening = _voucherRepository.getVoucherDetail(widget.voucherID);
    getScreening();
    setState(() {});
  }

  Future<void> getScreening() async {
    VoucherModel? _modun = await _itemScreening;
    _dateExpOutPut.text = _modun!.expDate;
    _dateValidOutPut.text = _modun!.validDate;
    _formatVilid = _modun.validDate;
    _formatExp = _modun!.expDate;
    _titleController.text = _modun!.title;
    _bodyController.text = _modun!.body;
    _valueController.text = _modun!.value.toString();
    _voucherIDController.text = widget.voucherID;
    _headingController.text = _modun!.heading;
    _isExtraPointController = _modun!.isExtraPoint;
    final DateFormat format = DateFormat('dd/MM/yyyy');
    setState(() {
      _selectExp = format.parse(_modun!.expDate);
      _selectValid = format.parse(_modun!.validDate);
    });
  }

  // Future<void> _expDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: _selectExp,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (pickedDate != null && pickedDate != _selectExp) {
  //     setState(() {
  //       _selectExp = pickedDate;
  //       _formatExp = DateFormat('dd/MM/yyyy').format(pickedDate);
  //       _dateExpOutPut.text = _formatExp;
  //     });
  //   }
  // }

  // Future<void> _validDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: _selectValid,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (pickedDate != null && pickedDate != _selectValid) {
  //     setState(() {
  //       _selectValid = pickedDate;
  //       _formatVilid = DateFormat('dd/MM/yyyy').format(pickedDate);
  //       _validDateController = _formatVilid;
  //     });
  //   }
  // }

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
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width,
                child: TextFormField(
                  readOnly: true,
                  controller: _voucherIDController,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'voucherID',
                    label: Text('voucherID'),
                    hintStyle: TextStyle(
                        color: white.withOpacity(0.6), fontWeight: light),
                    filled: true,
                    fillColor: white.withOpacity(0.1),
                    prefixIconColor: white,
                  ),
                ),
              ),
              InputItem(
                input: _titleController,
                hintText: 'title',
              ),
              InputItem(
                input: _bodyController,
                hintText: 'body',
              ),
              InputItem(
                input: _valueController,
                hintText: 'value',
              ),

              InputItem(
                input: _headingController,
                hintText: 'heading',
              ),

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
              DateInput(
                name: 'choose date EXP',
                outPutDate: _dateExpOutPut,
                formatDate: _formatExp,
                selectDate: _selectExp,
              ),

              Gap(32),
              DateInput(
                name: 'choose date Valid',
                outPutDate: _dateValidOutPut,
                formatDate: _formatVilid,
                selectDate: _selectValid,
              ),

              //UPLOAD FILE/FOLDER--------------------------------------

              Gap(32),

              //SAVE BUTTON
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              'Thông báo',
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          content: Container(
                            width: size.width * 0.7,
                            height: 40,
                            child: Text(
                              'Bạn có muôn sửa voucher?',
                              style: TextStyle(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.redAccent,
                                    ),
                                    height: 50,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        'Cancle',
                                        style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _voucherRepository.editVoucher(
                                      voucherID: _voucherIDController.text,
                                      body: _bodyController.text,
                                      expDate: _dateExpOutPut.text,
                                      heading: _headingController.text,
                                      isExtraPoint: _isExtraPointController,
                                      status: _statusController,
                                      title: _titleController.text,
                                      validDate: _dateValidOutPut.text,
                                      value: double.parse(
                                          _valueController.text.trim()),
                                    );
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainVoucher(),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.redAccent,
                                    ),
                                    height: 50,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  });
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'EDIT',
                    style:
                        TextStyle(fontSize: 16, color: black, fontWeight: bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Gap(10),
              // ElevatedButton (
              //   onPressed: () {
              //     _voucherRepository.createVoucher(
              //       body: _bodyController.text,
              //       expDate: _expDateController,
              //       heading: _headingController.text,
              //       isExtraPoint: _isExtraPointController,
              //       status: _statusController,
              //       title: _titleController.text,
              //       validDate: _validDateController,
              //       value: double.parse(
              //         _valueController.text.trim(),
              //       ),
              //     );
              //     setState(() {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => MainVoucher(),
              //         ),
              //       );
              //     });
              //
              //   },
              //   child: Text('create'),
              // ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              'Thông báo',
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          content: Container(
                            width: size.width * 0.7,
                            height: 40,
                            child: Text(
                              'Bạn có muôn tạo định voucher?',
                              style: TextStyle(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.redAccent,
                                    ),
                                    height: 50,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        'Cancle',
                                        style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _voucherRepository.createVoucher(
                                        body: _bodyController.text,
                                        expDate: _dateExpOutPut.text,
                                        heading: _headingController.text,
                                        isExtraPoint: _isExtraPointController,
                                        status: _statusController,
                                        title: _titleController.text,
                                        validDate: _dateValidOutPut.text,
                                        value: double.parse(
                                          _valueController.text.trim(),
                                        ),
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainVoucher(),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.redAccent,
                                    ),
                                    height: 50,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  });
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'CREATE',
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
