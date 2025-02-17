from django import forms

from student.models import Classes, Student, StudentDetail, StudentMajor


class RegForm(forms.Form):
    username = forms.CharField(
        min_length=3, max_length=8, label='用户名',
        error_messages={
            'min_length': '用户名最少3位',
            'max_length': '用户名最大8位',
            'required': "用户名不能为空"
        },
        widget=forms.widgets.TextInput(attrs={'class': 'form-control'})
    )
    password = forms.CharField(
        min_length=3, max_length=8, label='密码',
        error_messages={
            'min_length': '密码最少3位!',
            'max_length': '密码最大8位!',
            'required': "密码不能为空!"
        },
        widget=forms.widgets.PasswordInput(attrs={'class': 'form-control'})
    )
    confirm_password = forms.CharField(
        min_length=3, max_length=8, label='确认密码',
        error_messages={
            'min_length': '确认密码最少3位!',
            'max_length': '确认密码最大8位!',
            'required': "确认密码不能为空!"
        },
        widget=forms.widgets.PasswordInput(attrs={'class': 'form-control'})
    )
    email = forms.EmailField(
        label='邮箱',
        error_messages={
            'invalid': '邮箱格式不正确!',
            'required': "邮箱不能为空!"
        },
        initial='test@test.com',
        widget=forms.widgets.EmailInput(attrs={'class': 'form-control'})
    )

    role = forms.ChoiceField(
        choices=[('student', '学生')],
        label='账号类型',
        widget=forms.widgets.Select(attrs={'class': 'form-control'})
    )

    age = forms.IntegerField(
        min_value=18,
        max_value=27, 
        label='年龄',
        required=False,
        widget=forms.NumberInput(attrs={'class': 'form-control'})
    )

    classes = forms.ModelChoiceField(
        queryset=Classes.objects.all(),
        label='班级',
        required=False,
        widget=forms.Select(attrs={'class': 'form-control'})
    )

    gender = forms.ChoiceField(
        choices=StudentDetail.gender_choice,
        label='性别',
        required=False,
        widget=forms.Select(attrs={'class': 'form-control'})
    )

    regions = [
            "北京", "上海", "天津", "重庆",
            "河北", "山西", "辽宁", "吉林", "黑龙江",
            "江苏", "浙江", "安徽", "福建", "江西", "山东", "河南", "湖北", "湖南", "广东", "海南",
            "四川", "贵州", "云南", "陕西", "甘肃", "青海", "内蒙古", "广西", "西藏", "宁夏", "新疆",
            "香港", "澳门"
        ]

    addr = forms.ChoiceField(
        choices=[(region, region) for region in regions],
        label='省份',
        required=False,
        widget=forms.Select(attrs={'class': 'form-control'}),
        initial='北京'  # 假设您想要设置北京作为初始值
    )

    majorId = forms.ModelChoiceField(
        queryset=StudentMajor.objects.all(),
        label='专业',
        required=False,
        widget=forms.Select(attrs={'class': 'form-control'})
    )

    

    # 局部钩子
    def clean_username(self):
        username = self.cleaned_data.get('username')
        if username in ['admin', '管理员']:
            self.add_error('username', '用户名不合法!')
        return username

    # 全局钩子
    def clean(self):
        password = self.cleaned_data.get('password')
        confirm_password = self.cleaned_data.get('confirm_password')
        if confirm_password != password:
            self.add_error('confirm_password', '两次密码不一致!')
        return self.cleaned_data



