import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_dathboard/admin_screens/certificates/screens/edit_certificate_screen.dart';
import 'package:e_learning_dathboard/admin_screens/certificates/screens/open_image.dart';
import 'package:e_learning_dathboard/admin_screens/certificates/screens/upload_certificate_screen.dart';
import 'package:e_learning_dathboard/admin_screens/reviews/screens/add_review_screen.dart';
import 'package:e_learning_dathboard/admin_screens/reviews/screens/replies_management_screen.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/custom_toast.dart';
import 'package:e_learning_dathboard/widgets/default_button.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool isLoading = false;
  final TextEditingController replyController = TextEditingController();
  File? selectedMedia;
  String? mediaType; // "image" or "video"
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedMedia = File(picked.path);
        mediaType = "image";
      });
    }
  }

  Future<void> pickVideo() async {
    final picked = await picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedMedia = File(picked.path);
        mediaType = "video";
      });
    }
  }

  /// رفع الميديا على Firebase Storage
  Future<String?> uploadMedia(File file, String type) async {
    try {
      String fileName = "${DateTime.now().millisecondsSinceEpoch}.${type == 'image' ? 'jpg' : 'mp4'}";
      final ref = FirebaseStorage.instance.ref().child("replies/$fileName");
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint("Upload error: $e");
      return null;
    }
  }

  /// إضافة الرد إلى Firestore
  Future<void> addReply({
    required String reviewId,
    required String replyText,
  }) async {
    try {
      setState(() {
        isLoading = true;
      });
      String? mediaUrl;

      // لو فيه ميديا نرفعها
      if (selectedMedia != null && mediaType != null) {
        mediaUrl = await uploadMedia(selectedMedia!, mediaType!);
      }

      await FirebaseFirestore.instance
          .collection('reviews')
          .doc(reviewId)
          .collection('replies')
          .add({
        'reply': replyText,
        'mediaUrl': mediaUrl ?? '',
        'mediaType': mediaType ?? '',
        'timestamp': FieldValue.serverTimestamp(),
        'adminName': "Admin Test", // تحط اسم الأدمن من الـ auth
        'adminImage': "", // صورة الأدمن لو موجودة
      });
      setState(() {
        isLoading = false;
      });
      debugPrint("Reply added successfully!");
    } catch (e) {
      debugPrint("Error adding reply: $e");
    }
  }

  /// جلب كل الردود حسب الـ reviewId
  Stream<List<Map<String, dynamic>>> getReplies(String reviewId) {
    return FirebaseFirestore.instance
        .collection('reviews')
        .doc(reviewId)
        .collection('replies')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());

  }

  void showReplyBottomSheet(String reviewId,String fcmToken) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setStateBottomSheet) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Write a reply",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: replyController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Type your reply...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (selectedMedia != null)
                    mediaType == "image"
                        ? Image.file(selectedMedia!, height: 150)
                        : const Icon(Icons.videocam, size: 50, color: Colors.red),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await pickImage();
                          setStateBottomSheet(() {});
                        },
                        icon: const Icon(Icons.image, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () async {
                          await pickVideo();
                          setStateBottomSheet(() {});
                        },
                        icon: const Icon(Icons.videocam, color: Colors.red),
                      ),
                    ],
                  ),

                  ElevatedButton.icon(
                    onPressed: () async {
                      final appCubit = AppCubit.get(context);

                      Navigator.pop(context);

                      setState(() {
                        isLoading = true;
                      });

                      final replyText = replyController.text.trim();
                      if (replyText.isNotEmpty || selectedMedia != null) {
                        await addReply(
                          reviewId: reviewId,
                          replyText: replyText,
                        );

                        replyController.clear();
                        setState(() {
                          selectedMedia = null;
                          mediaType = null;
                          isLoading = false;
                        });
                        customToast(title: 'Reply added successfully', color: Colors.green);

                        appCubit.sendNotification(
                          uId: reviewId,
                          title: 'Reply to your review',
                          body: 'New reply to your review',
                          token: fcmToken,
                        );
                      }
                    },
                    icon: const Icon(Icons.send),
                    label: const Text("Send Reply"),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }




  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getReviews();
  }

  // Function to determine content type
  ReviewType _getReviewType(review) {
    bool hasImage = review.reviewImage != null && review.mediaType == 'image';
    bool hasVideo = review.reviewVideo != null && review.mediaType == 'video';

    if (hasVideo) return ReviewType.textWithVideo;
    if (hasImage) return ReviewType.textWithImage;
    return ReviewType.textOnly;
  }

  // Function to display review content based on its type
  Widget _buildReviewContent(review, ReviewType type) {
    switch (type) {
      case ReviewType.textOnly:
        return _buildTextOnlyContent();
      case ReviewType.textWithImage:
        return _buildTextWithImageContent(review);
      case ReviewType.textWithVideo:
        return _buildTextWithVideoContent(review);
    }
  }

  Widget _buildTextOnlyContent() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.text_fields,
        size: 40,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildTextWithImageContent(review) {
    return GestureDetector(
      onTap: () {
        customPushNavigator(context, FullScreenImageScreen(
          imageUrl: review.reviewImage,
        ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: review.reviewImage,
          height: MediaQuery.sizeOf(context).height * 0.2,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (_, url) => Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            child: Center(child: CupertinoActivityIndicator()),
          ),
          errorWidget: (context, url, error) => Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            child: Center(child: Icon(Icons.error, color: Colors.red)),
          ),
        ),
      ),
    );
  }

  Widget _buildTextWithVideoContent(review) {
    return GestureDetector(
      onTap: () {
        // You can create a screen to display video in full screen
        customPushNavigator(context, FullScreenVideoScreen(
          videoUrl: review.reviewVideo,
        ));
      },
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.2,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: VideoThumbnail(videoUrl: review.reviewVideo),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(review, int index) {
    final TextEditingController reviewController = TextEditingController(text: review.review);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Edit Review'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: reviewController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Write your review...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Options to change content
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Change image button

                          review.mediaType=='image'?
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _pickImage(review.uId, setState);
                            },
                            icon: Icon(Icons.image, size: 16,color: Colors.white,),
                            label: Text('Change Image'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ):Container(),

                          SizedBox(height: 16),

                          // Change video button
                          review.mediaType=='video'?
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _pickVideo(review.uId, setState);
                            },
                            icon: Icon(Icons.videocam, size: 16,color: Colors.white,),
                            label: Text('Change Video'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ):Container(),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Remove content button
                      // ElevatedButton.icon(
                      //   onPressed: () {
                      //     _removeMedia(review.id, setState);
                      //   },
                      //   icon: Icon(Icons.clear, size: 16),
                      //   label: Text('Remove Media'),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.red,
                      //     foregroundColor: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (reviewController.text.trim().isNotEmpty) {
                        AppCubit.get(context).updateReview(
                          reviewId: review.uId!,
                          newReviewText: reviewController.text.trim(),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            }
        );
      },
    );
  }

  // Function to pick new image
  Future<void> _pickImage(String reviewId, StateSetter setState) async {

     // Show loading indicator

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        File imageFile = File(image.path);

        // Upload new image
        String? newImageUrl = await AppCubit.get(context)
            .uploadReviewImage(imageFile, reviewId);

        if (newImageUrl != null) {
          // Update review with new image
          await AppCubit.get(context).updateReview(
            reviewId: reviewId,
            newReviewText: null, // Don't change text
            newImageUrl: newImageUrl,
            removeVideo: true, // Remove video if exists
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image updated successfully')),
          );
        }
      }

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting image: $error')),
      );
    }
  }

  // Function to pick new video
  Future<void> _pickVideo(String reviewId, StateSetter setState) async {
    try {

      final ImagePicker picker = ImagePicker();
      final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

      if (video != null) {
        File videoFile = File(video.path);

        // Upload new video
        String? newVideoUrl = await AppCubit.get(context)
            .uploadReviewVideo(videoFile, reviewId);

        if (newVideoUrl != null) {
          // Update review with new video
          await AppCubit.get(context).updateReview(
            reviewId: reviewId,
            newReviewText: null, // Don't change text
            newVideoUrl: newVideoUrl,
            removeImage: true, // Remove image if exists
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Video updated successfully')),
          );
        }
      }

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting video: $error')),
      );
    }
  }

  // Function to remove image/video
  Future<void> _removeMedia(String reviewId, StateSetter setState) async {
    try {
      await AppCubit.get(context).updateReview(
        reviewId: reviewId,
        newReviewText: null, // Don't change text
        removeImage: true,
        removeVideo: true,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Media removed successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing media: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews', style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.sizeOf(context).height * 0.025
        )),
      ),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return state is GetCertificateLoadingState ?
          Center(child: CupertinoActivityIndicator()) :
          ModalProgressHUD(
            progressIndicator: CupertinoActivityIndicator(
              color: ColorManager.primary,
              radius: 20.0,
            ),
            inAsyncCall: isLoading,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final review = cubit.reviews[index];
                        final reviewType = _getReviewType(review);

                        return Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.sizeOf(context).height * 0.02,
                              right: MediaQuery.sizeOf(context).height * 0.02
                          ),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.black,
                                width: 1
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User information
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(review.userImage!),
                                  ),
                                  SizedBox(width: MediaQuery.sizeOf(context).height * 0.01),
                                  Expanded(
                                    child: Text(
                                      review.userName!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.sizeOf(context).height * 0.02
                                      ),
                                    ),
                                  ),
                                  // Content type indicator
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor(reviewType),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _getTypeLabel(reviewType),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),

                              // Review text
                              Text(
                                review.review!,
                                style: TextStyle(
                                    color: ColorManager.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.sizeOf(context).height * 0.014
                                ),
                              ),
                              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),

                              // Review content (image/video)
                              _buildReviewContent(review, reviewType),

                              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

                              // Action buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Reply button
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        customPushNavigator(context, RepliesManagementScreen(reviewId: review.uId!));
                                      },
                                      icon: Icon(Icons.visibility, color: Colors.green, size: 18),
                                    ),
                                  ),
                                  // Reply button
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        showReplyBottomSheet(review.uId!,review.fcmToken!);
                                      },
                                      icon: Icon(Icons.comment, color: ColorManager.dartGrey, size: 18),
                                    ),
                                  ),
                                  // Edit button
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        _showEditDialog(review, index);
                                      },
                                      icon: Icon(Icons.edit, color: ColorManager.grey, size: 18),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Delete button
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        _showDeleteConfirmation(review.uId!);
                                      },
                                      icon: Icon(Icons.delete, color: ColorManager.red, size: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: MediaQuery.sizeOf(context).height * 0.01);
                      },
                      itemCount: cubit.reviews.length
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height * 0.02),
                  child: DefaultButton(
                      color: ColorManager.primary,
                      text: 'Add New Review',
                      onPressed: (){
                        customPushNavigator(context, AddReviewScreen());
                      }
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(String uId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this review?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                AppCubit.get(context).deleteReviews(uId: uId);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.red,
              ),
              child: Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Color _getTypeColor(ReviewType type) {
    switch (type) {
      case ReviewType.textOnly:
        return Colors.blue;
      case ReviewType.textWithImage:
        return Colors.green;
      case ReviewType.textWithVideo:
        return Colors.purple;
    }
  }

  String _getTypeLabel(ReviewType type) {
    switch (type) {
      case ReviewType.textOnly:
        return 'Text';
      case ReviewType.textWithImage:
        return 'Image';
      case ReviewType.textWithVideo:
        return 'Video';
    }
  }
}

// Enum for review types
enum ReviewType {
  textOnly,
  textWithImage,
  textWithVideo,
}

// Widget for video thumbnail
class VideoThumbnail extends StatelessWidget {
  final String videoUrl;

  const VideoThumbnail({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You can use a library like video_thumbnail to create thumbnails
    return Container(
      width: double.infinity,
      color: Colors.grey[800],
      child: Icon(
        Icons.videocam,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}

// Full screen video display screen
class FullScreenVideoScreen extends StatefulWidget {
  final String videoUrl;

  const FullScreenVideoScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<FullScreenVideoScreen> createState() => _FullScreenVideoScreenState();
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_controller),
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
            ],
          ),
        )
            : CupertinoActivityIndicator(),
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}