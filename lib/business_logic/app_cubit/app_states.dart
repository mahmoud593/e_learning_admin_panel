abstract class AppStates{


}

class InitialState extends AppStates{}

class GetAllStudentsSuccessState extends AppStates {}
class GetAllStudentsErrorState extends AppStates {}
class GetAllStudentsLoadingState extends AppStates {}

class DeleteUserLoadingState extends AppStates {}
class DeleteUserSuccessState extends AppStates {}
class DeleteUserErrorState extends AppStates {}

class UploadPDFSuccessState extends AppStates {}
class UploadPDFLoadingState extends AppStates {}
class UploadPDFErrorState extends AppStates {}

class GetPDFSuccessState extends AppStates {}
class GetPDFLoadingState extends AppStates {}
class GetPDFErrorState extends AppStates {}

class GetAudioSuccessState extends AppStates {}
class GetAudioLoadingState extends AppStates {}
class GetAudioErrorState extends AppStates {}

class GetFreeNotesSuccessState extends AppStates {}
class GetFreeNotesLoadingState extends AppStates {}
class GetFreeNotesErrorState extends AppStates {}

class PreperPdfSuccessState extends AppStates {}
class PreperPdfLoadingState extends AppStates {}

class GetIeltsCoursesSuccessState extends AppStates {}
class GetIeltsCoursesLoadingState extends AppStates {}
class GetIeltsCoursesErrorState extends AppStates {}

class UploadIeltsCoursesSuccessState extends AppStates {}
class UploadIeltsCoursesLoadingState extends AppStates {}
class UploadIeltsCoursesErrorState extends AppStates {}

class GetOxfordCoursesSuccessState extends AppStates {}
class GetOxfordCoursesLoadingState extends AppStates {}
class GetOxfordCoursesErrorState extends AppStates {}

class UploadOxfordCoursesSuccessState extends AppStates {}
class UploadOxfordCoursesLoadingState extends AppStates {}
class UploadOxfordCoursesErrorState extends AppStates {}

class UpdateOxfordSpeakingSuccessState extends AppStates {}
class UpdateOxfordSpeakingLoadingState extends AppStates {}
class UpdateOxfordSpeakingErrorState extends AppStates {}

class DeleteOxfordSpeakingSuccessState extends AppStates {}
class DeleteOxfordSpeakingLoadingState extends AppStates {}
class DeleteOxfordSpeakingErrorState extends AppStates {}

class UpdateIeltsSpeakingSuccessState extends AppStates {}
class UpdateIeltsSpeakingLoadingState extends AppStates {}
class UpdateIeltsSpeakingErrorState extends AppStates {}

class DeleteIeltsSpeakingSuccessState extends AppStates {}
class DeleteIeltsSpeakingLoadingState extends AppStates {}
class DeleteIeltsSpeakingErrorState extends AppStates {}

class UpdateCambridgetSpeakingSuccessState extends AppStates {}
class UpdateCambridgetSpeakingLoadingState extends AppStates {}
class UpdateCambridgetSpeakingErrorState extends AppStates {}

class DeleteCambridgetSpeakingSuccessState extends AppStates {}
class DeleteCambridgetSpeakingLoadingState extends AppStates {}
class DeleteCambridgetSpeakingErrorState extends AppStates {}

class DeleteOxfordCoursesSuccessState extends AppStates {}
class DeleteOxfordCoursesLoadingState extends AppStates {}
class DeleteOxfordCoursesErrorState extends AppStates {}

class UpdateOxfordCoursesSuccessState extends AppStates {}
class UpdateOxfordCoursesLoadingState extends AppStates {}
class UpdateOxfordCoursesErrorState extends AppStates {}

class DeleteIeltsCoursesSuccessState extends AppStates {}
class DeleteIeltsCoursesLoadingState extends AppStates {}
class DeleteIeltsCoursesErrorState extends AppStates {}

class UpdateIeltsCoursesSuccessState extends AppStates {}
class UpdateIeltsCoursesLoadingState extends AppStates {}
class UpdateIeltsCoursesErrorState extends AppStates {}

class DeleteCambridgeCoursesSuccessState extends AppStates {}
class DeleteCambridgeCoursesLoadingState extends AppStates {}
class DeleteCambridgeCoursesErrorState extends AppStates {}

class UpdateCambridgeCoursesSuccessState extends AppStates {}
class UpdateCambridgeCoursesLoadingState extends AppStates {}
class UpdateCambridgeCoursesErrorState extends AppStates {}

class GetCambridgeCoursesSuccessState extends AppStates {}
class GetCambridgeCoursesLoadingState extends AppStates {}
class GetCambridgeCoursesErrorState extends AppStates {}

class UploadCambridgeCoursesSuccessState extends AppStates {}
class UploadCambridgeCoursesLoadingState extends AppStates {}
class UploadCambridgeCoursesErrorState extends AppStates {}

class GetPlacementTestsSuccessState extends AppStates {}
class GetPlacementTestsLoadingState extends AppStates {}
class GetPlacementTestsErrorState extends AppStates {}

class GetPaymentsImagesSuccessState extends AppStates {}
class GetPaymentsImagesLoadingState extends AppStates {}
class GetPaymentsImagesErrorState extends AppStates {}

class GetCertificateSuccessState extends AppStates {}
class GetCertificateLoadingState extends AppStates {}
class GetCertificateErrorState extends AppStates {}

class AddReviewSuccessState extends AppStates {}
class AddReviewLoadingState extends AppStates {}
class AddReviewErrorState extends AppStates {}

class UploadCertificateSuccessState extends AppStates {}
class UploadCertificateLoadingState extends AppStates {}
class UploadCertificateErrorState extends AppStates {}

class UpdateCertificateSuccessState extends AppStates {}
class UpdateCertificateLoadingState extends AppStates {}
class UpdateCertificateErrorState extends AppStates {}

class GetLocalCertificateSuccessState extends AppStates {}
class GetLocalCertificateLoadingState extends AppStates {}
class GetLocalCertificateErrorState extends AppStates {}

class DeleteCertificateSuccessState extends AppStates {}
class DeleteCertificateLoadingState extends AppStates {}
class DeleteCertificateErrorState extends AppStates {}

class DeletePaymentsSuccessState extends AppStates {}
class DeletePaymentsLoadingState extends AppStates {}
class DeletePaymentsErrorState extends AppStates {}

class VerifiyUserSuccessState extends AppStates {}
class VerifiyUserLoadingState extends AppStates {}
class VerifiyUserErrorState extends AppStates {}

class GetGroupsSuccessState extends AppStates {}
class GetGroupsLoadingState extends AppStates {}
class GetGroupsErrorState extends AppStates {}

class DeleteGroupsSuccessState extends AppStates {}
class DeleteGroupsLoadingState extends AppStates {}
class DeleteGroupsErrorState extends AppStates {}


class UploadGroupsSuccessState extends AppStates {}
class UploadGroupsLoadingState extends AppStates {}
class UploadGroupsErrorState extends AppStates {}

class UpdateGroupsSuccessState extends AppStates {}
class UpdateGroupsLoadingState extends AppStates {}
class UpdateGroupsErrorState extends AppStates {}

class AddStartDateState extends AppStates {}
class AddEndDateState extends AppStates {}
class AddEndTimeState extends AppStates {}
class AddStartTimeState extends AppStates {}
class SwitchStatusState extends AppStates {}

class UpdateFreeNotesSuccessState extends AppStates {}
class UpdateFreeNotesLoadingState extends AppStates {}
class UpdateFreeNotesErrorState extends AppStates {}

class DeleteFreeNotesSuccessState extends AppStates {}
class DeleteFreeNotesLoadingState extends AppStates {}
class DeleteFreeNotesErrorState extends AppStates {}

class UpdateReviewLoadingState extends AppStates {}

class UpdateReviewSuccessState extends AppStates {}

class UpdateReviewErrorState extends AppStates {
  final String error;
  UpdateReviewErrorState(this.error);
}

class AddNotificationSuccessState extends AppStates {}
class AddNotificationLoadingState extends AppStates {}
class AddNotificationErrorState extends AppStates {}

class DeletePlacementTestSuccessState extends AppStates {}
class DeletePlacementTestLoadingState extends AppStates {}
class DeletePlacementTestErrorState extends AppStates {}

class UpdatePlacementTestSuccessState extends AppStates {}
class UpdatePlacementTestLoadingState extends AppStates {}
class UpdatePlacementTestErrorState extends AppStates {}