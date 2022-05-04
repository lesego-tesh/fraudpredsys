import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Predict extends StatefulWidget {
  const Predict({Key? key}) : super(key: key);

  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> with SingleTickerProviderStateMixin {
  final String _image =
      'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';
  late AnimationController loadingController;
  late String data;
  late File _file;
  PlatformFile? _platformFile;
  late List<String> results;

  selectFile() async {
    final file = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });

      uploadFileFromDio(File(_platformFile!.path!))
          .then((value) => print(value));
    }

    loadingController.forward();
    return _platformFile!;
  }

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  //Upload from Dio
  uploadFileFromDio(File file) async {
    var dio = Dio();
    String fileName = file.path.split("/").last;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    if (kDebugMode) {
      print("Platform file path: ${_platformFile!.path}");
    }

    FormData formdata = FormData();
    formdata.files.add(MapEntry(
        "actual_file",
        await MultipartFile.fromFile(
          _platformFile!.path!,
        )));

    formdata.fields.add(MapEntry("description", fileName));
    formdata.fields.add(MapEntry("file_name", fileName));
    var response = await dio.post("http://10.0.2.2:8000/fps/transactionUpload/",
        data: formdata);
    if (kDebugMode) {
      print("response from formData: ${formdata.fields.toString()}");
      print("response from API: ${response.toString()}");
    }

    var response2 = await dio.get("http://10.0.2.2:8000/fps/predictLatest/");

    // ignore: await_only_futures
    data = await response2.toString();

    //results = parseResults(data).cast<String>();

    if (kDebugMode) {
      print("value Predict: $data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(239, 219, 215, 215),
        appBar: AppBar(
          title: const Text("Predict"),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            Image.network(
              _image,
              width: 300,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Upload your file',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'File should be csv',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: selectFile,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: [10, 4],
                    strokeCap: StrokeCap.round,
                    color: Colors.blue.shade400,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.file_open,
                            color: Colors.blue,
                            size: 40,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Select your file',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            if (_platformFile != null)
              Text("File name: ${_platformFile!.name}"),
            if (_platformFile != null)
              Text("File size: ${_platformFile!.size}"),
            if (_platformFile != null)
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Result'),
                            content: Text(
                                // ignore: avoid_print
                                'Result is ${uploadFileFromDio(File(_platformFile!.path!))}'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Go Back'))
                            ],
                          ));
                },
                child: const Text('Predict'),
              ),
          ]),
        ));
  }
//                 ? Container(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Selected File',
//                           style: TextStyle(
//                             color: Colors.grey.shade400,
//                             fontSize: 15,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.shade200,
//                                     offset: const Offset(0, 1),
//                                     blurRadius: 3,
//                                     spreadRadius: 2,
//                                   )
//                                 ]),
//                             child: Row(
//                               children: [
//                                 ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: Image.asset(
//                                       'assets/logo.png',
//                                       width: 70,
//                                     )),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         _platformFile!.name,
//                                         style: const TextStyle(
//                                             fontSize: 13, color: Colors.black),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         '${(_platformFile!.size / 1024).ceil()} KB',
//                                         style: TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.grey.shade500),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Container(
//                                           height: 5,
//                                           clipBehavior: Clip.hardEdge,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                             color: Colors.blue.shade50,
//                                           ),
//                                           child: LinearProgressIndicator(
//                                             value: loadingController.value,
//                                           )),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                               ],
//                             )),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         // MaterialButton(
//                         //   minWidth: double.infinity,
//                         //   height: 45,
//                         //   onPressed: () {},
//                         //   color: Colors.black,
//                         //   child: Text('Upload', style: TextStyle(color: Colors.white),),
//                         // )
//                       ],
//                     ))
//                 : Container(),
//             const SizedBox(
//               height: 150,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
}
