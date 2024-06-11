from itertools import count, product
from django.utils import timezone
from urllib import request
from django.shortcuts import get_object_or_404, render, HttpResponse, redirect
from PIL import Image, ImageDraw, ImageFont

from io import BytesIO
import random

from django.views import View
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import MultiLabelBinarizer
from django.db.models import Count

from base.predict import randomForest
from base.reg_forms import RegForm
from student import models
from utils.res import ResponseData
from django.http import HttpResponseRedirect, JsonResponse
from django.contrib import auth
from django.db import transaction
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from collections import Counter


def is_ajax(request):
    return request.headers.get('X-Requested-With') == 'XMLHttpRequest'

def index(request):
    return render(request, 'base/index.html', locals())


def signin(request):
    if is_ajax(request):
        if request.method == 'POST':
            res_dict = ResponseData()
            session_code = request.session.get('auth_code')
            auth_code = request.POST.get('auth_code')
            if auth_code.upper() != session_code.upper():
                res_dict.status = 4000
                res_dict.message = '验证码输入不正确!'
                return JsonResponse(res_dict.get_dict)
            username = request.POST.get('username')
            password = request.POST.get('password')
            user_obj = auth.authenticate(request, username=username, password=password)
            if user_obj:
                auth.login(request, user_obj)
                res_dict.message = '登录成功!'
            else:
                res_dict.status = 4000
                res_dict.message = '用户名或密码输入不正确!'
            return JsonResponse(res_dict.get_dict)
    return render(request, 'base/signin.html')


def signout(request):
    auth.logout(request)
    return redirect('base:index')


def register(request):
    form_obj = RegForm()
    if is_ajax(request):
        if request.method == 'POST':
            form_obj = RegForm(request.POST, request.FILES)
            if form_obj.is_valid():
                with transaction.atomic():
                    # 创建 UserInfo 记录
                    user_data = form_obj.cleaned_data
                    user = models.UserInfo.objects.create_user(
                        username=user_data['username'],
                        password=user_data['password'],
                        email=user_data['email'],
                        role=user_data['role'],
                        avatar=user_data.get('avatar', '/static/images/default.png')
                    )
                    
                    # 根据角色创建 Student 或 Teacher 记录
                    if user.role == 'student':
                        # 单独创建并保存 StudentDetail 实例
                        student_detail_data = {
                            'gender': form_obj.cleaned_data.get('gender'),
                            'addr': form_obj.cleaned_data.get('addr'),
                            'majorId': form_obj.cleaned_data.get('majorId')  # 确保获取专业ID
                        }
                        student_detail = models.StudentDetail.objects.create(**student_detail_data)
                        
                        # 创建学生记录并关联 student_detail
                        student_data = {
                            'name': user.username,
                            'age': form_obj.cleaned_data.get('age',20),
                            'create_time': timezone.now(),
                            'student_detail': student_detail,  # 关联 student_detail 实例
                            'classes': form_obj.cleaned_data.get('classes'),
                            'user':user
                        }
                        models.Student.objects.create(**student_data)
                    # ... 省略其他角色的处理 ...
                    # 这里可以添加登录逻辑或其他逻辑
                    return JsonResponse({'status': 2000, 'message': '注册成功'})
            else:
                error_data = form_obj.errors
                return JsonResponse({
                    'status': 4000,
                    'message': '注册失败',
                    'data': error_data
                }, status=400)
    return render(request, 'base/register.html', {'form_obj': form_obj})


def get_auth_code(request, size=(450, 35), mode="RGB", bg_color=(255, 255, 255)):
    """ 生成一个图片验证码 """
    _letter_cases = "abcdefghjkmnpqrstuvwxy"  # 小写字母，去除可能干扰的i，l，o，z
    _upper_cases = _letter_cases.upper()  # 大写字母
    _numbers = ''.join(map(str, range(3, 10)))  # 数字
    chars = ''.join((_letter_cases, _upper_cases, _numbers))

    width, height = size  # 宽高
    # 创建图形
    img = Image.new(mode, size, bg_color)
    draw = ImageDraw.Draw(img)  # 创建画笔

    def get_chars():
        """生成给定长度的字符串，返回列表格式"""
        return random.sample(chars, 4)

    def create_lines():
        """绘制干扰线"""
        line_num = random.randint(*(1, 2))  # 干扰线条数

        for i in range(line_num):
            # 起始点
            begin = (random.randint(0, size[0]), random.randint(0, size[1]))
            # 结束点
            end = (random.randint(0, size[0]), random.randint(0, size[1]))
            draw.line([begin, end], fill=(0, 0, 0))

    def create_points():
        """绘制干扰点"""
        chance = min(100, max(0, int(2)))  # 大小限制在[0, 100]

        for w in range(width):
            for h in range(height):
                tmp = random.randint(0, 100)
                if tmp > 100 - chance:
                    draw.point((w, h), fill=(0, 0, 0))

    def create_code():
        """绘制验证码字符"""
        char_list = get_chars()
        code_string = ''.join(char_list)  # 每个字符前后以空格隔开

        for i in range(len(char_list)):
            code_str = char_list[i]
            font = ImageFont.truetype('media/static/font/Rondal-Semibold.ttf', size=24)
            draw.text(((i + 1) * 75, 0), code_str, "red", font=font)

        return code_string

    create_lines()
    create_points()
    code = create_code()
    print(code)

    request.session['auth_code'] = code

    io_obj = BytesIO()
    img.save(io_obj, 'PNG')
    return HttpResponse(io_obj.getvalue())


def edit_avatar(request):
    if request.method == 'POST':
        new_avatar = request.FILES.get('new_avatar')
        if new_avatar:
            request.user.avatar = new_avatar
            request.user.save()
        return redirect('base:index')


def edit_password(request):
    if request.method == 'POST':
        old_password = request.POST.get('old_password')
        new_password = request.POST.get('new_password')
        is_right = request.user.check_password(old_password)
        if is_right:
            request.user.set_password(new_password)
            request.user.save()
            return redirect('base:signin')
        return HttpResponse('原密码错误!')


def students(request):
    student_queryset = models.Student.objects.all()
    #print(student_queryset)
    paginator = Paginator(student_queryset, 3)  # 每页显示3个学生
    total_pages = paginator.num_pages

    current_page = request.GET.get('page', 1)
    current_page = int(current_page)

    # 验证当前页码是否在有效范围内
    if current_page < 1 or current_page > total_pages:
        current_page = 1

    previous_page = current_page - 1
    next_page = current_page + 1

    # 获取当前页码的学生列表
    stu_list = paginator.get_page(current_page)

    # 计算页码范围
    page_ranges = []
    if current_page > 2:
        page_ranges.append(1)
    if current_page > 1:
        page_ranges.append(current_page - 1)
    page_ranges.append(current_page)
    if current_page < total_pages:
        page_ranges.append(current_page + 1)
    if current_page < total_pages - 1:
        page_ranges.append(total_pages)

    context = {
        'stu_list': stu_list,
        'current_page': current_page,
        'total_pages': total_pages,
        'page_ranges': page_ranges,
        'previous_page': previous_page,
        'next_page': next_page,
    }
    return render(request, 'base/students.html', context)


def classes(request):
    class_queryset = models.Classes.objects.all()
    return render(request, 'base/classes.html', locals())


def course(request):
    course_queryset = models.Course.objects.all()
    return render(request, 'base/course.html', locals())


def teacher(request):
    teacher_queryset = models.Teacher.objects.all()
    return render(request, 'base/teacher.html', locals())

def CanLook(request):
    return render(request,'CanLook.html',locals())

#柱状图
def GetData(request):
    # 查询所有课程
    all_courses = models.Course.objects.all()
    # 查询所有专业
    all_majors = models.StudentMajor.objects.all()

    # 准备数据结构
    data = {
        'seriesData': []
    }
    
    # 为每个专业准备一个包含所有课程的列表
    for major in all_majors:
        major_data = {
            'name': major.MajorName,
            'courses': []
        }
        for course in all_courses:
            # 查询每门课程在该专业的选课学生数量
            student_count = models.Student2Course.objects.filter(
                course=course,
                student__student_detail__majorId=major  # 假设学生的专业通过 student_detail 与 StudentMajor 关联
            ).count()
            major_data['courses'].append({
                'name': course.name,
                'num_students': student_count
            })
        data['seriesData'].append(major_data)
    
    return JsonResponse(data)

#雷达图
def GetRadarData(request):
    # 获取所有课程名称
    courses = models.Course.objects.all()
    course_names = [course.name for course in courses]  # 提取课程名称

    # 获取所有学生及其成绩
    students = models.Student.objects.all()
    radar_data = {
        'indicator': course_names,
        'series': []
    }

    for student in students:
        student_data = {
            'name': student.name,
            'data': []
        }
        # 获取学生的成绩，如果存在的话
        student_courses = models.Student2Course.objects.filter(student=student)
        scores = student_courses.values_list('score', flat=True)
        student_data['data'] = list(scores)  # 这里直接使用查询结果作为成绩列表
        # 如果成绩列表长度小于课程数量，用0填充
        student_data['data'] += [0] * (len(course_names) - len(student_data['data']))
        radar_data['series'].append(student_data)

    return JsonResponse(radar_data)

#热力图
def GetHotData(request):
    # 获取所有课程和专业
    courses = models.Course.objects.all()
    majors = models.StudentMajor.objects.all()

    # 初始化热力图数据字典
    resultMap = {}

    # 创建一个课程和专业的笛卡尔积，用于填充热力图
    for major, course in product(majors, courses):
        # 统计每个专业选每门课程的学生人数
        student_count = models.Student2Course.objects.filter(
            student__student_detail__majorId=major,
            course=course
        ).count()
        # 将统计结果存储到热力图数据字典中
        # 使用字符串作为键，格式为 "专业名-课程名"
        key = f"{major.MajorName}-{course.name}"
        resultMap[key] = student_count

    # 获取最大选课人数，用于热力图颜色映射
    max_value = max(resultMap.values()) if resultMap else 0

    # 准备 X 轴和 Y 轴的数据
    XData = [course.name for course in courses]
    YData = [major.MajorName for major in majors]

    # 准备返回的 JSON 数据
    data = {
        'XData': XData,
        'YData': YData,
        'resultMap': resultMap,
        'max': max_value
    }
    return JsonResponse(data)

def GetLineData(request):
    # 获取所有专业及其对应的学生人数
    major_data = models.StudentMajor.objects.annotate(student_count=Count('student_details'))

    # 准备 X 轴和 Y 轴的数据
    Xdata = [major.MajorName for major in major_data]  # 专业名称作为 X 轴数据
    Ydata = [major.student_count for major in major_data]  # 学生人数作为 Y 轴数据

    # 准备返回的 JSON 数据
    data = {
        'courseChineseName': Xdata,  # 专业名称
        'courseSelectTime': Ydata,   # 学生人数
    }
    return JsonResponse(data)


class deepLearning(View):
    def get(self,request):

        class_list = models.Classes.objects.values_list('name', flat=True).distinct()
        class_list = list(class_list)  # 转换为列表
        print(class_list)

        classes = []
        for i in range(len(class_list)):
            classes.append((i+1,class_list[i]))
        print(classes)

        # 定义地区列表
        regions = [
            "北京", "上海", "天津", "重庆",
            "河北", "山西", "辽宁", "吉林", "黑龙江",
            "江苏", "浙江", "安徽", "福建", "江西", "山东", "河南", "湖北", "湖南", "广东", "海南",
            "四川", "贵州", "云南", "陕西", "甘肃", "青海", "内蒙古", "广西", "西藏", "宁夏", "新疆",
            "香港", "澳门"
        ]

        # 创建一个包含 (id, region) 形式的地区列表
        regions_list = [(i+1, region) for i, region in enumerate(regions)]
        print(regions_list)
        
        
        return render(request,'predict.html',locals())
    
    def post(self,request):

        
        age = int(request.POST.get("age"))
        gender = int(request.POST.get("gender"))  # 注意这里的更改
        class_id = int(request.POST.get("class"))
        region = int(request.POST.get("region"))

        print(age, gender, class_id, region)
        

        class_list = models.Classes.objects.values_list('name', flat=True).distinct()
        class_list = list(class_list)  # 转换为列表
        
        try:
            class_index = class_list.index(class_id)
        except ValueError:
            class_index = None  # 或者进行其他错误处理
        

        #读取中文名
        course_names = list(models.Course.objects.all().values_list('name', flat=True))
        #获取序号
        #top_course = randomForest(class_index)
        top_course = randomForest(age,class_id,gender,region)
        
        courseNameResult = []

        top_course = list(set(top_course))

        # 确保top_course中的值不超过course_names的长度
        top_course = [course_id for course_id in top_course if course_id < len(course_names)]

        #将序号转化为中文名
        for i in top_course:
            courseNameResult.append(course_names[i])

        print(courseNameResult)

        ##实现获取序号和老师
        CourseNameAndTeacherId = models.Course.objects.values_list('name',"teacher_id","credit","course_open_time").distinct()
        CourseNameAndTeacherId = list(CourseNameAndTeacherId)
        #print(CourseNameAndTeacherId)

        TeacherName = models.Teacher.objects.values_list('id',"name","phone").distinct()
        TeacherName = list(TeacherName)
        #print(TeacherName)

        CourseNameAndTeacherName = []

        for i in CourseNameAndTeacherId:
            for j in TeacherName:
                if(i[1]==j[0]):
                    CourseNameAndTeacherName.append((i[0],j[1],i[2],i[3],j[2]))

        #print(CourseNameAndTeacherName)

        # 准备一个包含索引和课程教师对的列表
        #print(CourseNameAndTeacherName)

        # 将第一个数组转换成集合，以便于快速查找
        courseNameSet = set(courseNameResult)

        # 遍历包含教师信息的元组列表
        result_with_teacher = [
            course_teacher for course_teacher in CourseNameAndTeacherName 
            if course_teacher[0] in courseNameSet  # 检查课程名称是否在第一个数组中
        ]

        #print(result_with_teacher)

        CourseNameAndTeacherName_with_index = list(enumerate(result_with_teacher,start=1))

        print(CourseNameAndTeacherName_with_index)
        

        

        return render(request,'predict.html',locals())
    
    # views.py
def student_profile(request):

    regions = [
            "北京", "上海", "天津", "重庆",
            "河北", "山西", "辽宁", "吉林", "黑龙江",
            "江苏", "浙江", "安徽", "福建", "江西", "山东", "河南", "湖北", "湖南", "广东", "海南",
            "四川", "贵州", "云南", "陕西", "甘肃", "青海", "内蒙古", "广西", "西藏", "宁夏", "新疆",
            "香港", "澳门"
        ]
    
    if request.user.is_authenticated and request.user.role == 'student':
        student_info = models.Student.objects.prefetch_related('student_detail', 'classes','course').get(user=request.user)
        courses = models.Course.objects.all()
        
        if request.method == 'GET':
            # 向模板传递专业和班级的列表
            student_courses = student_info.course.all() 
            student_majors = models.StudentMajor.objects.all()
            student_classes = models.Classes.objects.all()
            return render(request, 'profile.html', {
                'student_info': student_info,
                'student_majors': student_majors,
                'student_classes': student_classes,
                'courses': courses,
                'student_courses': student_courses,
                'regions': regions, 
            })
        
        elif request.method == 'POST':
            # 获取表单数据并更新学生信息
            name = request.POST.get('name')
            age = request.POST.get('age')
            gender = request.POST.get('gender')
            majorId = request.POST.get('majorId')
            classes_id = request.POST.get('classes')
            region = request.POST.get('region')

            # 更新 Student 模型实例
            student_info.name = name
            student_info.age = age
            student_info.student_detail.gender = gender
            student_info.student_detail.addr = region
            student_info.student_detail.majorId = models.StudentMajor.objects.get(pk=majorId)
            student_info.classes_id = models.Classes.objects.get(pk=classes_id)

             
            student_info.save()
            student_info.student_detail.save()
            
            return redirect('base:index')  # 重定向回学生信息页面
    else:
        return redirect('base:signin')  # 如果用户未登录或不是学生，重定向到登录页面



def course_select(request):
    if request.user.is_authenticated and request.user.role == 'student':
        student = models.Student.objects.get(user=request.user)
        courses = models.Course.objects.all()  # 获取所有课程
        student_courses = student.course.all()  # 获取学生已选课程

        if request.method == 'POST':
            course_id = request.POST.get('course_id')
            action = request.POST.get('action')

            if action == 'enroll':
                # 选课操作
                course = get_object_or_404(models.Course, pk=course_id)
                models.Student2Course.objects.create(student=student, course=course)
            elif action == 'unenroll':
                # 退课操作
                models.Student2Course.objects.filter(student=student, course__id=course_id).delete()

            return redirect('base:course_select')  # 重定向回课程选择页面

        return render(request, 'courseSelect.html', {
            'courses': courses,
            'student_courses': student_courses,
        })
    else:
        return redirect('base:signin')  # 如果用户未认证或角色不是学生，重定向到登录页面


def StudentCourseScore(request):
    if request.method == 'GET':
        student = request.user.student  # 确保这里能够正确获取到学生对象
        if student:
            courses_taken = models.Student2Course.objects.filter(student=student)
            courses_with_scores = [
                {
                    'course': course_taken.course,
                    'choice_course_time': course_taken.choice_course_time,
                    'score': course_taken.score if course_taken.score is not None else '尚无成绩'
                }
                for course_taken in courses_taken
            ]
            return render(request, 'StudentCourseScore.html', {'courses_with_scores': courses_with_scores})
        # 处理没有找到学生信息的情况
        return render(request, 'StudentCourseScore.html', {'courses_with_scores': []})
    # 处理不是GET请求的情况
    return render(request, 'StudentCourseScore.html', {'courses_with_scores': []})

    


def teacher_profile(request):
    if request.method == 'GET':
        # 获取当前登录的教师信息
        teacher_obj = models.Teacher.objects.get(user=request.user)
        majors = models.StudentMajor.objects.all()
        context = {
            'teacher_obj': teacher_obj,
            'user_obj': teacher_obj.user, # 包括用户信息以便在模板中使用
            'majors': majors,
        }
        return render(request, 'profileTeacher.html', context)
    
    elif request.method == 'POST':
        # 更新教师信息
        name = request.POST.get('name')
        phone = request.POST.get('phone')
        gender = request.POST.get('gender')
        age = request.POST.get('age')
        major_id = request.POST.get('major')
        email = request.POST.get('email')
        password = request.POST.get('password')

        # 更新教师对象
        teacher_obj = models.Teacher.objects.get(user=request.user)
        teacher_obj.name = name
        teacher_obj.phone = phone
        teacher_obj.gender = gender
        teacher_obj.age = age
        teacher_obj.major_id = major_id  # 假设你的 Teacher 模型有 major_id 字段

        # 更新用户信息
        user_obj = teacher_obj.user
        user_obj.username = name
        user_obj.email = email
        if password:
            user_obj.set_password(password)  # 使用 set_password 方法加密密码

        teacher_obj.save()
        user_obj.save()

        teacher_obj.refresh_from_db()
        # 重新展示教师
        # 重定向到教师信息页面或其他页面
        return redirect('base:index')

def teacherGiveScore(request):
    if request.method == 'GET':
        teacher = models.Teacher.objects.get(user=request.user)
        if teacher:
            courses = models.Course.objects.filter(teacher=teacher)
            courses_with_students = []
            for course in courses:
                students = models.Student2Course.objects.filter(course=course)
                course_with_students = {
                    'course': course,
                    'students': students.prefetch_related('student__user')
                }
                courses_with_students.append(course_with_students)
            return render(request, 'TeacherGiveCourse.html', {
                'courses_with_students': courses_with_students})

        
    if request.method == 'POST':
        student_id = request.POST.get('student_id')
        course_id = request.POST.get('course_id')
        score = request.POST.get('score')

        # 尝试更新成绩，确保student_id和course_id是有效的
        try:
            student2course = models.Student2Course.objects.get(
                student__user__id=student_id,
                course__id=course_id
            )
            student2course.score = score
            student2course.save()
        except models.Student2Course.DoesNotExist:
            # 如果没有找到对应的记录，可能需要记录日志或提供反馈
            pass

        # 重定向到教师评定成绩的页面或其他页面
        return redirect('base:index')
   
    

def adminControlScore(request):
    if request.method == 'GET':
        # 获取所有学生列表
        students = models.Student.objects.all()
        students_with_courses = []
        
        for student in students:
            # 获取学生所选的课程及其成绩
            courses = models.Student2Course.objects.filter(student=student)
            students_with_courses.append({
                'student': student,
                'courses': courses
            })
        
        return render(request, 'adminCourseControl.html', {
            'students_with_courses': students_with_courses,
        })

    elif request.method == 'POST':
        # 从POST数据中获取所有成绩信息
        students_data = request.POST.getlist('student_id')
        courses_data = request.POST.getlist('course_id')
        scores_data = request.POST.getlist('score')
        # print(students_data)
        # print(courses_data)
        # print(scores_data)

        # 遍历成绩数据并更新或创建记录
        for student_id, course_id, score in zip(students_data, courses_data, scores_data):
            if score:  # 如果成绩不为空或为有效数字，更新成绩
                try:
                    student_course = models.Student2Course.objects.get(student_id=student_id, course_id=course_id)
                    student_course.score = float(score) if score.replace('.','',1).isdigit() else None
                    student_course.save()
                except models.Student2Course.DoesNotExist:
                    models.Student2Course.objects.create(student_id=student_id, course_id=course_id, score=float(score) if score.replace('.','',1).isdigit() else None)
            else:  # 如果成绩为空，则创建记录或更新为NULL
                try:
                    student_course = models.Student2Course.objects.get(student_id=student_id, course_id=course_id)
                    student_course.score = None
                    student_course.save()
                except models.Student2Course.DoesNotExist:
                    pass  # 如果记录不存在，可以忽略或创建新记录

        return redirect('base:index')