import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_states.dart';
import 'package:e_learning_dathboard/data/models/certitifcate_model.dart';
import 'package:e_learning_dathboard/data/models/group_model.dart';
import 'package:e_learning_dathboard/data/models/material_model.dart';
import 'package:e_learning_dathboard/data/models/payment_model.dart';
import 'package:e_learning_dathboard/data/models/placement_model.dart';
import 'package:e_learning_dathboard/data/models/student_model.dart';
import 'package:e_learning_dathboard/data/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<UserModel> students = [];

  Future<void> getAllStudents({
    required String courseName,
    required String groupName,
  }) async {
    emit(GetAllStudentsLoadingState());
    students = [];
    await FirebaseFirestore.instance
        .collection('students')
        .doc(courseName)
        .collection(groupName)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        students.add(UserModel.fromMap(element.data()));
      });
      debugPrint(students[0].name);

      emit(GetAllStudentsSuccessState());
    }).catchError((error) {
      debugPrint('Error in getAllStudents is ${error.toString()}');
      emit(GetAllStudentsErrorState());
    });
  }

  List<StudentModel> officialStudents = [];
  List<StudentModel> notVerifiedStudents = [];

  Future<void> getAllOfficialStudents() async {
    emit(GetAllStudentsLoadingState());
    officialStudents = [];
    notVerifiedStudents = [];
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      value.docs.forEach((element) {

        if(StudentModel.fromMap(element.data()).isVerify==true){
          officialStudents.add(StudentModel.fromMap(element.data()));
        }else{
          notVerifiedStudents.add(StudentModel.fromMap(element.data()));
        }
      });
      emit(GetAllStudentsSuccessState());
    }).catchError((error) {
      debugPrint('Error in getAllStudents is ${error.toString()}');
      emit(GetAllStudentsErrorState());
    });
  }

  PlacementModel ?placementModel ;

  Future<void> getPlacementTests({
    required String courseName,
}) async {
    emit(GetPlacementTestsLoadingState());
    officialStudents = [];
    notVerifiedStudents = [];
    await FirebaseFirestore.instance
        .collection('placementTest')
        .doc(courseName)
        .collection('data')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        placementModel = PlacementModel.fromMap(element.data());
      });
      print('get Placement Success');
      emit(GetPlacementTestsSuccessState());
    }).catchError((error) {
      debugPrint('Error in getPlacementTests is ${error.toString()}');
      emit(GetPlacementTestsErrorState());
    });
  }



  /// delete confirmed user

  Future<void> deleteUser({
    required String userId,
  }) async {
    emit(DeleteUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .delete().then((value) {
      getAllOfficialStudents();
      emit(DeleteUserSuccessState());
      debugPrint('student Delete Success');
    }).catchError((error) {
      debugPrint('Error in delete student is ${error.toString()}');
      emit(DeleteUserErrorState());
    });
  }


  Future<void> verifiyUser({
    required String userId,
  }) async {
    emit(DeleteUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .update({
      'isVerify':true
    }).then((value) {
      getAllOfficialStudents();
      emit(DeleteUserSuccessState());
      debugPrint('student Verifiy Success');
    }).catchError((error) {
      debugPrint('Error in Verifiy student is ${error.toString()}');
      emit(DeleteUserErrorState());
    });
  }



  String url= "";

  bool isUpload=true;

  /// upload pdf and get PDF Free Notes
  Future uploadPdf({
    required String title,
    int index=0,
    required String section,
  })async{
    isUpload=true;
    emit(UploadPDFLoadingState());
    print('start upload');
    FilePickerResult? result=await FilePicker.platform.pickFiles();
    try{
      File pick= File(result!.files.single.path.toString());
      var file =pick.readAsBytesSync();
      isUpload=false;
      String name =DateTime.now().millisecondsSinceEpoch.toString();

      // upload to firebase
      var pdfFile =  FirebaseStorage.instance.ref().child('test')
          .child('Section')
          .child('Pdf')
          .child(title)
          .child('$name.pdf');

      UploadTask task= pdfFile.putData(file);
      TaskSnapshot snapshot=await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);

      MaterialModel materialModel=MaterialModel(
          title: title,
          url: url,
          uId: ''
      );

      await FirebaseFirestore.instance.collection('freeNotes').doc(section).collection('Pdf')
          .add(materialModel.toMap()).then((value) {
        print('Upload Success');
        FirebaseFirestore.instance.collection('freeNotes').doc(section).collection('Pdf').doc(value.id).update({
          'uId':value.id
        });
        getAllFreeNotes(section: section);
        isUpload=true;
        emit(UploadPDFSuccessState());
      }).catchError((error){
        debugPrint('Error in upload pdf is ${error.toString()}');
        isUpload=true;
        emit(UploadPDFErrorState());
      });
    }catch(e){
      emit(UploadPDFErrorState());
    }
    }


    Future<void> getPdf({
     required String section,
    })async{

      emit(GetPDFLoadingState());
      await FirebaseFirestore.instance.collection('freeNotes')
          .doc(section).collection('Pdf').get().then((value) {
        print('get Success');
        emit(GetPDFSuccessState());
      }).catchError((error) {
        debugPrint('Error in get pdf is ${error.toString()}');
        emit(GetPDFErrorState());
      });

    }


  final player = AudioPlayer();

  String test='';
  Future<void> audioPlayerFunction({required String url,required int index})async{

    await player.play(UrlSource(url)).then((value)async {
       player.onPlayerComplete.listen((event) {
         ieltsTracksBool[index]=0;
         oxfordTracksBool[index]=0;
      });
      emit(GetAudioSuccessState());
    }).catchError((error){

      print('Error is ${error.toString()}');
      emit(GetAudioErrorState());
    });

  }
  bool isPlaying=false;

  Future<bool> pausePlayer(context) async {
    player.stop();
    Navigator.pop(context);
    test='';
    emit(GetAudioSuccessState());

    return isPlaying;
  }


//   Future<void> initVideoPlayer() async{
// .then((value) {
//         emit(GetVideoSuccessState());
//       }).catchError((error){
//
//         debugPrint('Error in get video is ${error.toString()}');
//         emit(GetVideoErrorState());
//       });
//   }

  List<MaterialModel> freeNotesList=[];

  Future<void> getAllFreeNotes({
    required String section,
  })async{
    freeNotesList=[];
    emit(GetFreeNotesLoadingState());
    await FirebaseFirestore.instance.collection('freeNotes')
        .doc(section).collection('Pdf').get().then((value) {

      freeNotesList=value.docs.map((e) => MaterialModel.fromMap(e.data())).toList();

      print('get Success');
      emit(GetFreeNotesSuccessState());
    }).catchError((error) {
      debugPrint('Error in get pdf is ${error.toString()}');
      emit(GetFreeNotesErrorState());
    });

  }

  // PDFDocument ?doc ;
  //
  // Future<void> preperPdfDocument({
  //  required String url,
  // })async{
  //   emit(PreperPdfLoadingState());
  // doc = await PDFDocument.fromURL(url);
  // print(doc);
  //
  // emit(PreperPdfSuccessState());
  // }


  /// Oxford Courses
  Future uploadOxfordCourses({
    required String title,
    int index=0,
    required String section,
  })async{
    isUpload=true;
    emit(UploadOxfordCoursesLoadingState());
    print('start upload');
    FilePickerResult? result=await FilePicker.platform.pickFiles();
    try{
      File pick= File(result!.files.single.path.toString());
      var file =pick.readAsBytesSync();
      isUpload=false;
      String name =DateTime.now().millisecondsSinceEpoch.toString();

      // upload to firebase
      var pdfFile =  FirebaseStorage.instance.ref().child('courses')
          .child('oxford')
          .child(section)
          .child('Pdf')
          .child(title)
          .child('$name.pdf');

      UploadTask task= pdfFile.putData(file);
      TaskSnapshot snapshot=await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);

      MaterialModel materialModel=MaterialModel(
          title: title,
          url: url,
          uId: ''
      );

      await FirebaseFirestore.instance.collection('coursesMaterial').doc('oxford').collection(section)
          .add(materialModel.toMap()).then((value) {
        print('Upload Success');
        FirebaseFirestore.instance.collection('coursesMaterial').doc('oxford').collection(section).doc(value.id).update({
          'uId':value.id
        });
        getOxfordCourses(section: section);
        isUpload=true;
        emit(UploadOxfordCoursesSuccessState());
      }).catchError((error){
        debugPrint('Error in Oxford Courses is ${error.toString()}');
        isUpload=true;
        emit(UploadOxfordCoursesErrorState());
      });
    }catch(e){
      emit(UploadOxfordCoursesErrorState());
    }
  }

  List<MaterialModel> oxfordCoursesList=[];
  List<int> oxfordTracksBool=List.generate(1000, (e) => 0);

  Future<void> getOxfordCourses({
    required String section,
  })async{
    oxfordCoursesList=[];
    emit(GetOxfordCoursesLoadingState());
    await FirebaseFirestore.instance.collection('coursesMaterial')
        .doc('oxford').collection(section).get().then((value) {

      oxfordCoursesList=value.docs.map((e) => MaterialModel.fromMap(e.data())).toList();

      print('get Courses Success');
      emit(GetOxfordCoursesSuccessState());
    }).catchError((error) {
      debugPrint('Error in Get Oxford Courses is ${error.toString()}');
      emit(GetOxfordCoursesErrorState());
    });

  }

  Future<void> getOxfordSpeakingCourses({
    required String section,
    required String filed,
  })async{
    oxfordCoursesList=[];
    emit(GetOxfordCoursesLoadingState());
    await FirebaseFirestore.instance.collection('coursesMaterial')
        .doc('oxford').collection(filed).doc(section).collection('data')
        .get().then((value) {

      oxfordCoursesList=value.docs.map((e) => MaterialModel.fromMap(e.data())).toList();

      print('get Courses Success');
      emit(GetOxfordCoursesSuccessState());
    }).catchError((error) {
      debugPrint('Error in Get Oxford Courses is ${error.toString()}');
      emit(GetOxfordCoursesErrorState());
    });

  }

  Future uploadOxfordSpeakingCourses({
    required String title,
    int index=0,
    required String section,
    required String filed,
  })async{
    isUpload=true;
    emit(UploadOxfordCoursesLoadingState());
    print('start upload');
    FilePickerResult? result=await FilePicker.platform.pickFiles();
    try{
      File pick= File(result!.files.single.path.toString());
      var file =pick.readAsBytesSync();
      isUpload=false;
      String name =DateTime.now().millisecondsSinceEpoch.toString();

      // upload to firebase
      var pdfFile =  FirebaseStorage.instance.ref().child('courses')
          .child('oxford')
          .child(section)
          .child('Pdf')
          .child(title)
          .child('$name.pdf');

      UploadTask task= pdfFile.putData(file);
      TaskSnapshot snapshot=await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);

      MaterialModel materialModel=MaterialModel(
          title: title,
          url: url,
          uId: ''
      );

      await FirebaseFirestore.instance.collection('coursesMaterial').doc('oxford').collection(filed)
          .doc(section).collection('data')
          .add(materialModel.toMap()).then((value) {
        print('Upload Success');
        FirebaseFirestore.instance.collection('coursesMaterial').doc('oxford').collection(filed)
            .doc(section).collection('data').doc(value.id).update({
          'uId':value.id
        });
        getOxfordSpeakingCourses(section: section,filed:filed );
        isUpload=true;
        emit(UploadOxfordCoursesSuccessState());
      }).catchError((error){
        debugPrint('Error in Oxford Courses is ${error.toString()}');
        isUpload=true;
        emit(UploadOxfordCoursesErrorState());
      });
    }catch(e){
      emit(UploadOxfordCoursesErrorState());
    }
  }

  /// IELTS Courses
  Future uploadIeltsCourses({
    required String title,
    int index=0,
    required String section,
  })async{
    isUpload=true;
    emit(UploadIeltsCoursesLoadingState());
    print('start upload');
    FilePickerResult? result=await FilePicker.platform.pickFiles();
    try{
      File pick= File(result!.files.single.path.toString());
      var file =pick.readAsBytesSync();
      isUpload=false;
      String name =DateTime.now().millisecondsSinceEpoch.toString();

      // upload to firebase
      var pdfFile =  FirebaseStorage.instance.ref().child('courses')
          .child('ielts')
          .child(section)
          .child('Pdf')
          .child(title)
          .child('$name.pdf');

      UploadTask task= pdfFile.putData(file);
      TaskSnapshot snapshot=await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);

      MaterialModel materialModel=MaterialModel(
          title: title,
          url: url,
          uId: ''
      );

      await FirebaseFirestore.instance.collection('coursesMaterial').doc('ielts').collection(section)
          .add(materialModel.toMap()).then((value) {
        print('Upload Success');
        FirebaseFirestore.instance.collection('coursesMaterial').doc('ielts').collection(section).doc(value.id).update({
          'uId':value.id
        });
        getIeltsCourses(section: section);
        isUpload=true;
        emit(UploadIeltsCoursesSuccessState());
      }).catchError((error){
        debugPrint('Error in IELTS Courses is ${error.toString()}');
        isUpload=true;
        emit(UploadIeltsCoursesErrorState());
      });
    }catch(e){
      emit(UploadIeltsCoursesErrorState());
    }
  }

  List<MaterialModel> ieltsCoursesList=[];
  List<int> ieltsTracksBool=List.generate(1000, (e) => 0);

  Future<void> getIeltsCourses({
    required String section,
  })async{
    ieltsCoursesList=[];
    emit(GetIeltsCoursesLoadingState());
    await FirebaseFirestore.instance.collection('coursesMaterial')
        .doc('ielts').collection(section).get().then((value) {

      ieltsCoursesList=value.docs.map((e) => MaterialModel.fromMap(e.data())).toList();

      print('get Courses Success');
      emit(GetIeltsCoursesSuccessState());
    }).catchError((error) {
      debugPrint('Error in Get Ielts Courses is ${error.toString()}');
      emit(GetIeltsCoursesErrorState());
    });

  }

  Future<void> getIeltsSpeakingCourses({
    required String section,
  })async{
    ieltsCoursesList=[];
    emit(GetIeltsCoursesLoadingState());
    await FirebaseFirestore.instance.collection('coursesMaterial')
        .doc('ielts').collection('speaking').doc(section).collection('data')
        .get().then((value) {

      ieltsCoursesList=value.docs.map((e) => MaterialModel.fromMap(e.data())).toList();

      print('get Courses Success');
      emit(GetIeltsCoursesSuccessState());
    }).catchError((error) {
      debugPrint('Error in Get Ielts Courses is ${error.toString()}');
      emit(GetIeltsCoursesErrorState());
    });

  }

  Future uploadIeltsSpeakingCourses({
    required String title,
    int index=0,
    required String section,
  })async{
    isUpload=true;
    emit(UploadIeltsCoursesLoadingState());
    print('start upload');
    FilePickerResult? result=await FilePicker.platform.pickFiles();
    try{
      File pick= File(result!.files.single.path.toString());
      var file =pick.readAsBytesSync();
      isUpload=false;
      String name =DateTime.now().millisecondsSinceEpoch.toString();

      // upload to firebase
      var pdfFile =  FirebaseStorage.instance.ref().child('courses')
          .child('ielts')
          .child(section)
          .child('Pdf')
          .child(title)
          .child('$name.pdf');

      UploadTask task= pdfFile.putData(file);
      TaskSnapshot snapshot=await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);

      MaterialModel materialModel=MaterialModel(
          title: title,
          url: url,
          uId: ''
      );

      await FirebaseFirestore.instance.collection('coursesMaterial').doc('ielts').collection('speaking')
          .doc(section).collection('data')
          .add(materialModel.toMap()).then((value) {
        print('Upload Success');
        FirebaseFirestore.instance.collection('coursesMaterial').doc('ielts').collection('speaking')
            .doc(section).collection('data').doc(value.id).update({
          'uId':value.id
        });
        getIeltsSpeakingCourses(section: section);
        isUpload=true;
        emit(UploadIeltsCoursesSuccessState());
      }).catchError((error){
        debugPrint('Error in IELTS Courses is ${error.toString()}');
        isUpload=true;
        emit(UploadIeltsCoursesErrorState());
      });
    }catch(e){
      emit(UploadIeltsCoursesErrorState());
    }
  }




  /// Cambridge Courses
  Future uploadCambridgeCourses({
    required String title,
    int index=0,
    required String section,
  })async{
    isUpload=true;
    emit(UploadCambridgeCoursesLoadingState());
    print('start upload');
    FilePickerResult? result=await FilePicker.platform.pickFiles();
    try{
      File pick= File(result!.files.single.path.toString());
      var file =pick.readAsBytesSync();
      isUpload=false;
      String name =DateTime.now().millisecondsSinceEpoch.toString();

      // upload to firebase
      var pdfFile =  FirebaseStorage.instance.ref().child('courses')
          .child('cambridge')
          .child(section)
          .child('Pdf')
          .child(title)
          .child('$name.pdf');

      UploadTask task= pdfFile.putData(file);
      TaskSnapshot snapshot=await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);

      MaterialModel materialModel=MaterialModel(
          title: title,
          url: url,
          uId: ''
      );

      await FirebaseFirestore.instance.collection('coursesMaterial').doc('cambridge').collection(section)
          .add(materialModel.toMap()).then((value) {
        print('Upload Success');
        FirebaseFirestore.instance.collection('coursesMaterial').doc('cambridge').collection(section).doc(value.id).update({
          'uId':value.id
        });
        getCambridgeCourses(section: section);
        isUpload=true;
        emit(UploadCambridgeCoursesSuccessState());
      }).catchError((error){
        debugPrint('Error in Cambridge Courses is ${error.toString()}');
        isUpload=true;
        emit(UploadCambridgeCoursesErrorState());
      });
    }catch(e){
      emit(UploadCambridgeCoursesErrorState());
    }
  }

  List<MaterialModel> cambridgeCoursesList=[];
  List<int> cambridgeTracksBool=List.generate(1000, (e) => 0);

  Future<void> getCambridgeCourses({
    required String section,
  })async{
    cambridgeCoursesList=[];
    emit(GetOxfordCoursesLoadingState());
    await FirebaseFirestore.instance.collection('coursesMaterial')
        .doc('cambridge').collection(section).get().then((value) {

      cambridgeCoursesList=value.docs.map((e) => MaterialModel.fromMap(e.data())).toList();

      print('get Courses Success');
      emit(GetCambridgeCoursesSuccessState());
    }).catchError((error) {
      debugPrint('Error in Get Cambridge Courses is ${error.toString()}');
      emit(GetCambridgeCoursesErrorState());
    });

  }

  Future<void> getCambridgeSpeakingCourses({
    required String section,
    required String filed,
  })async{
    cambridgeCoursesList=[];
    emit(GetCambridgeCoursesLoadingState());
    await FirebaseFirestore.instance.collection('coursesMaterial')
        .doc('cambridge').collection(filed).doc(section).collection('data')
        .get().then((value) {

      cambridgeCoursesList=value.docs.map((e) => MaterialModel.fromMap(e.data())).toList();

      print('get Courses Success');
      emit(GetCambridgeCoursesSuccessState());
    }).catchError((error) {
      debugPrint('Error in Get Cambridge Courses is ${error.toString()}');
      emit(GetCambridgeCoursesErrorState());
    });

  }

  Future uploadCambridgeSpeakingCourses({
    required String title,
    int index=0,
    required String section,
    required String filed,
  })async{
    isUpload=true;
    emit(UploadCambridgeCoursesLoadingState());
    print('start upload');
    FilePickerResult? result=await FilePicker.platform.pickFiles();
    try{
      File pick= File(result!.files.single.path.toString());
      var file =pick.readAsBytesSync();
      isUpload=false;
      String name =DateTime.now().millisecondsSinceEpoch.toString();

      // upload to firebase
      var pdfFile =  FirebaseStorage.instance.ref().child('courses')
          .child('cambridge')
          .child(section)
          .child('Pdf')
          .child(title)
          .child('$name.pdf');

      UploadTask task= pdfFile.putData(file);
      TaskSnapshot snapshot=await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);

      MaterialModel materialModel=MaterialModel(
          title: title,
          url: url,
          uId: ''
      );

      await FirebaseFirestore.instance.collection('coursesMaterial').doc('cambridge').collection(filed)
          .doc(section).collection('data')
          .add(materialModel.toMap()).then((value) {
        print('Upload Success');
        FirebaseFirestore.instance.collection('coursesMaterial').doc('cambridge').collection(filed)
            .doc(section).collection('data').doc(value.id).update({
          'uId':value.id
        });
        getCambridgeSpeakingCourses(section: section,filed:filed );
        isUpload=true;
        emit(UploadCambridgeCoursesSuccessState());
      }).catchError((error){
        debugPrint('Error in Cambridge Courses is ${error.toString()}');
        isUpload=true;
        emit(UploadCambridgeCoursesErrorState());
      });
    }catch(e){
      emit(UploadCambridgeCoursesErrorState());
    }
  }

 List<PaymentModel> paymentsImage=[];

  Future<void> getPaymentImage()async{
    paymentsImage=[];
    emit(GetPaymentsImagesLoadingState());
    try{
      var response =await FirebaseFirestore.instance.collection('paymentImages').get();
      response.docs.forEach((element) {
        paymentsImage.add(PaymentModel.fromMap(element.data()));
      });
      emit(GetPaymentsImagesSuccessState());
    }catch (e){
      emit(GetPaymentsImagesErrorState());
    }
  }

  Future<void> deletePaymentImage({required String uId})async{
    emit(DeletePaymentsLoadingState());
    try{
      var response =await FirebaseFirestore.instance.collection('paymentImages')
          .doc(uId).delete();
      getPaymentImage();
      emit(DeletePaymentsSuccessState());
    }catch (e){
      emit(DeletePaymentsErrorState());
    }
  }

  Future<void> verifiyUserPaid({required String userId,required String paymentId})async{
    emit(VerifiyUserLoadingState());
    try{
      var response =await FirebaseFirestore.instance.collection('users')
          .doc(userId).update({
        'isPayment':true
      });
      deletePaymentImage(uId: paymentId);
      emit(VerifiyUserSuccessState());
    }catch (e){
      emit(VerifiyUserErrorState());
    }
  }

  List<CertitifcateModel> certificates=[];

  Future<void> getCertificates()async{
    certificates=[];
    emit(GetCertificateLoadingState());
    try{
      var response =await FirebaseFirestore.instance.collection('certificates').get();
      response.docs.forEach((element) {
        certificates.add(CertitifcateModel.fromMap(element.data()));
      });
      emit(GetCertificateSuccessState());
    }catch (e){
      emit(GetCertificateErrorState());
    }
  }

  Future<void> deleteCertificates({
    required String uId,
})async{
    emit(DeleteCertificateLoadingState());
    try{
      var response =await FirebaseFirestore.instance.collection('certificates')
          .doc(uId).delete();
       getCertificates();
      emit(DeleteCertificateSuccessState());
    }catch (e){
      emit(DeleteCertificateErrorState());
    }
  }

  Future<void> uploadCertificates({
   required String certificateName,
   required String certificateLink,
   required String certificateImage,
  })async{
    CertitifcateModel certitifcateModel=CertitifcateModel(
        certificateImage: certificateImage,
        certificateLink: certificateLink,
        certificateName: certificateName,
        uId: ''
    );
    emit(UploadCertificateLoadingState());
    try{
      await FirebaseFirestore.instance.collection('certificates')
          .add(certitifcateModel.toMap()).then((value) async{

        await FirebaseFirestore.instance.collection('certificates')
            .doc(value.id).update({
          'uId':value.id
        });
      });
      emit(UploadCertificateSuccessState());
    }catch (e){
      emit(UploadCertificateErrorState());
    }
  }


  List<GroupModel> groups=[];

  Future<void> getAllGroups({
    required String courseName,
  })async{
    groups=[];
    emit(GetGroupsLoadingState());
    try{
      var response =await FirebaseFirestore.instance.collection('groups')
          .doc(courseName)
          .collection('data')
          .get();
      response.docs.forEach((element) {
        groups.add(GroupModel.fromMap(element.data()));
      });
      print(groups.length);
      print('get Groups Success');
      emit(GetGroupsSuccessState());
    }catch (e){
      print('get Groups Error ${e.toString()}');
      emit(GetGroupsErrorState());
    }
  }

  Future<void> deleteGroups({
    required String courseName,
    required String uId,
  })async{
    emit(DeleteGroupsLoadingState());
    try{
      var response =await FirebaseFirestore.instance.collection('groups')
          .doc(courseName)
          .collection('data')
          .doc(uId).delete();
      getAllGroups(courseName: courseName);
      emit(DeleteGroupsSuccessState());
    }catch (e){
      emit(DeleteGroupsErrorState());
    }
  }

  Future<void> uploadGroups({
    required String courseName,
    required String section,
    required int count,
    required String endDate,
    required String endTime,
    required String startDate,
    required String startTime,
    required bool status,
  })async{
    emit(UploadGroupsLoadingState());
    GroupModel groupModel=GroupModel(
        count: count,
        endDate: endDate,
        endTime: endTime,
        courseName: courseName,
        startDate: startDate,
        startTime: startTime,
        status: status,
        uId: ''
    );

    try{
      await FirebaseFirestore.instance.collection('groups')
          .doc(section)
          .collection('data')
          .add(groupModel.toMap()).then((value) async{

            await FirebaseFirestore.instance.collection('groups')
            .doc(section)
            .collection('data')
            .doc(value.id).update({
              'uId':value.id
            });
          });
      getAllGroups(courseName: section);
      emit(UploadGroupsSuccessState());
    }catch (e){
      emit(UploadGroupsErrorState());
    }
  }


  File? uploadedCertificateImage;
  var imagePicker = ImagePicker();

  Future <void> getCertificateImage() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      uploadedCertificateImage = File(pickedFile.path);
      emit(GetLocalCertificateSuccessState());
    } else {
      debugPrint('No Image selected.');
      emit(GetLocalCertificateErrorState());
    }
  }

  Future<void> uploadCertificateImage({
    required String certificateName,
    required String certificateLink,
}) async {
    emit(UploadCertificateLoadingState());
    FirebaseStorage.instance.ref()
        .child('certificateImages/${Uri.file(uploadedCertificateImage!.path)
        .pathSegments.last}').putFile(uploadedCertificateImage!).then((link){
      link.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance.collection('certificates').add({
          'certificateImage': value.toString(),
          'certificateLink': certificateLink,
          'certificateName': certificateName,
          'uId': '',
        }).then((value) {
          FirebaseFirestore.instance.collection('certificates').doc(value.id).update({
            'uId':value.id
          });
          getCertificates();
          emit(UploadCertificateSuccessState());
        });
      }).catchError((error){
        emit(UploadCertificateErrorState());
      });
    }).catchError((error){
      emit(UploadCertificateErrorState());
    });
  }

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();

  void addStartDate({required String value}){
    startDateController.text=value;
    emit(AddStartDateState());
  }

  void addEndDate({required String value}){
    endDateController.text=value;
    emit(AddEndDateState());
  }

  void addStartTime({required String value}){
    startTimeController.text=value;
    emit(AddStartTimeState());
  }

  void addEndTime({required String value}){
    endTimeController.text=value;
    emit(AddEndTimeState());
  }

  bool switchValue=false;
  void addSwitchValue({required bool value}){
    switchValue=value;
    emit(SwitchStatusState());
  }

}