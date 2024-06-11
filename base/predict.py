import random
from tokenize import String
import numpy as np
from sklearn.calibration import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MultiLabelBinarizer, OneHotEncoder
from student import models

#[课程id，年龄，班级，性别，住址]
def randomForest(age,yourclass,sex,addr):
        # 假设这是从您的Django模型中获取的 course_student_pairs 数据

    course_student_pairs = list(models.Student2Course.objects.all())
    StudentAll = list(models.Student.objects.values_list('id','name','age','classes_id','student_detail_id'))
    StudentAll = [i for i in StudentAll if i[4] is not None]
            
    Student_detail = list(models.StudentDetail.objects.values_list('id','gender','addr'))

    StudentAndCourse = list(models.Student2Course.objects.values_list('course_id','student_id'))

    #print(StudentAndCourse)


    StudentAll_and_detail = []
    for i in StudentAll:
        for j in Student_detail:
            if(i[4]==j[0]):
                if(j[1]==1):
                    StudentAll_and_detail.append((i[0],i[1],str(i[2])+"岁",str(i[3])+"班","男",j[2]))
                else :
                    StudentAll_and_detail.append((i[0],i[1],str(i[2])+"岁",str(i[3])+"班","女",j[2]))
    #print(StudentAll_and_detail)
    
    # 初始化最终的完整数据集列表
    final_dataset = []

    # 迭代每个学生及其详细信息
    for student_detail in StudentAll_and_detail:
        # 对于每个学生，找到他们所选的课程
        for course_pair in StudentAndCourse:
            if student_detail[0] == course_pair[1]:  # 学生的id与课程中的学生id匹配
                # 创建一个新的元组，包含课程信息和学生详细信息
                final_dataset.append(
                    (course_pair[0],) + student_detail
                )

    # 打印最终数据集
    #print(final_dataset)
    # final_dataset = list(final_dataset)
    output = []
    for i in final_dataset:
        data = list(i)
        data[0] = i[0]
        output.append(data)
    #print(output)
    # 删除名字
    for data in output:
        data.pop(2)  # 删除每个子列表中的第三个元素

    #print(output)
    
    for data in output:
        data.pop(1)  # 删除每个子列表中的第三个元素

    #print(output)
    data = output
    #print(data)

    city_to_number = {
    '北京': 1,
    '上海': 2,
    '天津': 3,
    '重庆': 4,
    '河北': 5,
    '山西': 6,
    '辽宁': 7,
    '吉林': 8,
    '黑龙江': 9,
    '江苏': 10,
    '浙江': 11,
    '安徽': 12,
    '福建': 13,
    '江西': 14,
    '山东': 15,
    '河南': 16,
    '湖北': 17,
    '湖南': 18,
    '广东': 19,
    '海南': 20,
    '四川': 21,
    '贵州': 22,
    '云南': 23,
    '陕西': 24,
    '甘肃': 25,
    '青海': 26,
    '内蒙古': 27,
    '广西': 28,
    '西藏': 29,
    '宁夏': 30,
    '新疆': 31,
    '香港': 32,
    '澳门': 33
}
    
    #print(data)

    for i in range(len(data)):
        # 遍历数组的每一行
        for j in range(len(data[i])):
            # 将年龄和班级编号转换为整数
            if j == 1 or j == 2:
                data[i][j] = int(data[i][j][:-1])  # 去掉末尾的'岁'或'班'字符，并转换为整数
            # 将性别转换为整数
            elif j == 3:
                if data[i][j] == '男':
                    data[i][j] = 1
                elif data[i][j] == '女':
                    data[i][j] = 2
            # 将地区转换为整数
            
    for i in range(len(data)):
        for j in range(len(data[i])):
            # 检查当前元素是否是城市名称
            if data[i][j] in city_to_number:
                # 更新为对应的数字（元组中的索引+1）
                data[i][j] = city_to_number[data[i][j]]

    # 打印转换后的数组
    #print(data)
    #[课程id，年龄，班级，性别，住址]



    X = []
    y = []

    for i in data:
        y.append(i[0])
        X.append((i[1],i[2],i[3],i[4]))

    # print(y)
    # print(X)
    
    # 划分训练集和测试集
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # 创建随机森林分类器实例
    clf = RandomForestClassifier(n_estimators=100, random_state=42)

    # 训练模型
    clf.fit(X_train, y_train)

    # 使用训练好的模型进行预测
    # 假设这是您要预测的新数据
    #age,yourclass,sex,addr
    new_data = np.array([[age,yourclass,sex,addr]])

    # 使用训练好的模型预测概率
    probabilities = clf.predict_proba(new_data)

    course_ids =[]
    # 打印每个课程的概率
    #print("每个课程的概率是:")
    for course_id, prob in enumerate(probabilities[0]):
       # print(f"课程 {course_id + 1} 的概率: {prob:.4f}")
        if(prob>=0.2):
            course_ids.append(course_id+1)
            
    # 如果没有课程ID的概率大于或等于0.4，则随机选择三个课程ID
    if not course_ids:
        print("随机选择了")
        # 从所有课程中随机选择三个不重复的课程ID
        course_ids = random.sample(range(1, len(probabilities[0]) + 1), 3)
    
    return course_ids
    
    
    #[课程id，年龄，班级，性别，住址]

def GetChinese(x):
    
    num_to_chinese = {
        0: '零',
        1: '一',
        2: '二',
        3: '三',
        4: '四',
        5: '五',
        6: '六',
        7: '七',
        8: '八',
        9: '九'
    }
    # 检查数字x是否在字典的键中
    if x in num_to_chinese:
        return num_to_chinese[x]
    else:
        # 如果数字不在0到9之间，可以抛出异常或返回错误信息
        raise ValueError("数字必须在0到9之间")

