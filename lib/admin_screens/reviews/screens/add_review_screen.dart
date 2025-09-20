import 'dart:io';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  File? _pickedImage;
  File? _pickedVideo;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
        _pickedVideo = null; // ممنوع يبقى صورة وفيديو مع بعض
      });
    }
  }

  Future<void> _pickVideo() async {
    final picked = await _picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedVideo = File(picked.path);
        _pickedImage = null;
      });
    }
  }

  Future<String> uploadFileToStorage(File file, String folder) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child("$folder/$fileName");

    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void _submitReview() async {
    String studentName = _studentNameController.text.trim();
    String text = _reviewController.text.trim();

    if (studentName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the student's name.")),
      );
      return;
    }

    String? imageUrl;
    String? videoUrl;

    // رفع الصورة
    if (_pickedImage != null) {
      imageUrl = await uploadFileToStorage(_pickedImage!, "review_images");
    }

    // رفع الفيديو
    if (_pickedVideo != null) {
      videoUrl = await uploadFileToStorage(_pickedVideo!, "review_videos");
    }

    // استدعاء الفانكشن في Cubit
    await AppCubit.get(context).addReview(
      userId: "", // هنا لو عندك ID للطالب حطه
      userName: studentName,
      reviewText: text,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
    );

    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Review")),
      body: BlocBuilder<AppCubit,AppStates>(
        builder: (context,state){
          return ModalProgressHUD(
            inAsyncCall: state is AddReviewLoadingState,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // إدخال اسم الطالب
                  TextField(
                    controller: _studentNameController,
                    decoration: const InputDecoration(
                      labelText: "Student Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // الكتابة
                  TextField(
                    controller: _reviewController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Write your review here...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // اختيار صورة أو فيديو
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text("Pick Image"),
                      ),
                      ElevatedButton.icon(
                        onPressed: _pickVideo,
                        icon: const Icon(Icons.videocam),
                        label: const Text("Pick Video"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // معاينة
                  if (_pickedImage != null)
                    Image.file(_pickedImage!, height: 150),
                  if (_pickedVideo != null)
                    const Icon(Icons.videocam, size: 100, color: Colors.red),

                  const Spacer(),

                  // زرار ارسال
                  DefaultButton(
                    onPressed: _submitReview,
                    color: ColorManager.primary,
                    text: "Submit Review",
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
