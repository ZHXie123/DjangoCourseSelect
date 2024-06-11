from django.shortcuts import render, HttpResponse, redirect
from django.http import JsonResponse
from django.db import transaction

from student import models
from utils.res import ResponseData


def add(request):

    majors = models.StudentMajor.objects.all()

    if request.method == 'POST':
        # 获取表单数据
        name = request.POST.get('name')
        phone = request.POST.get('phone')
        gender = request.POST.get('gender')
        age = request.POST.get('age')
        major_id = request.POST.get('major')
        email = request.POST.get('email')
        
        # 创建 UserInfo 实例
        user_info = models.UserInfo.objects.create(
            username=name,  # 假设老师的名字用作账号
            password='pbkdf2_sha256$390000$pmdJgxZi6FtyRSyqpmGe7i$OIBckiPFSJn41JVwKKDOATW0vAdvCzk60EniSCx/pWc=',  # 默认密码
            email=email,
            role='teacher',  # 用户角色
        )
        
        try:
            with transaction.atomic():
                # 创建 Teacher 实例
                major = models.StudentMajor.objects.get(id=major_id)
                
                teacher = models.Teacher.objects.create(
                    name=name,
                    phone=phone,
                    gender=gender,
                    age=age,
                    major=major,
                    user=user_info  # 关联的用户信息
                )
        except Exception as e:
            print(e)
            print('服务器错误---teacher/add!')
            return redirect('base:teacher')

        return redirect('base:teacher')

    return render(request, 'teacher/add.html',locals())


def edit(request, current_pk):
    teacher_obj = models.Teacher.objects.get(pk=current_pk)  # 使用 get 替代 first，确保抛出 404 异常如果对象不存在
    user_obj = teacher_obj.user
    if request.method == 'POST':
        # 获取表单数据
        name = request.POST.get('name')
        phone = request.POST.get('phone')
        gender = request.POST.get('gender')
        age = request.POST.get('age')
        major_id = request.POST.get('major')
        email = request.POST.get('email')
        password = request.POST.get('password')
        
        # 更新教师信息
        teacher_obj.name = name
        teacher_obj.phone = phone
        teacher_obj.gender = gender
        teacher_obj.age = age
        
        # 根据 major_id 获取 StudentMajor 实例
        major = models.StudentMajor.objects.get(id=major_id)
        teacher_obj.major = major

        user_obj.email = email
        if password:
            user_obj.set_password(password)
        
        teacher_obj.save()  # 保存更改
        user_obj.save()
        return redirect('base:teacher')  # 重定向到教师列表页面

    # 获取所有专业供下拉菜单使用
    majors = models.StudentMajor.objects.all()
    
    return render(request, 'teacher/edit.html', {
        'teacher_obj': teacher_obj,
        'majors': majors,  # 将专业列表传递给模板
        'user_obj':user_obj,
    })

def is_ajax(request):
    return request.META.get('HTTP_X_REQUESTED_WITH') == 'XMLHttpRequest'

def dels(request):
    if is_ajax(request):
        if request.method == 'POST':
            res_dict = ResponseData()
            current_pk = request.POST.get('current_pk')
            try:
                mode1 = models.Teacher.objects.get(pk=current_pk)
                mode2 = models.UserInfo.objects.get(username = mode1.name)
                #print(mode2)
                mode1.delete()
                mode2.delete()
                
            except Exception as e:
                res_dict.status = 5000
                res_dict.message = '服务器错误---teacher/dels!'
                print(e)
                print(res_dict.message)
            finally:
                return JsonResponse(res_dict.get_dict)
