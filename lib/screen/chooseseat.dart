import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../repository/screening_repository.dart';
import '../style/style.dart';
import 'billingpage.dart';
import 'package:heroicons/heroicons.dart';

class ChooseSeat extends StatefulWidget {
  late String movieID;
  late String cinemaID;
  late String locationID;
  late String screeningID;

  ChooseSeat(
      {required this.locationID,
      required this.cinemaID,
      required this.movieID,
      required this.screeningID,
      super.key});

  @override
  State<ChooseSeat> createState() => _SeatPageState();
}

class _SeatPageState extends State<ChooseSeat> {
  // repository
  Screening_Repository _screening_repository = Screening_Repository();

  // variable
  final int numRows = 10;
  final int numColumns = 9;
  late int row;
  late int column;
  bool isSelected = false;
  late List<bool> _isSelected = [];
  late List<String> _booked;
  // late List<String> _seatBooked = [];
  final int _maximunTicket = 8;
  late double _subtotal = 0;
  final double _priceOfTicket = 60000;
  final List<int> _listCenterSeatRow = [3, 4, 5, 6];
  final List<int> _listCenterSeatColumn = [2, 3, 4, 5, 6];
  late Future<List<String?>> _listBooked;
  late final List<String?> _listStringBooked = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _booked = [];
    _isSelected = List.generate(90, (_) => false);
    _listBooked = _screening_repository.getBookedSeats(widget.screeningID);
    _listBooked.then((value) {
      // Gán giá trị của _listBooked cho _listStringBooked
      setState(() {
        _listStringBooked.addAll(value );
      });
    });
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
      body: Center(
        child: Stack(
          children: [

            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //Screen
                  Container(
                    height: 20,
                    width: 240,
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [yellow, Colors.transparent],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  //Seat-Grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numColumns,
                      ),
                      itemCount: numRows * numColumns,
                      itemBuilder: (context, index) {
                        row = index ~/ numColumns;
                        column = index % numColumns;

                        // Generate seat name (e.g., A1, A2...)
                        String seatName =
                            '${String.fromCharCode(row + 65)}${column + 1}';

                        // A-seat
                        return Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(4),
                          child: ElevatedButton(


                            onPressed:  _listStringBooked.contains(seatName) ? null : () {
                              _booked.length < _maximunTicket
                                  ? setState(
                                      () {
                                        _isSelected[index] =
                                            !_isSelected[index];
                                        _isSelected[index]
                                            ? _booked.add(seatName)
                                            : _booked.remove(seatName);
                                        _subtotal =
                                            _booked.length * _priceOfTicket;
                                      },

                                    )
                                  : setState(
                                      () {
                                        _isSelected[index]
                                            ? _booked.remove(seatName)
                                            : showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Thông báo',
                                                      style: TextStyle(
                                                        color: black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    content: Container(
                                                      width: size.width * 0.6,
                                                      height: 40,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Có thể chọn tối đa ${_maximunTicket}',
                                                            style: TextStyle(
                                                              color: black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Max: ${_maximunTicket}',
                                                            style: TextStyle(
                                                              color: black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Đóng AlertDialog
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Center(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: Colors
                                                                  .redAccent,
                                                            ),
                                                            height: 50,
                                                            width: 200,
                                                            child: Center(
                                                              child: Text(
                                                                'Confirm',
                                                                style:
                                                                    TextStyle(
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                        _isSelected[index]
                                            ? _isSelected[index] = false
                                            : _isSelected[index] = false;

                                        _subtotal =
                                            _booked.length * _priceOfTicket;
                                      },
                                    );
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              backgroundColor: _listCenterSeatRow
                                          .contains(row) &&
                                      _listCenterSeatColumn.contains(column)
                                  ? MaterialStateProperty.all(_isSelected[index]
                                      ? yellow
                                      : _listStringBooked.contains(seatName) ? white.withOpacity(0.1) : pink.withOpacity(0.4))
                                  : MaterialStateProperty.all(_isSelected[index]
                                      ? yellow
                                      : _listStringBooked.contains(seatName) ?  white.withOpacity(0.1) :  white.withOpacity(0.1)),
                              foregroundColor: MaterialStateProperty.all(
                                  _isSelected[index] ? black : _listStringBooked.contains(seatName) ? white.withOpacity(0.2) : white),
                            ),
                            child: Text(
                              '${seatName}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              left: 10,
              right: 10,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 72,
                    // color: Colors.cyan,
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                          height: 56,
                          decoration: BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Gap(20),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      'SEAT',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: bold,
                                          color: yellow),
                                    ),
                                  ),
                                  Gap(10),
                                  // Container(
                                  //   width: 160,
                                  //   child: Text(
                                  //     _booked.length > 0
                                  //         ? _booked.join(', ')
                                  //         : '',
                                  //     // Kiểm tra _nameCinema, nếu null thì sử dụng chuỗi rỗng
                                  //     style: TextStyle(
                                  //       fontWeight: medium,
                                  //       color: white,
                                  //     ),
                                  //     maxLines: 1,
                                  //     overflow: TextOverflow.ellipsis,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Gap(1),
                              Container(
                                width: 200,
                                child: Text(
                                  _booked.length > 0 ? _booked.join(', ') : '',
                                  // Kiểm tra _nameCinema, nếu null thì sử dụng chuỗi rỗng
                                  style: TextStyle(
                                    fontWeight: medium,
                                    color: white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       child: Text(
                              //         'Subtotal',
                              //         style: TextStyle(
                              //             fontSize: 18,
                              //             fontWeight: bold,
                              //             color: yellow),
                              //       ),
                              //     ),
                              //     Gap(10),
                              //     Container(
                              //       width: 160,
                              //       child: Text(
                              //         _subtotal.toString() + ' đ',
                              //         // Kiểm tra _nameCinema, nếu null thì sử dụng chuỗi rỗng
                              //         style: TextStyle(
                              //           fontWeight: medium,
                              //           color: white,
                              //         ),
                              //         maxLines: 1,
                              //         overflow: TextOverflow.ellipsis,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 7,
                    right: 0,
                    child:

                        //Cinema-Selection
                        GestureDetector(
                      onTap: _booked.length > 0
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return BillingPage(
                                    booked: _booked,
                                    cinemaID: widget.cinemaID,
                                    locationID: widget.locationID,
                                    movieID: widget.movieID,
                                    screeningID: widget.screeningID,
                                    total: _subtotal,
                                    subtotal: _subtotal,
                                  );
                                }),
                              );
                            } // Vô hiệu hóa GestureDetector nếu _locationBookedSelected là true
                          : null,

                      //Button-Next
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: _booked.length > 0 ? yellow : Colors.grey),
                          child: Row(
                            children: [
                              Text(
                                _subtotal.toString() + ' đ',
                                style: TextStyle(
                                    color: black,
                                    fontWeight: semibold,
                                    fontSize: 18),
                              ),
                              Gap(8),
                              // HeroIcon(HeroIcons.arrowRight),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// //Main Screen
// class SeatGrid extends StatelessWidget {
//   final int numRows = 10;
//   final int numColumns = 9;
//   bool isSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           //Screen
//           Container(
//             height: 20,
//             width: 240,
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [yellow, Colors.transparent],
//               ),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(50),
//                 topRight: Radius.circular(50),
//               ),
//             ),
//           ),
//           //Seat-Grid
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: numColumns,
//               ),
//               itemCount: numRows * numColumns,
//               itemBuilder: (context, index) {
//                 int row = index ~/ numColumns;
//                 int column = index % numColumns;
//
//                 // Generate seat name (e.g., A1, A2...)
//                 String seatName = '${String.fromCharCode(row + 65)}${column + 1}';
//
//                 // A-seat
//                 return Container(
//                   width: 30,
//                   height: 30,
//                   padding: EdgeInsets.all(4),
//
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         isSelected = !isSelected;
//                       });
//                     },
//                     style: ButtonStyle(
//                       padding: MaterialStateProperty.all(EdgeInsets.zero),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       backgroundColor: MaterialStateProperty.all(isSelected ? yellow : white.withOpacity(0.1)),
//                       foregroundColor: MaterialStateProperty.all(isSelected ? black : white),
//                     ),
//                     child: Text(
//                       '${seatName}',
//                       style: TextStyle(fontSize: 12, fontWeight: medium,),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//Ghế
// class Seat extends StatefulWidget {
//   final String seatName;
//
//   Seat({required this.seatName});
//
//   @override
//   _SeatState createState() => _SeatState();
// }
//
// //Trạng thái ghế
// class _SeatState extends State<Seat> {
//   bool isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           isSelected = !isSelected;
//         });
//       },
//       style: ButtonStyle(
//         padding: MaterialStateProperty.all(EdgeInsets.zero),
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5),
//           ),
//         ),
//         backgroundColor: MaterialStateProperty.all(isSelected ? yellow : white.withOpacity(0.1)),
//         foregroundColor: MaterialStateProperty.all(isSelected ? black : white),
//       ),
//       child: Text(
//         '${widget.seatName}',
//         style: TextStyle(fontSize: 12, fontWeight: medium,),
//       ),
//     );
//   }
// }
