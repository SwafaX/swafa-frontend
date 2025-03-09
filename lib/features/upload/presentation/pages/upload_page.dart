import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/core/theme.dart';
import 'package:swafa_app_frontend/features/upload/presentation/bloc/upload_bloc.dart';
import 'package:swafa_app_frontend/features/upload/presentation/bloc/upload_event.dart';
import 'package:swafa_app_frontend/features/upload/presentation/bloc/upload_state.dart';
import 'package:swafa_app_frontend/features/upload/presentation/widgets/image_input.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<File> _images = [];

  void _addImage(File image) {
    setState(() {
      _images.add(image); // Add the new image to the list
    });
  }

  void _onUpload() {
    BlocProvider.of<UploadBloc>(context).add(
      UploadItemEvent(
        title: _titleController.text,
        description: _descriptionController.text,
        images: _images,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _images.length < 6 ? _images.length + 1 : 6,
              itemBuilder: (context, index) {
                if (index == _images.length) {
                  return ImageInput(onImageSelected: _addImage);
                }
                return Image.file(
                  _images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 30),
            BlocConsumer<UploadBloc, UploadState>(
              listener: (context, state) {
                if (state is UploadSuccessState) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Upload Successful"),
                      content: const Text(
                          "Your image has been uploaded successfully."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is UploadLoadingState) {
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DefaultColors.primary500,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: _onUpload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DefaultColors.primary500,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Upload',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
