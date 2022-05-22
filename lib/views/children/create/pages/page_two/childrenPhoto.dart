import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/core/provider/childProvider.dart';
import 'package:my_project/utils/Utils.dart';
import 'package:permission_handler/permission_handler.dart';

class ChildrenPhoto extends StatefulWidget {
  ChildrenPhoto({Key? key}) : super(key: key);

  @override
  State<ChildrenPhoto> createState() => _ChildrenPhotoState();
}

class _ChildrenPhotoState extends State<ChildrenPhoto> {
  File _image = File('');
  var isLoading = false;
  _imgFromCamera() async {
    ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        _image = File(img.path);
      });
    }
  }

  _imgFromGallery() async {
    ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = File(img.path);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              color: Colors.white,
              height: 120,
              child: Column(
                children: [
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galería'),
                      onTap: () async {
                        if (await Permission.mediaLibrary.request().isGranted) {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pop();
                        }
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Cámara'),
                    onTap: () async {
                      if (await Permission.camera.request().isGranted) {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text(
                          "Registro de hijo con fotografía",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        backgroundImage: _image.path.isNotEmpty
                            ? FileImage(_image)
                            : NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
                                as ImageProvider,
                        radius: 65,
                      ),
                      Container(
                        width: screenWidth * 0.6,
                        padding: EdgeInsets.all(20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary: Colors.purple.shade800,
                              padding: EdgeInsets.all(1),
                            ),
                            onPressed: () {
                              _showPicker(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Seleccionar Imagen"),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.photo)
                              ],
                            )),
                      ),
                      FloatingActionButton(
                          backgroundColor:
                              _image.path.isEmpty ? Colors.grey : Colors.red,
                          child: Icon(Icons.check),
                          onPressed: _image.path.isEmpty
                              ? null
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var child =
                                      await ChildProvider().uploadPhoto(_image);
                                  if (child != null) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Utils.homeNavigator.currentState!
                                        .pop(child);
                                  }
                                }),
                    ]),
              ),
            ),
            if (isLoading)
              Container(
                width: screenWidth,
                height: screenHeigth,
                color: Colors.white.withOpacity(0.9),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ));
  }
}
