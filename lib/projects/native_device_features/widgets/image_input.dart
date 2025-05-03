import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storeImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _storeImage = File(imageFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child:
              _storeImage != null
                  ? Image.file(
                    _storeImage!,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  )
                  : Text('No Image Taken', textAlign: TextAlign.center),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            onPressed: _takePicture,
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              // no ripple
              foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.blue.withValues(alpha: 0.5); // dim when pressed
                }
                return Colors.blue;
              }),
            ),
            label: Text('Click Me'),
          ),
        ),
      ],
    );
  }
}
