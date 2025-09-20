import 'package:e_learning_dathboard/admin_screens/free_note_screen/view/edit_material.dart';
import 'package:e_learning_dathboard/admin_screens/free_note_screen/view/upload_pdf.dart';
import 'package:e_learning_dathboard/admin_screens/open_pdf/open_pdf.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:e_learning_dathboard/widgets/navigate_to.dart';
import 'package:e_learning_dathboard/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MaterialScreen extends StatelessWidget {
  final String title;
  final String image;
  final String section;
  const MaterialScreen({super.key,required this.title,required this.image,required this.section});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorManager.white,
            surfaceTintColor: ColorManager.white,
            title: Text(
              section,
              style: TextStyle(
                color: ColorManager.black,
                fontSize: screenHeight * 0.025,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorManager.black,
                size: screenHeight * 0.025,
              ),
            ),
          ),
          body: BlocBuilder<AppCubit,AppStates>(
              builder:  (context,state){
                var cubit=AppCubit.get(context);
                return ModalProgressHUD(
                    inAsyncCall: state is DeleteFreeNotesLoadingState || state is GetFreeNotesLoadingState,
                    child: cubit.freeNotesList.isEmpty?
                    _buildEmptyState(context, title, screenHeight) :
                    _buildContentGrid(context, cubit, screenHeight, screenWidth)
                );
              }
          ),
          floatingActionButton: _buildFloatingActionButton(context, title, section, screenHeight),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, String title, double screenHeight) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(screenHeight * 0.03),
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIconByType(title),
              size: screenHeight * 0.08,
              color: ColorManager.primary,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            'No $title Available',
            style: TextStyle(
              color: ColorManager.black,
              fontSize: screenHeight * 0.028,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Start by adding your first ${title.toLowerCase()}',
            style: TextStyle(
              color: ColorManager.grey,
              fontSize: screenHeight * 0.018,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentGrid(BuildContext context, AppCubit cubit, double screenHeight, double screenWidth) {
    return Container(
      color: ColorManager.white,
      padding: EdgeInsets.symmetric(
        horizontal: screenHeight * 0.02,
        vertical: screenHeight * 0.01,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(screenWidth),
          childAspectRatio: 0.65,
          crossAxisSpacing: screenHeight * 0.02,
          mainAxisSpacing: screenHeight * 0.02,
        ),
        itemCount: cubit.freeNotesList.length,
        itemBuilder: (context, index) => _buildMaterialCard(
            context,
            cubit,
            index,
            screenHeight,
            screenWidth
        ),
      ),
    );
  }

  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth > 1200) return 4;
    if (screenWidth > 800) return 3;
    return 2;
  }

  Widget _buildMaterialCard(BuildContext context, AppCubit cubit, int index, double screenHeight, double screenWidth) {
    return Hero(
      tag: 'material_${cubit.freeNotesList[index].uId}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            navigateTo(context, OpenPdf(
              isImage: false,
              title: cubit.freeNotesList[index].title,
              pdfUrl: cubit.freeNotesList[index].url,
            ));
          },
          borderRadius: BorderRadius.circular(screenHeight * 0.02),
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(screenHeight * 0.02),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCardHeader(context, cubit, index, screenHeight),
                Expanded(child: _buildPdfPreview(cubit, index, screenHeight)),
                _buildCardFooter(context, cubit, index, screenHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context, AppCubit cubit, int index, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
            onPressed: () {
              _showDeleteConfirmation(context, cubit, index);
            },
            icon: Icons.delete_outline,
            color: ColorManager.red,
            screenHeight: screenHeight,
          ),
          _buildActionButton(
            onPressed: () {
              customPushNavigator(context, EditMaterial(
                section: section,
                url: cubit.freeNotesList[index].url,
                uId: cubit.freeNotesList[index].uId,
                title: cubit.freeNotesList[index].title,
              ));
            },
            icon: Icons.edit_outlined,
            color: ColorManager.grey,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
    required double screenHeight,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: screenHeight * 0.025),
        padding: EdgeInsets.all(screenHeight * 0.008),
        constraints: BoxConstraints(
          minWidth: screenHeight * 0.04,
          minHeight: screenHeight * 0.04,
        ),
      ),
    );
  }

  Widget _buildPdfPreview(AppCubit cubit, int index, double screenHeight) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: ColorManager.white.withOpacity(.95),
        borderRadius: BorderRadius.circular(screenHeight * 0.015),
        border: Border.all(
          color: ColorManager.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          SfPdfViewer.network(
            canShowScrollStatus: false,
            canShowPaginationDialog: false,
            canShowScrollHead: false,
            enableDoubleTapZooming: false,
            cubit.freeNotesList[index].url,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  ColorManager.primary.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardFooter(BuildContext context, AppCubit cubit, int index, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenHeight * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cubit.freeNotesList[index].title,
            style: TextStyle(
              color: ColorManager.white,
              fontSize: screenHeight * 0.022,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.01,
                  vertical: screenHeight * 0.005,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(screenHeight * 0.01),
                ),
                child: Text(
                  'PDF',
                  style: TextStyle(
                    color: ColorManager.white,
                    fontSize: screenHeight * 0.014,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _buildShareButton(context, cubit, index, screenHeight),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(BuildContext context, AppCubit cubit, int index, double screenHeight) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () async {
          await _shareMaterial(cubit, index);
        },
        icon: Icon(
          Icons.share_outlined,
          color: ColorManager.ovWhite,
          size: screenHeight * 0.022,
        ),
        padding: EdgeInsets.all(screenHeight * 0.008),
        constraints: BoxConstraints(
          minWidth: screenHeight * 0.035,
          minHeight: screenHeight * 0.035,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context, String title, String section, double screenHeight) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        elevation: 8,
        onPressed: () {
          if (title == 'Pdf') {
            customPushNavigator(context, UploadPdf(section: section));
          }
        },
        icon: Icon(
          _getActionIconByType(title),
          color: ColorManager.white,
          size: screenHeight * 0.025,
        ),
        label: Text(
          _getActionLabelByType(title),
          style: TextStyle(
            color: ColorManager.white,
            fontSize: screenHeight * 0.02,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  IconData _getIconByType(String type) {
    switch (type) {
      case 'Pdf':
        return Icons.picture_as_pdf_outlined;
      case 'Audio':
        return Icons.audiotrack_outlined;
      case 'Video':
        return Icons.video_library_outlined;
      default:
        return Icons.folder_outlined;
    }
  }

  IconData _getActionIconByType(String type) {
    switch (type) {
      case 'Pdf':
        return Icons.upload_file_outlined;
      case 'Audio':
        return Icons.audio_file_outlined;
      case 'Video':
        return Icons.video_call_outlined;
      default:
        return Icons.add;
    }
  }

  String _getActionLabelByType(String type) {
    switch (type) {
      case 'Pdf':
        return 'Upload PDF';
      case 'Audio':
        return 'Add Audio';
      case 'Video':
        return 'Add Video';
      default:
        return 'Add';
    }
  }

  void _showDeleteConfirmation(BuildContext context, AppCubit cubit, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Delete Material',
            style: TextStyle(
              color: ColorManager.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Are you sure you want to delete "${cubit.freeNotesList[index].title}"?',
            style: TextStyle(color: ColorManager.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: ColorManager.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                AppCubit.get(context).deletePdf(
                  section: section,
                  uId: cubit.freeNotesList[index].uId.toString(),
                );
              },
              child: Text(
                'Delete',
                style: TextStyle(color: ColorManager.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _shareMaterial(AppCubit cubit, int index) async {
    final courseTitle = '$section ';
    final lectureName = '${cubit.freeNotesList[index].title}';
    final courseUrl = cubit.freeNotesList[index].url;

    final message = '''
📚 *New Learning Opportunity!*
Course: $courseTitle
🎓 Lecture: $lectureName

Discover more about this course:
$courseUrl

Download the app now and explore all our courses:
📱 iOS: https://apps.apple.com/eg/app/english-with-dr-mohamed-ismail/id6740339979  
🤖 Android: https://play.google.com/store/apps/details?id=com.drismail.drismail
''';

    await Share.share(message);
  }
}