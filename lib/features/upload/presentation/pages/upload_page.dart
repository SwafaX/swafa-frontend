import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  @override
  bool get wantKeepAlive => true;

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
    super.build(context); // Call super.build

    return SingleChildScrollView(
      child: Padding(
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
                if (index == _images.length && _images.length < 6) {
                  return ImageInput(onImageSelected: _addImage);
                }
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.file(
                        _images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _images.removeAt(index);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 25),
            const Divider(
              thickness: 2,
              indent: 120,
              endIndent: 120,
              color: DefaultColors.primary100,
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: SvgPicture.asset('assets/icons/title_icon.svg'),
                ),
                hintText: "Title",
                hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: DefaultColors.primary200,
                      fontSize: 16,
                    ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: DefaultColors.primary500, width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              cursorColor: DefaultColors.primary500,
            ),
            const SizedBox(height: 15),
            Stack(
              children: [
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      left: 55,
                      top: 22,
                    ),
                    hintText: "Description",
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: DefaultColors.primary200,
                              fontSize: 16,
                            ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: DefaultColors.primary500, width: 2.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 4,
                  cursorColor: DefaultColors.primary500,
                ),
                Positioned(
                  top: 10,
                  left: 15,
                  child: SvgPicture.asset('assets/icons/description_icon.svg'),
                )
              ],
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
