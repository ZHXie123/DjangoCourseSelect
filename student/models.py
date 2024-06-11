from django.db import models
from django.contrib.auth.models import AbstractUser

import os


def user_directory_path(instance, filename):
    return os.path.join('user_dir_path', instance.username, "avatars", filename)


class UserInfo(AbstractUser):
    avatar = models.ImageField(upload_to=user_directory_path, default='/static/images/default.png')
    password = models.CharField(max_length=100)
    role = models.CharField(max_length=32, default='student', verbose_name='用户角色')

    class Meta:
        db_table = "db_userinfo"

    def __str__(self):
        return self.username




class Classes(models.Model):
    name = models.CharField(max_length=32, verbose_name='班级名称')

    class Meta:
        db_table = "db_classes"

    def __str__(self):
        return self.name


class Course(models.Model):
    name = models.CharField(max_length=32, verbose_name='课程名称')
    credit = models.SmallIntegerField(default=3, verbose_name='课程学分')
    course_open_time = models.DateField(auto_now=True, verbose_name='开课时间')

    teacher = models.ForeignKey(to='Teacher', on_delete=models.CASCADE, related_name='teacher', null=True, blank=True)

    class Meta:
        db_table = "db_course"

    def __str__(self):
        return self.name


class Teacher(models.Model):

    name = models.CharField(max_length=32, verbose_name='老师姓名')
    phone = models.CharField(max_length=11, null=True, blank=True, verbose_name='老师手机号')
    
    GENDER_CHOICES = (
        (1, '男'),
        (2, '女'),
    )  # 定义性别选择项
    gender = models.SmallIntegerField(
        choices=GENDER_CHOICES,
        null=True,  # 允许该字段为 NULL
        blank=True,  # 允许表单不输入该字段
        verbose_name='性别'
    )
    age = models.IntegerField(  # 使用IntegerField来存储年龄
        null=True, 
        blank=True, 
        verbose_name='年龄'
    )
    major = models.ForeignKey(
        to='StudentMajor', 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True, 
        related_name='teachers',
        verbose_name='专业'
    )
    user = models.ForeignKey(
        to=UserInfo, 
        on_delete=models.CASCADE, 
        null=True, 
        blank=True,
        related_name='teacher',
        verbose_name='用户信息'
    )

    class Meta:
        db_table = "db_teacher"

    def __str__(self):
        return self.name


class StudentDetail(models.Model):
    gender_choice = (
        (0, '保密'),
        (1, '男'),
        (2, '女'),
    )
    gender = models.SmallIntegerField(
    choices=gender_choice,
    null=True,  # 允许该字段为 NULL
    blank=True,  # 允许表单不输入该字段
    verbose_name='性别'
)
    addr = models.CharField(max_length=64, null=True, blank=True, verbose_name='地址详情')
    majorId = models.ForeignKey(
        to='StudentMajor', 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True, 
        related_name='student_details',
        verbose_name='专业'
)
    

    class Meta:
        db_table = "db_student_detail"


class Student2Course(models.Model):
    student = models.ForeignKey(to='Student', on_delete=models.CASCADE,null=True, 
        blank=True,)
    course = models.ForeignKey(to='Course', on_delete=models.CASCADE,null=True, 
        blank=True,)
    choice_course_time = models.DateTimeField(auto_now_add=True, verbose_name='学生选课时间')

    score = models.FloatField(null=True, blank=True, verbose_name='成绩')

    class Meta:
        db_table = "db_student2course"


class Student(models.Model):
    name = models.CharField(max_length=32, verbose_name='学生姓名')
    age = models.SmallIntegerField(default=18, verbose_name='学生年龄',null=True)
    create_time = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')

    student_detail = models.OneToOneField(to=StudentDetail, on_delete=models.CASCADE, null=True, blank=True)

    classes = models.ForeignKey(to=Classes, on_delete=models.CASCADE, related_name='classes', null=True, blank=True)

    course = models.ManyToManyField(
        to='Course',
        through='Student2Course',
        through_fields=('student', 'course'),
        related_name='student_course',
        null=True, 
        blank=True,
    )

    user = models.OneToOneField(
        to=UserInfo, 
        on_delete=models.CASCADE, 
        related_name='student',
        null=True, 
        blank=True,
    )

    class Meta:
        db_table = "db_student"

    def __str__(self):
        return self.name


class StudentMajor(models.Model):

    MajorId = models.IntegerField()

    MajorName = models.CharField(max_length=32)

    class Meta:
        db_table = "db_major"

    def __str__(self):
        return self.MajorName

    