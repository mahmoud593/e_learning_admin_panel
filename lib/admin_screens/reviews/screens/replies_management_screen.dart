import 'dart:io';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:video_player/video_player.dart';

class RepliesManagementScreen extends StatefulWidget {
  final String reviewId;
  const RepliesManagementScreen({super.key, required this.reviewId});

  @override
  State<RepliesManagementScreen> createState() =>
      _RepliesManagementScreenState();
}

class _RepliesManagementScreenState extends State<RepliesManagementScreen> {
  final ImagePicker picker = ImagePicker();
  bool isLoaded=false;

  /// مسح الرد
  Future<void> deleteReply(String replyId, String mediaUrl) async {
    setState(() {
      isLoaded=true;
    });
    try {
      // لو فيه ميديا نمسحها من Storage
      if (mediaUrl.isNotEmpty) {
        await FirebaseStorage.instance.refFromURL(mediaUrl).delete();
      }
      await FirebaseFirestore.instance
          .collection('reviews')
          .doc(widget.reviewId)
          .collection('replies')
          .doc(replyId)
          .delete();
      setState(() {
        isLoaded=false;

      });
    } catch (e) {
      debugPrint("Delete error: $e");
    }
  }

  /// تعديل الرد
  Future<void> editReply({
    required String replyId,
    required String oldMediaUrl,
    required String oldMediaType,
    required String oldText,
  }) async {
    final TextEditingController textController =
    TextEditingController(text: oldText);
    File? newMedia;
    String? newMediaType;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Reply"),
        content: StatefulBuilder(
          builder: (context, setStateDialog) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: textController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Edit reply text",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (newMedia != null)
                    newMediaType == "image"
                        ? Image.file(newMedia!, height: 100)
                        : const Icon(Icons.videocam, size: 50, color: Colors.red)
                  else if (oldMediaUrl.isNotEmpty && oldMediaType == "image")
                    Image.network(oldMediaUrl, height: 100)
                  else if (oldMediaUrl.isNotEmpty && oldMediaType == "video")
                      const Icon(Icons.videocam, size: 50, color: Colors.red),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final picked =
                          await picker.pickImage(source: ImageSource.gallery);
                          if (picked != null) {
                            setStateDialog(() {
                              newMedia = File(picked.path);
                              newMediaType = "image";
                            });
                          }
                        },
                        icon: const Icon(Icons.image, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () async {
                          final picked =
                          await picker.pickVideo(source: ImageSource.gallery);
                          if (picked != null) {
                            setStateDialog(() {
                              newMedia = File(picked.path);
                              newMediaType = "video";
                            });
                          }
                        },
                        icon: const Icon(Icons.videocam, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isLoaded=true;

              });
              Navigator.pop(context);

              String updatedMediaUrl = oldMediaUrl;
              String updatedMediaType = oldMediaType;

              // لو فيه ميديا جديدة نمسح القديمة ونرفع الجديدة
              if (newMedia != null && newMediaType != null) {
                if (oldMediaUrl.isNotEmpty) {
                  await FirebaseStorage.instance
                      .refFromURL(oldMediaUrl)
                      .delete();
                }
                String fileName =
                    "${DateTime.now().millisecondsSinceEpoch}.${newMediaType == 'image' ? 'jpg' : 'mp4'}";
                final ref =
                FirebaseStorage.instance.ref().child("replies/$fileName");
                await ref.putFile(newMedia!);
                updatedMediaUrl = await ref.getDownloadURL();
                updatedMediaType = newMediaType!;
              }

              // تحديث البيانات في Firestore
              await FirebaseFirestore.instance
                  .collection('reviews')
                  .doc(widget.reviewId)
                  .collection('replies')
                  .doc(replyId)
                  .update({
                'reply': textController.text.trim(),
                'mediaUrl': updatedMediaUrl,
                'mediaType': updatedMediaType,
              });

              setState(() {
                isLoaded=false;

              });
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Replies")),
      body: ModalProgressHUD(
        inAsyncCall: isLoaded,
        progressIndicator: CupertinoActivityIndicator(
          color: ColorManager.primary,
          radius: 20.0,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('reviews')
              .doc(widget.reviewId)
              .collection('replies')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final replies = snapshot.data!.docs;

            if (replies.isEmpty) {
              return const Center(child: Text("No replies found"));
            }

            return ListView.builder(
              itemCount: replies.length,
              itemBuilder: (context, index) {
                final reply = replies[index];
                final replyData = reply.data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: (){
                    if (replyData['mediaType'] == 'video' && replyData['mediaUrl'] != '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenVideoScreen(videoUrl: replyData['mediaUrl']),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(replyData['reply'] ?? ''),
                            subtitle: Text(replyData['adminName'] ?? ''),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.orange),
                                  onPressed: () => editReply(
                                    replyId: reply.id,
                                    oldMediaUrl: replyData['mediaUrl'] ?? '',
                                    oldMediaType: replyData['mediaType'] ?? '',
                                    oldText: replyData['reply'] ?? '',
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deleteReply(
                                    reply.id,
                                    replyData['mediaUrl'] ?? '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            child: replyData['mediaType'] == "image" &&
                                replyData['mediaUrl'] != ''
                                ? Image.network(replyData['mediaUrl'],
                                width: 50, height: 50, fit: BoxFit.contain)
                                : replyData['mediaType'] == "video" &&
                                replyData['mediaUrl'] != ''
                                ? const Icon(Icons.videocam, color: Colors.red)
                                : const Icon(Icons.message),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
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
