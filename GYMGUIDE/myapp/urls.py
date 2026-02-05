
from django.contrib import admin
from django.urls import path

from myapp import views


urlpatterns = [
    path('admin/', admin.site.urls),

    path('logout/',views.logout),
    path('admin_home/',views.admin_home),
    path('login/',views.loginget),
    path('loginpost/',views.loginpost),

    path('admin_viewtrainer/',views.admin_viewtrainerget),
    path('admin_viewtrainerpost/', views.admin_viewtrainerpost),

    path('admin_viewapprovedtrainerget/', views.admin_viewapprovedtrainerget),
    path('admin_viewapprovedtrainerpost/', views.admin_viewapprovedtrainerpost),


    path('admin_viewrejectedtrainerget/', views.admin_viewrejectedtrainerget),
    path('admin_viewrejectedtrainerpost/', views.admin_viewrejectedtrainerpost),

    path('approve_trainer/<id>', views.approve_trainer),
    path('reject_trainer/<id>', views.reject_trainer),

    path('admin_viewuser/', views.admin_viewuser),
    path('admin_viewuserpost/', views.admin_viewuserpost),

    path('admin_facility/', views.admin_facility),
    path('admin_facilitypost/', views.admin_facilitypost),

    path('admin_viewfacilityget/', views.admin_viewfacilityget),
    path('admin_viewfacilitypost/', views.admin_viewfacilitypost),

    path('admin_editfacility/<id>', views.admin_editfacility),
    path('admin_editfacilitypost/', views.admin_editfacilitypost),
    path('delete_facility/<id>', views.delete_facility),

    path('admin_serviceplanget/', views.admin_serviceplanget),
    path('admin_serviceplanpost/', views.admin_serviceplanpost),
    path('admin_viewclassplan/', views.admin_viewclassplan),
    path('add_attendance_request/<id>', views.add_attendance_request),
    path('admin_add_attendance/<id>', views.admin_add_attendance),

    path('admin_add_attendance_post/', views.admin_add_attendance_post),
    path('admin_viewserviceplanget/', views.admin_viewserviceplanget),
    path('admin_viewserviceplanpost/', views.admin_viewserviceplanpost),

    path('admin_editservice/<id>', views.admin_editservice),
    path('admin_editservicepost/', views.admin_editservicepost),
    path('delete_serviceplan/<id>', views.delete_serviceplan),

    path('admin_viewuserpayments/', views.admin_viewuserpayments),
    path('admin_viewuserpayments_post/', views.admin_viewuserpayments_post),

    path('admin_viewcomplaintandsendreply/', views.admin_viewcomplaintandsendreply),
    path('admin_viewcomplaintandsendreply_post/', views.admin_viewcomplaintandsendreply_post),

    path('admin_sendreply/<cid>', views.admin_sendreply),
    path('admin_sendreply_post/', views.admin_sendreply_post),

    path('admin_viewreview/', views.admin_viewreview),
    path('admin_viewreview_post/', views.admin_viewreview_post),

    path('admin_changepassword/', views.admin_changepassword),
    path('admin_changepassword_post/', views.admin_changepassword_post),
    path('admin_view_progress/<id>', views.admin_view_progress),


    ###trainer
    path('triner_signupget/', views.triner_signupget),
    path('triner_signuppost/', views.triner_signuppost),
    path('trainer_home/', views.trainer_home),
    path('trainer_viewprofile/', views.trainer_viewprofile),
    path('chat/<id>', views.chat1),
    path('chat_view/', views.chat_view),
    path('chat_send/<msg>', views.chat_send),
    path('User_sendchat/', views.User_sendchat),

    path('edit_trainer_profile/', views.edit_trainer_profile),
    path('edit_trainer_profile_post/', views.edit_trainer_profile_post),
    path('trainer_view_serviceplan/', views.trainer_view_serviceplan),
    path('trainer_view_serviceplan_post/', views.trainer_view_serviceplan_post),
    path('trainer_manage_workoutplan/<id>', views.trainer_manage_workoutplan),
    path('trainer_manage_workoutplan_post/', views.trainer_manage_workoutplan_post),
    path('trainer_view_workoutplan/<id>', views.trainer_view_workoutplan),
    path('trainer_view_workoutplan_POST/', views.trainer_view_workoutplan_POST),
    path('delete_workoutplan/<id>', views.delete_workoutplan),
    path('trainer_editworkoutplan/<id>', views.trainer_editworkoutplan),
    path('trainer_edit_post/', views.trainer_edit_post),
    path('trainer_manage_dietplan/<id>', views.trainer_manage_dietplan),
    path('trainer_manage_dietplan_post/', views.trainer_manage_dietplan_post),
    path('trainer_editdietplan/<id>', views.trainer_editdietplan),
    path('trainer_editdietplan_post/', views.trainer_editdietplan_post),
    path('trainer_viewdietplan/<id>', views.trainer_viewdietplan),
    path('delete_dietplan/<id>', views.delete_dietplan),
    path('trainer_manage_tips/<id>', views.trainer_manage_tips),
    path('trainer_manage_tips_post/', views.trainer_manage_tips_post),
    path('trainer_viewtips/<id>', views.trainer_viewtips),
    path('trainer_viewtips_post/', views.trainer_viewtips_post),
    path('trainer_edittips/<id>', views.trainer_edittips),
    path('trainer_edittips_post/', views.trainer_edittips_post),
    path('delete_tips/<id>', views.delete_tips),
    path('trainer_viewrequestorapproverequest/', views.trainer_viewrequestorapproverequest),
    path('approve_userrequest/<id>', views.approve_userrequest),
    path('reject_userrequest/<id>', views.reject_userrequest),
    path('trainer_viewrequestorapproverequest_post/', views.trainer_viewrequestorapproverequest_post),
    path('trainer_viewapprovedrequest/', views.trainer_viewapprovedrequest),
    path('trainer_viewapprovedrequest_post/', views.trainer_viewapprovedrequest_post),
    path('trainer_viewrejectedreq/', views.trainer_viewrejectedreq),
    path('trainer_viewrejectedreq_post/', views.trainer_viewrejectedreq_post),
    path('trainer_changepassword/', views.trainer_changepassword),
    path('trainer_changepassword_post/', views.trainer_changepassword_post),
    path('view_user_payment/<id>', views.view_user_payment),
    path('user_payment/', views.user_payment),

    path('trainer_viewfacilityget/', views.trainer_viewfacilityget),
    path('trainer_viewfacilitypost/', views.trainer_viewfacilitypost),

    path('add_schedule/', views.add_schedule),
    path('add_schedule_post/', views.add_schedule_post),
    path('trainer_viewschedule/', views.trainer_viewschedule),
    path('trainer_viewschedulepost/', views.trainer_viewschedulepost),
    path('delete_schedule/<id>', views.delete_schedule),
    path('delete_class/<id>', views.delete_class),
    path('trainer_viewclassplan/<id>', views.trainer_viewclassplan),
    path('trainer_manage_classplan/<id>', views.trainer_manage_classplan),
    path('trainer_manage_classplan_post/', views.trainer_manage_classplan_post),


    path('add_diet_chart/', views.add_diet_chart),
    path('add_diet_chart_post/', views.add_diet_chart_post),
    path('View_diet_chart/', views.View_diet_chart),
    path('View_diet_chart_post/', views.View_diet_chart_post),
    path('delete_diet_chart/<id>', views.delete_diet_chart),
    path('Edit_diet_chart/<id>', views.Edit_diet_chart),
    path('Edit_diet_chart_post/', views.Edit_diet_chart_post),
    path('openingpage/', views.openingpage),
    path('nutrition_detect/', views.nutrition_detect),
    path('trainer_view_progress/<id>', views.trainer_view_progress),





    ########user


    path('and_login/', views.login),
    path('user_viewprofile/', views.viewprofile),
    path('editprofile/', views.editprofile),
    path('signup/', views.signup),
    path('viewtrainers/', views.viewtrainers),
    path('sendtrainerrequest/', views.sendtrainerrequest),
    path('sendcomplaint/', views.sendcomplaint),
    path('viewreply/', views.viewreply),
    path('sendreview/', views.sendreview),
    path('user_view_req_status/', views.user_view_req_status),
    path('User_sendchat/', views.User_sendchat),
    path('User_viewchat/', views.User_viewchat),
    path('viewserviceplan/', views.viewserviceplan),
    path('viewworkoutplan/', views.viewworkoutplan),
    path('viewdietplan/', views.viewdietplan),
    path('viewtips/', views.viewtips),
    path('chatwithuser/', views.chatwithuser),
    path('viewmotivationalvideos/', views.viewmotivationalvideos),
    path('viewworkoutvideo/', views.viewworkoutvideo),
    path('tracktheirprogress/', views.tracktheirprogress),
    path('user_change_pass/', views.user_change_pass),
    path('viewreviewfromuser/', views.viewreviewfromuser),
    path('Get_health_pr/', views.Get_health_pr),
    path('Add_health_profile/', views.Add_health_profile),
    path('Edit_health_profile/', views.Edit_health_profile),
    path('Delete_health_profile/', views.Delete_health_profile),
    path('View_health_profile/', views.View_health_profile),
    path('viewprogress/', views.viewprogress),
    path('trainer_viewprogresst/', views.trainer_viewprogresst),
    path('viewtrainerschedule/', views.viewtrainerschedule),
    path('viewgymfacility/', views.viewgymfacility),
    path('viewclassplan/', views.viewclassplan),
    path('viewattendance/', views.viewattendance),
    path('user_payment/', views.user_payment),

    path('download_report/', views.download_report, name='download_report'),
    path('download_trainer_report/', views.download_trainer_report, name='download_trainer_report'),
    path('download_user_report/', views.download_user_report, name='download_user_report'),
    # path('download/user-progress/', views.download_user_progress_report, name='download_user_progress_report'),
    path('download-user-progress-report/', views.download_user_progress_report, name='download_user_progress_report'),

]
