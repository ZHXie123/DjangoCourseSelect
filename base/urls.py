from django.urls import path
from base import views

urlpatterns = [
    path('', views.index, name='index'),
    path('signin/', views.signin, name='signin'),
    path('signout/', views.signout, name='signout'),
    path('register/', views.register, name='register'),
    path('get_auth_code/', views.get_auth_code, name='get_auth_code'),

    path('edit_avatar/', views.edit_avatar, name='edit_avatar'),
    path('edit_password/', views.edit_password, name='edit_password'),

    path('students/', views.students, name='students'),
    path('classes/', views.classes, name='classes'),
    path('course/', views.course, name='course'),
    path('teacher/', views.teacher, name='teacher'),

    #可视化
    #柱状图
    path("canlook/",views.CanLook,name='canLook'),
    path("canlook/get/",views.GetData,name='data'),

    #玫瑰图
    path("GetRadarData/",views.GetRadarData,name='get-radar-data'),

    #热力图
    path("GetHotData/",views.GetHotData,name="GetHotData"),

    #折线图
    path("GetLineData/",views.GetLineData,name="GetLineData"),


    #深度学习
    path("deepLearing",views.deepLearning.as_view(),name="learning"),

    #学生
    path('student/profile/', views.student_profile, name='student_profile'),
    path('course_select/', views.course_select, name='course_select'),
    path('StudentCourseScore',views.StudentCourseScore,name="StudentCourseScore"),

    #教师 
    path('teacher/profile/', views.teacher_profile, name='teacher_profile'),
    path('ScoreGive', views.teacherGiveScore, name='ScoreGive'),

    #管理员
    path('adminScore', views.adminControlScore, name='adminScore'),



]
