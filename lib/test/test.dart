import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:heroicons/heroicons.dart';

import '../style/style.dart';

class Test extends StatefulWidget {
  String urlLink;
  TextEditingController urlOutPut;
  Test({required this.urlLink, required this.urlOutPut, super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  late TextEditingController _progess = TextEditingController();
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    // đổi lại tham số đường dẫn
    final path = '${widget.urlLink}${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    // đường dẫn của hình ảnh, đem về gán vào mục tương ứng
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
    setState(() {
      uploadTask = null;
      widget.urlOutPut.text = urlDownload;
      if(_progess.text == '1.0'){ 
        Navigator.pop(context);
      }
      // buildProgress();
      // // cần trả về được đường link để gán vào data
      // Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: white,
        leading: IconButton(
          icon: HeroIcon(
            HeroIcons.chevronLeft,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            if (pickedFile != null)
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Gap(32),
            buildProgress(),
            ElevatedButton(
              child: Text('select file'),
              onPressed: selectFile,
            ),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text('upload file'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progess = data.bytesTransferred / data.totalBytes;
            _progess.text = progess.toString();
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progess,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progess).roundToDouble()}% pro: ${progess}',
                      style: TextStyle(color: white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Gap(50);
          }
        },
      );
}
