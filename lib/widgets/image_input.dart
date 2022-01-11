import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  Function savedImage;
  Function updateImage;
  File? image;
  ImageInput({
    Key? key,
    required this.savedImage,
    required this.updateImage,
    required this.image,
  }) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _takePicture(ImageSource imageSource) async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(source: imageSource, maxWidth: 600);
    if (imageFile == null) return;
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(imageFile.path);
    final _savedImage = await _storedImage!.copy('${appDir.path}/$filename');
    widget.savedImage(_savedImage);
    widget.updateImage(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 200,
          height: 200,
          child: widget.image != null
              ? Image.file(
                  widget.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : _storedImage != null
                  ? Image.file(
                      _storedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : GestureDetector(
                      onTap: () {
                        _takePicture(ImageSource.camera);
                      },
                      child: Stack(
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://www.freeiconspng.com/uploads/add-user-icon--icon-search-engine-28.png'),
                          ),
                          Positioned(
                            child: Text(
                              "Camera",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            bottom: 40,
                            left: 60,
                          ),
                        ],
                      ),
                    ),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.black),
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: () {
              _takePicture(ImageSource.gallery);
            },
            icon: Icon(
              Icons.camera,
              color: Colors.blue,
            ),
            textColor: Theme.of(context).primaryColor,
            label: Text(
              'Gallery',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
