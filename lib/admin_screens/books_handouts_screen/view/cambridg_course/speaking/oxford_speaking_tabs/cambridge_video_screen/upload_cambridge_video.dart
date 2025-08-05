import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class VideoCambridgeUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoCambridgeUploadScreen>
    with TickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  File? _selectedVideo;
  String? _videoFileName;
  bool _isUploading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));

    _animationController.forward();
  }


  FilePickerResult? result;
  // Pick Video
  Future<void> _pickVideo() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      );

      if (result != null && result!.files.single.path != null) {
        setState(() {
          _selectedVideo = File(result!.files.single.path!);
          _videoFileName = result!.files.single.name;
        });
      }
    } catch (e) {
      _showSnackBar('Error selecting video: $e', Colors.red);
    }
  }

  // Upload Video
  Future<void> _uploadVideo() async {
    if (_titleController.text.isEmpty) {
      _showSnackBar('Please enter video title', Colors.orange);
      return;
    }

    if (_selectedVideo == null) {
      _showSnackBar('Please select a video to upload', Colors.orange);
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Simulate upload process
      await Future.delayed(Duration(seconds: 3));

      _showSnackBar('Video uploaded successfully! 🎉', Colors.green);

      // Clear fields after upload
      setState(() {
        _titleController.clear();
        _selectedVideo = null;
        _videoFileName = null;
      });
    } catch (e) {
      _showSnackBar('Error uploading video: $e', Colors.red);
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: ModalProgressHUD(
            progressIndicator: CupertinoActivityIndicator(color: ColorManager.primary,),
            inAsyncCall: context.read<AppCubit>().isUploadingCambridgeVideo,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorManager.primary
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Custom App Bar
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          SizedBox(width: 16),
                          Text(
                            'Upload Video',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Main Content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(height: 10),

                                    // عنوان الفيديو
                                    _buildTitleSection(),
                                    SizedBox(height: 30),

                                    // منطقة اختيار الفيديو
                                    _buildVideoPickerSection(),
                                    SizedBox(height: 30),

                                    // زر الرفع
                                    _buildUploadButton(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF667eea).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.title, color: Color(0xFF667eea)),
              ),
              SizedBox(width: 12),
              Text(
                'Title',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            controller: _titleController,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Enter video title',
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPickerSection() {
    return Container(
      decoration: BoxDecoration(
        color: _selectedVideo != null ? Colors.green[50] : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _selectedVideo != null ? Colors.green[200]! : Colors.grey[200]!,
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _pickVideo,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _selectedVideo != null ? Colors.green : Color(0xFF667eea),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (_selectedVideo != null ? Colors.green : Color(0xFF667eea)).withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    _selectedVideo != null ? Icons.check_circle : Icons.videocam,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _selectedVideo != null ? 'Video Selected Successfully!' : 'Select Video to Upload',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _selectedVideo != null ? Colors.green[700] : Colors.grey[700],
                  ),
                ),
                if (_videoFileName != null) ...[
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Text(
                      _videoFileName!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                SizedBox(height: 16),
                Text(
                  'Click here to select a video from your device',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorManager.primary,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF667eea).withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:(){
            context.read<AppCubit>().uploadCambridgeVideoToFirebase(title: _titleController.text, section: 'video', filed: 'speaking',result: result!);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            alignment: Alignment.center,
            child: _isUploading
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'Uploading...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_upload, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Text(
                  'Upload Video',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
