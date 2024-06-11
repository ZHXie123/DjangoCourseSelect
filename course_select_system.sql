/*
 Navicat Premium Data Transfer

 Source Server         : xzh
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : course_select_system

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 06/06/2024 21:41:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `group_id` int(0) NOT NULL,
  `permission_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(0) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add classes', 6, 'add_classes');
INSERT INTO `auth_permission` VALUES (22, 'Can change classes', 6, 'change_classes');
INSERT INTO `auth_permission` VALUES (23, 'Can delete classes', 6, 'delete_classes');
INSERT INTO `auth_permission` VALUES (24, 'Can view classes', 6, 'view_classes');
INSERT INTO `auth_permission` VALUES (25, 'Can add course', 7, 'add_course');
INSERT INTO `auth_permission` VALUES (26, 'Can change course', 7, 'change_course');
INSERT INTO `auth_permission` VALUES (27, 'Can delete course', 7, 'delete_course');
INSERT INTO `auth_permission` VALUES (28, 'Can view course', 7, 'view_course');
INSERT INTO `auth_permission` VALUES (29, 'Can add student', 8, 'add_student');
INSERT INTO `auth_permission` VALUES (30, 'Can change student', 8, 'change_student');
INSERT INTO `auth_permission` VALUES (31, 'Can delete student', 8, 'delete_student');
INSERT INTO `auth_permission` VALUES (32, 'Can view student', 8, 'view_student');
INSERT INTO `auth_permission` VALUES (33, 'Can add student detail', 9, 'add_studentdetail');
INSERT INTO `auth_permission` VALUES (34, 'Can change student detail', 9, 'change_studentdetail');
INSERT INTO `auth_permission` VALUES (35, 'Can delete student detail', 9, 'delete_studentdetail');
INSERT INTO `auth_permission` VALUES (36, 'Can view student detail', 9, 'view_studentdetail');
INSERT INTO `auth_permission` VALUES (37, 'Can add teacher', 10, 'add_teacher');
INSERT INTO `auth_permission` VALUES (38, 'Can change teacher', 10, 'change_teacher');
INSERT INTO `auth_permission` VALUES (39, 'Can delete teacher', 10, 'delete_teacher');
INSERT INTO `auth_permission` VALUES (40, 'Can view teacher', 10, 'view_teacher');
INSERT INTO `auth_permission` VALUES (41, 'Can add student2 course', 11, 'add_student2course');
INSERT INTO `auth_permission` VALUES (42, 'Can change student2 course', 11, 'change_student2course');
INSERT INTO `auth_permission` VALUES (43, 'Can delete student2 course', 11, 'delete_student2course');
INSERT INTO `auth_permission` VALUES (44, 'Can view student2 course', 11, 'view_student2course');
INSERT INTO `auth_permission` VALUES (45, 'Can add user info', 12, 'add_userinfo');
INSERT INTO `auth_permission` VALUES (46, 'Can change user info', 12, 'change_userinfo');
INSERT INTO `auth_permission` VALUES (47, 'Can delete user info', 12, 'delete_userinfo');
INSERT INTO `auth_permission` VALUES (48, 'Can view user info', 12, 'view_userinfo');

-- ----------------------------
-- Table structure for db_classes
-- ----------------------------
DROP TABLE IF EXISTS `db_classes`;
CREATE TABLE `db_classes`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_classes
-- ----------------------------
INSERT INTO `db_classes` VALUES (1, '1班');
INSERT INTO `db_classes` VALUES (2, '2班');
INSERT INTO `db_classes` VALUES (3, '3班');
INSERT INTO `db_classes` VALUES (4, '4班');
INSERT INTO `db_classes` VALUES (5, '5班');

-- ----------------------------
-- Table structure for db_course
-- ----------------------------
DROP TABLE IF EXISTS `db_course`;
CREATE TABLE `db_course`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `credit` smallint(0) NOT NULL,
  `course_open_time` date NOT NULL,
  `teacher_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `db_course_teacher_id_5dadecdc_fk_db_teacher_id`(`teacher_id`) USING BTREE,
  CONSTRAINT `db_course_teacher_id_5dadecdc_fk_db_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `db_teacher` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_course
-- ----------------------------
INSERT INTO `db_course` VALUES (1, 'Python全栈', 3, '2022-12-19', 1);
INSERT INTO `db_course` VALUES (2, 'linux运维', 2, '2022-12-19', 2);
INSERT INTO `db_course` VALUES (3, '网络安全', 2, '2022-12-19', 3);
INSERT INTO `db_course` VALUES (4, 'Java', 3, '2022-12-19', 1);
INSERT INTO `db_course` VALUES (5, '操作系统', 3, '2024-05-31', 3);
INSERT INTO `db_course` VALUES (6, '数据结构', 4, '2024-05-31', 1);
INSERT INTO `db_course` VALUES (7, '计算机组成原理', 3, '2024-06-06', 1);

-- ----------------------------
-- Table structure for db_student
-- ----------------------------
DROP TABLE IF EXISTS `db_student`;
CREATE TABLE `db_student`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `age` smallint(0) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `classes_id` bigint(0) NULL DEFAULT NULL,
  `student_detail_id` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `db_student_classes_id_765880da_fk_db_classes_id`(`classes_id`) USING BTREE,
  INDEX `db_student_student_detail_id_d3c3065c`(`student_detail_id`) USING BTREE,
  CONSTRAINT `db_student_classes_id_765880da_fk_db_classes_id` FOREIGN KEY (`classes_id`) REFERENCES `db_classes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `db_student_student_detail_id_d3c3065c_fk_db_student_detail_id` FOREIGN KEY (`student_detail_id`) REFERENCES `db_student_detail` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_student
-- ----------------------------
INSERT INTO `db_student` VALUES (50, 'XZH', 18, '2024-06-04 18:23:47.738506', 2, NULL);
INSERT INTO `db_student` VALUES (51, 'Mike', 20, '2024-06-04 18:25:29.045756', 1, 22);
INSERT INTO `db_student` VALUES (52, 'San', 24, '2024-06-04 18:35:03.979929', 3, 23);
INSERT INTO `db_student` VALUES (53, 'Tom', 23, '2024-06-04 18:35:36.726152', 1, 24);
INSERT INTO `db_student` VALUES (54, 'Amy', 20, '2024-06-04 18:36:03.295296', 3, 25);
INSERT INTO `db_student` VALUES (55, 'Frank', 25, '2024-06-04 18:37:11.037785', 3, 26);
INSERT INTO `db_student` VALUES (56, 'Any', 18, '2024-06-04 18:37:59.700882', 3, 27);
INSERT INTO `db_student` VALUES (64, 'James', 23, '2024-06-06 20:23:55.596436', 3, 35);
INSERT INTO `db_student` VALUES (65, 'Robert', 22, '2024-06-06 20:24:35.433479', 2, 36);
INSERT INTO `db_student` VALUES (66, 'David', 25, '2024-06-06 20:25:03.868441', 1, 37);
INSERT INTO `db_student` VALUES (67, 'Richard', 23, '2024-06-06 20:25:50.839263', 2, 38);
INSERT INTO `db_student` VALUES (68, 'Thomas', 24, '2024-06-06 20:26:25.729375', 2, 39);
INSERT INTO `db_student` VALUES (69, 'Charles', 23, '2024-06-06 20:26:55.962983', 1, 40);
INSERT INTO `db_student` VALUES (70, 'Mary', 21, '2024-06-06 20:27:46.405612', 2, 41);
INSERT INTO `db_student` VALUES (71, 'Linda', 22, '2024-06-06 20:28:07.455197', 3, 42);
INSERT INTO `db_student` VALUES (72, 'Maria', 23, '2024-06-06 20:28:50.626490', 4, 43);
INSERT INTO `db_student` VALUES (73, 'Susan', 22, '2024-06-06 20:29:14.202077', 2, 44);
INSERT INTO `db_student` VALUES (74, 'Margaret', 24, '2024-06-06 20:29:55.755431', 2, 45);
INSERT INTO `db_student` VALUES (75, 'Patricia', 25, '2024-06-06 20:30:20.177692', 3, 46);
INSERT INTO `db_student` VALUES (76, 'Elizabeth', 23, '2024-06-06 20:31:02.005387', 3, 47);
INSERT INTO `db_student` VALUES (77, 'Robin', 22, '2024-06-06 20:32:20.753693', 4, 48);
INSERT INTO `db_student` VALUES (78, 'Avery', 22, '2024-06-06 20:32:45.330170', 4, 49);
INSERT INTO `db_student` VALUES (79, 'Jordan', 24, '2024-06-06 20:33:09.821577', 3, 50);
INSERT INTO `db_student` VALUES (81, 'Michael', 20, '2024-06-06 20:33:54.923335', 2, 52);
INSERT INTO `db_student` VALUES (82, 'Ivan', 21, '2024-06-06 20:34:20.957792', 1, 53);
INSERT INTO `db_student` VALUES (83, 'Ravi', 24, '2024-06-06 20:34:37.958873', 2, 54);
INSERT INTO `db_student` VALUES (84, 'Tim', 23, '2024-06-06 21:37:52.085057', 5, 59);

-- ----------------------------
-- Table structure for db_student2course
-- ----------------------------
DROP TABLE IF EXISTS `db_student2course`;
CREATE TABLE `db_student2course`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `choice_course_time` datetime(6) NOT NULL,
  `course_id` bigint(0) NOT NULL,
  `student_id` bigint(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `db_student2course_course_id_87989972_fk_db_course_id`(`course_id`) USING BTREE,
  INDEX `db_student2course_student_id_851e1fb3_fk_db_student_id`(`student_id`) USING BTREE,
  CONSTRAINT `db_student2course_course_id_87989972_fk_db_course_id` FOREIGN KEY (`course_id`) REFERENCES `db_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `db_student2course_student_id_851e1fb3_fk_db_student_id` FOREIGN KEY (`student_id`) REFERENCES `db_student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 166 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_student2course
-- ----------------------------
INSERT INTO `db_student2course` VALUES (119, '2024-06-04 18:25:29.047798', 1, 51);
INSERT INTO `db_student2course` VALUES (120, '2024-06-04 18:25:29.047798', 2, 51);
INSERT INTO `db_student2course` VALUES (127, '2024-06-04 18:35:03.981918', 3, 52);
INSERT INTO `db_student2course` VALUES (128, '2024-06-04 18:35:03.981918', 5, 52);
INSERT INTO `db_student2course` VALUES (129, '2024-06-04 18:35:36.727153', 3, 53);
INSERT INTO `db_student2course` VALUES (130, '2024-06-04 18:35:36.728152', 5, 53);
INSERT INTO `db_student2course` VALUES (131, '2024-06-04 18:35:36.728152', 6, 53);
INSERT INTO `db_student2course` VALUES (132, '2024-06-04 18:36:03.296296', 2, 54);
INSERT INTO `db_student2course` VALUES (133, '2024-06-04 18:36:03.296296', 3, 54);
INSERT INTO `db_student2course` VALUES (134, '2024-06-04 18:37:11.039526', 2, 55);
INSERT INTO `db_student2course` VALUES (135, '2024-06-04 18:37:11.039526', 3, 55);
INSERT INTO `db_student2course` VALUES (163, '2024-06-04 22:02:41.352918', 1, 56);
INSERT INTO `db_student2course` VALUES (164, '2024-06-04 22:02:41.352918', 3, 56);
INSERT INTO `db_student2course` VALUES (165, '2024-06-04 22:02:41.352918', 4, 56);
INSERT INTO `db_student2course` VALUES (166, '2024-06-06 20:23:55.597431', 2, 64);
INSERT INTO `db_student2course` VALUES (167, '2024-06-06 20:23:55.597431', 3, 64);
INSERT INTO `db_student2course` VALUES (168, '2024-06-06 20:23:55.597431', 4, 64);
INSERT INTO `db_student2course` VALUES (169, '2024-06-06 20:24:35.435504', 1, 65);
INSERT INTO `db_student2course` VALUES (170, '2024-06-06 20:24:35.435504', 2, 65);
INSERT INTO `db_student2course` VALUES (171, '2024-06-06 20:24:35.435504', 3, 65);
INSERT INTO `db_student2course` VALUES (172, '2024-06-06 20:24:35.435504', 4, 65);
INSERT INTO `db_student2course` VALUES (173, '2024-06-06 20:24:35.435504', 5, 65);
INSERT INTO `db_student2course` VALUES (174, '2024-06-06 20:24:35.435504', 6, 65);
INSERT INTO `db_student2course` VALUES (175, '2024-06-06 20:25:03.869438', 1, 66);
INSERT INTO `db_student2course` VALUES (176, '2024-06-06 20:25:03.869438', 2, 66);
INSERT INTO `db_student2course` VALUES (177, '2024-06-06 20:25:03.869438', 3, 66);
INSERT INTO `db_student2course` VALUES (178, '2024-06-06 20:25:50.841403', 4, 67);
INSERT INTO `db_student2course` VALUES (179, '2024-06-06 20:25:50.841403', 5, 67);
INSERT INTO `db_student2course` VALUES (180, '2024-06-06 20:25:50.841403', 6, 67);
INSERT INTO `db_student2course` VALUES (181, '2024-06-06 20:26:25.730370', 2, 68);
INSERT INTO `db_student2course` VALUES (182, '2024-06-06 20:26:25.730370', 3, 68);
INSERT INTO `db_student2course` VALUES (183, '2024-06-06 20:26:25.730370', 4, 68);
INSERT INTO `db_student2course` VALUES (184, '2024-06-06 20:26:55.964975', 2, 69);
INSERT INTO `db_student2course` VALUES (185, '2024-06-06 20:26:55.964975', 3, 69);
INSERT INTO `db_student2course` VALUES (186, '2024-06-06 20:26:55.964975', 4, 69);
INSERT INTO `db_student2course` VALUES (187, '2024-06-06 20:27:46.406610', 1, 70);
INSERT INTO `db_student2course` VALUES (188, '2024-06-06 20:27:46.406610', 2, 70);
INSERT INTO `db_student2course` VALUES (189, '2024-06-06 20:27:46.406610', 3, 70);
INSERT INTO `db_student2course` VALUES (190, '2024-06-06 20:27:46.406610', 4, 70);
INSERT INTO `db_student2course` VALUES (191, '2024-06-06 20:27:46.406610', 5, 70);
INSERT INTO `db_student2course` VALUES (192, '2024-06-06 20:27:46.406610', 6, 70);
INSERT INTO `db_student2course` VALUES (193, '2024-06-06 20:28:07.456924', 3, 71);
INSERT INTO `db_student2course` VALUES (194, '2024-06-06 20:28:50.627489', 1, 72);
INSERT INTO `db_student2course` VALUES (195, '2024-06-06 20:28:50.627489', 3, 72);
INSERT INTO `db_student2course` VALUES (196, '2024-06-06 20:28:50.627489', 4, 72);
INSERT INTO `db_student2course` VALUES (197, '2024-06-06 20:29:14.203074', 1, 73);
INSERT INTO `db_student2course` VALUES (198, '2024-06-06 20:29:14.203074', 3, 73);
INSERT INTO `db_student2course` VALUES (199, '2024-06-06 20:29:14.203074', 4, 73);
INSERT INTO `db_student2course` VALUES (200, '2024-06-06 20:29:14.203074', 5, 73);
INSERT INTO `db_student2course` VALUES (201, '2024-06-06 20:29:55.757440', 3, 74);
INSERT INTO `db_student2course` VALUES (202, '2024-06-06 20:29:55.757440', 4, 74);
INSERT INTO `db_student2course` VALUES (203, '2024-06-06 20:29:55.758419', 5, 74);
INSERT INTO `db_student2course` VALUES (204, '2024-06-06 20:30:20.178689', 3, 75);
INSERT INTO `db_student2course` VALUES (205, '2024-06-06 20:30:20.178689', 4, 75);
INSERT INTO `db_student2course` VALUES (206, '2024-06-06 20:30:20.178689', 5, 75);
INSERT INTO `db_student2course` VALUES (207, '2024-06-06 20:31:02.006385', 2, 76);
INSERT INTO `db_student2course` VALUES (208, '2024-06-06 20:31:02.006385', 3, 76);
INSERT INTO `db_student2course` VALUES (209, '2024-06-06 20:31:02.006385', 4, 76);
INSERT INTO `db_student2course` VALUES (210, '2024-06-06 20:32:20.754692', 1, 77);
INSERT INTO `db_student2course` VALUES (211, '2024-06-06 20:32:20.754692', 2, 77);
INSERT INTO `db_student2course` VALUES (212, '2024-06-06 20:32:20.754692', 3, 77);
INSERT INTO `db_student2course` VALUES (213, '2024-06-06 20:32:45.331167', 2, 78);
INSERT INTO `db_student2course` VALUES (214, '2024-06-06 20:32:45.331167', 3, 78);
INSERT INTO `db_student2course` VALUES (215, '2024-06-06 20:32:45.331167', 4, 78);
INSERT INTO `db_student2course` VALUES (216, '2024-06-06 20:33:09.823570', 1, 79);
INSERT INTO `db_student2course` VALUES (217, '2024-06-06 20:33:09.823570', 2, 79);
INSERT INTO `db_student2course` VALUES (218, '2024-06-06 20:33:09.823570', 3, 79);
INSERT INTO `db_student2course` VALUES (223, '2024-06-06 20:33:54.925327', 3, 81);
INSERT INTO `db_student2course` VALUES (224, '2024-06-06 20:33:54.925327', 4, 81);
INSERT INTO `db_student2course` VALUES (225, '2024-06-06 20:34:20.958828', 2, 82);
INSERT INTO `db_student2course` VALUES (226, '2024-06-06 20:34:20.958828', 3, 82);
INSERT INTO `db_student2course` VALUES (227, '2024-06-06 20:34:37.960865', 2, 83);
INSERT INTO `db_student2course` VALUES (228, '2024-06-06 20:34:37.960865', 3, 83);
INSERT INTO `db_student2course` VALUES (238, '2024-06-06 21:30:33.701530', 1, 50);
INSERT INTO `db_student2course` VALUES (239, '2024-06-06 21:30:33.701530', 2, 50);
INSERT INTO `db_student2course` VALUES (240, '2024-06-06 21:30:33.701530', 4, 50);
INSERT INTO `db_student2course` VALUES (241, '2024-06-06 21:30:33.701530', 5, 50);
INSERT INTO `db_student2course` VALUES (242, '2024-06-06 21:30:33.701530', 6, 50);
INSERT INTO `db_student2course` VALUES (246, '2024-06-06 21:37:52.086054', 5, 84);
INSERT INTO `db_student2course` VALUES (247, '2024-06-06 21:37:52.086054', 6, 84);

-- ----------------------------
-- Table structure for db_student_detail
-- ----------------------------
DROP TABLE IF EXISTS `db_student_detail`;
CREATE TABLE `db_student_detail`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `gender` smallint(0) NOT NULL,
  `addr` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_student_detail
-- ----------------------------
INSERT INTO `db_student_detail` VALUES (22, 1, '浙江', NULL);
INSERT INTO `db_student_detail` VALUES (23, 1, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (24, 1, '北京', NULL);
INSERT INTO `db_student_detail` VALUES (25, 2, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (26, 1, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (27, 1, '浙江', NULL);
INSERT INTO `db_student_detail` VALUES (35, 1, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (36, 1, '北京', NULL);
INSERT INTO `db_student_detail` VALUES (37, 1, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (38, 1, '浙江', NULL);
INSERT INTO `db_student_detail` VALUES (39, 1, '浙江', NULL);
INSERT INTO `db_student_detail` VALUES (40, 1, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (41, 2, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (42, 2, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (43, 2, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (44, 2, '北京', NULL);
INSERT INTO `db_student_detail` VALUES (45, 2, '浙江', NULL);
INSERT INTO `db_student_detail` VALUES (46, 2, '北京', NULL);
INSERT INTO `db_student_detail` VALUES (47, 2, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (48, 1, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (49, 2, '北京', NULL);
INSERT INTO `db_student_detail` VALUES (50, 1, '浙江', NULL);
INSERT INTO `db_student_detail` VALUES (52, 1, '浙江', NULL);
INSERT INTO `db_student_detail` VALUES (53, 1, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (54, 1, '北京', NULL);
INSERT INTO `db_student_detail` VALUES (56, 1, '北京', NULL);
INSERT INTO `db_student_detail` VALUES (57, 1, '北京', NULL);
INSERT INTO `db_student_detail` VALUES (58, 1, '上海', NULL);
INSERT INTO `db_student_detail` VALUES (59, 1, '北京', NULL);

-- ----------------------------
-- Table structure for db_teacher
-- ----------------------------
DROP TABLE IF EXISTS `db_teacher`;
CREATE TABLE `db_teacher`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_teacher
-- ----------------------------
INSERT INTO `db_teacher` VALUES (1, 'Alex', '18533538888');
INSERT INTO `db_teacher` VALUES (2, 'Egon', '18533537777');
INSERT INTO `db_teacher` VALUES (3, 'Jason', '18533539999');

-- ----------------------------
-- Table structure for db_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `db_userinfo`;
CREATE TABLE `db_userinfo`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `student_id` bigint(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `student_id`(`student_id`) USING BTREE,
  CONSTRAINT `db_userinfo_student_id_4d4993f0_fk_db_student_id` FOREIGN KEY (`student_id`) REFERENCES `db_student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_userinfo
-- ----------------------------
INSERT INTO `db_userinfo` VALUES (9, 'pbkdf2_sha256$390000$h6hvjWWVv4W6qx4rMq4vlt$8K0paU/trdgKwNx8/+WjHQRNr6PyUpWA3x91DpokRsU=', '2024-06-04 18:23:56.417202', 0, 'XZH', '', '', 'xieziheng630@gmail.com', 0, 1, '2024-06-04 18:23:47.739506', 'user_dir_path/XZH/avatars/IMG_8982.JPG', 50);

-- ----------------------------
-- Table structure for db_userinfo_groups
-- ----------------------------
DROP TABLE IF EXISTS `db_userinfo_groups`;
CREATE TABLE `db_userinfo_groups`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `userinfo_id` bigint(0) NOT NULL,
  `group_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `db_userinfo_groups_userinfo_id_group_id_6f0dec0b_uniq`(`userinfo_id`, `group_id`) USING BTREE,
  INDEX `db_userinfo_groups_group_id_8acfcf88_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `db_userinfo_groups_group_id_8acfcf88_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `db_userinfo_groups_userinfo_id_d8bd5cf1_fk_db_userinfo_id` FOREIGN KEY (`userinfo_id`) REFERENCES `db_userinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for db_userinfo_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `db_userinfo_user_permissions`;
CREATE TABLE `db_userinfo_user_permissions`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `userinfo_id` bigint(0) NOT NULL,
  `permission_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `db_userinfo_user_permiss_userinfo_id_permission_i_3764f70e_uniq`(`userinfo_id`, `permission_id`) USING BTREE,
  INDEX `db_userinfo_user_per_permission_id_d9c62b5b_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `db_userinfo_user_per_permission_id_d9c62b5b_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `db_userinfo_user_per_userinfo_id_9da0cced_fk_db_userin` FOREIGN KEY (`userinfo_id`) REFERENCES `db_userinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint(0) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(0) NULL DEFAULT NULL,
  `user_id` bigint(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_db_userinfo_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_db_userinfo_id` FOREIGN KEY (`user_id`) REFERENCES `db_userinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (6, 'student', 'classes');
INSERT INTO `django_content_type` VALUES (7, 'student', 'course');
INSERT INTO `django_content_type` VALUES (8, 'student', 'student');
INSERT INTO `django_content_type` VALUES (11, 'student', 'student2course');
INSERT INTO `django_content_type` VALUES (9, 'student', 'studentdetail');
INSERT INTO `django_content_type` VALUES (10, 'student', 'teacher');
INSERT INTO `django_content_type` VALUES (12, 'student', 'userinfo');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2022-12-18 18:15:12.503010');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2022-12-18 18:15:12.539912');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2022-12-18 18:15:12.633660');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2022-12-18 18:15:12.651611');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2022-12-18 18:15:12.656599');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2022-12-18 18:15:12.660588');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2022-12-18 18:15:12.665574');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2022-12-18 18:15:12.666572');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2022-12-18 18:15:12.670561');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2022-12-18 18:15:12.674550');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2022-12-18 18:15:12.679540');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2022-12-18 18:15:12.686518');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2022-12-18 18:15:12.691505');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2022-12-18 18:15:12.695496');
INSERT INTO `django_migrations` VALUES (15, 'student', '0001_initial', '2022-12-18 18:15:12.985724');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0001_initial', '2022-12-18 18:15:13.033738');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0002_logentry_remove_auto_add', '2022-12-18 18:15:13.041581');
INSERT INTO `django_migrations` VALUES (18, 'admin', '0003_logentry_add_action_flag_choices', '2022-12-18 18:15:13.048563');
INSERT INTO `django_migrations` VALUES (19, 'sessions', '0001_initial', '2022-12-18 18:15:13.063523');
INSERT INTO `django_migrations` VALUES (20, 'student', '0002_alter_course_teacher', '2022-12-19 21:44:07.770980');
INSERT INTO `django_migrations` VALUES (21, 'student', '0003_alter_course_course_open_time', '2022-12-19 21:56:05.938132');
INSERT INTO `django_migrations` VALUES (22, 'student', '0003_alter_student_student_detail', '2024-06-04 14:16:00.905790');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0z7o0cbqcunwg46rhq9p2n3mkabrgd4v', '.eJxVjDsOwjAQBe_iGln2Jv5R0nMGa7O7xgGUSHFSIe4OkVJA-2bmvVTGba15a7LkkdVZJXX63Qakh0w74DtOt1nTPK3LOOhd0Qdt-jqzPC-H-3dQsdVvjVIiFOiLsyaAR_bBExQCG1IySD11RiRFl4QdOIpM0XJAy52Djrx6fwDq6Dfi:1sERKe:tkV36qNvWQWsFjxGDHUDV1lW3z5xlOKhj_2suQK6unM', '2024-06-18 18:23:56.423872');
INSERT INTO `django_session` VALUES ('poj47ug24xvzkj4aaz8c3psvb4ni887b', '.eJxVjMsOgyAQRf-FdUN4KEKXjdt-g5lhoNoHpKKrpv9ebNy4Pefe82GwLuPgMwV2Zv375dmJDX-2ljAPE1UsjwzBP0LaBN0h3TL3OS3zhHyb8N0Wfq3N52XfHgIjlLG-tVHYCaDQBKGNNdo432mrtYrUQguIURhjlZVSiUDOueilRBJN7CK0xL4_Jkg9wQ:1sCgw5:Yy-qhz0-QaUYFxAa-bFvvNgySOYSPunFiOIJjYspK4g', '2024-06-13 22:39:21.269605');

SET FOREIGN_KEY_CHECKS = 1;
