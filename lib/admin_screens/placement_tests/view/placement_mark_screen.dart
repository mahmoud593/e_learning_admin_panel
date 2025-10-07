import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_dathboard/admin_screens/open_pdf/open_pdf.dart';
import 'package:e_learning_dathboard/admin_screens/placement_tests/view/edit_placement_test_screen.dart';
import 'package:e_learning_dathboard/admin_screens/placement_tests/view/upload_placment_test.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PlacementMarkScreen extends StatefulWidget {
  final String title;
  final String section;
  final String type;
  const PlacementMarkScreen({super.key, required this.title, required this.section, required this.type});

  @override
  State<PlacementMarkScreen> createState() => _PlacementMarkScreenState();
}

class _PlacementMarkScreenState extends State<PlacementMarkScreen> {

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getPlacementTests(courseName: widget.section, type: 'marks');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: state is DeletePlacementTestLoadingState ,
            child: Container(
              color: ColorManager.white,
              child: cubit.placementTests.length > 0 ?
              GridView.builder(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: cubit.placementTests.length,
                itemBuilder: (context, index) {
                  final item = cubit.placementTests[index];
                  return InkWell(
                    onTap: () {
                      navigateTo(context, OpenPdf(
                        isImage: false,
                        title: 'Placement Test',
                        pdfUrl: item.link,
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.primary.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header Actions
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildActionButton(
                                  icon: Icons.delete_outline,
                                  color: ColorManager.red,
                                  onPressed: () {
                                    _showDeleteConfirmation(context, cubit, index);
                                  },
                                ),
                                _buildActionButton(
                                  icon: Icons.edit_outlined,
                                  color: ColorManager.grey,
                                  onPressed: () {
                                    customPushNavigator(
                                      context,
                                      EditPlacementTestScreen(
                                        section: widget.section,
                                        uId: item.uId,
                                        title: item.title,
                                        type: widget.type,
                                        url: item.link,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Preview
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: ColorManager.white.withOpacity(.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: CachedNetworkImage(
                                imageUrl: item.link,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context, url, error) {
                                  return SfPdfViewer.network(
                                    item.link,
                                    canShowScrollStatus: false,
                                    canShowPaginationDialog: false,
                                    canShowScrollHead: false,
                                  );
                                },
                              ),
                            ),
                          ),

                          // Footer
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    color: ColorManager.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: ColorManager.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'PDF',
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    _buildActionButton(
                                      icon: Icons.share_outlined,
                                      color: ColorManager.white,
                                      onPressed: () async {
                                        await _sharePlacementTest(item.title, item.link);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ): Center(child: Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                crossAxisAlignment:  CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.file_copy, color: ColorManager.primary, size: 64,),
                  const SizedBox(height: 16,),
                  Text('No Tests',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorManager.primary,
                        fontSize:  MediaQuery.of(context).size.height*0.02),),
                ],
              ),),
            ),
          ),

          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () {
              customPushNavigator(context, UploadPlacmentTest(
                type: 'file',
                section: widget.section,
              ));
            },
            label: Row(
              children: const [
                Icon(Icons.upload_file_outlined, color: Colors.white),
                SizedBox(width: 8),
                Text('Upload', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: 20),
        padding: const EdgeInsets.all(6),
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, AppCubit cubit, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(

        backgroundColor: ColorManager.white,
        title: const Text("Delete Test"),
        content: Text('Are you sure you want to delete "${cubit.placementTests[index].title}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.deletePlacementTest(
                type: widget.type,
                courseName: widget.section ,
                uId: cubit.placementTests[index].uId,
              );
            },
            child: Text("Delete", style: TextStyle(color: ColorManager.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _sharePlacementTest(String title, String url) async {
    final message = '''
📄 Placement Test: $title  

Test Link: $url

📱 iOS: https://apps.apple.com/eg/app/english-with-dr-mohamed-ismail/id6740339979  
🤖 Android: https://play.google.com/store/apps/details?id=com.drismail.drismail
''';
    await Share.share(message);
  }
}
