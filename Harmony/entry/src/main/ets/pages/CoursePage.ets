import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 扩展课程数据结构
interface Course {
  name: string;
  time: string;
  teacher: string;
  location: string;
  progress: number;
  courseType: string;
  credit: number;
  classMode: string;
  homework: string;
  textbook: string;
  assessment: string;
  extraInfo: string;
  preCourse: string;
}

// 大幅扩展每周课程数据（新增多门课程，覆盖全周）
const courseData: Course[][] = [
// 第1周课程（7门课，覆盖周一至周五）
  [
    {
      name: '高等数学（A）',
      time: '周一 08:00-09:40（第1-2节）| 周三 10:00-11:40（第3-4节）',
      teacher: '张教授（博导）| 办公室：理学院302 | 答疑时间：周五14:00-16:00',
      location: '教1-101（多媒体教室）',
      progress: 30,
      courseType: '专业基础必修课',
      credit: 4,
      classMode: '线下授课（需带教材+练习册）',
      homework: '每周一次课后习题（上交纸质版），截止时间每周日24:00',
      textbook: '《高等数学（第七版）》，同济大学数学系编，高等教育出版社，2020',
      assessment: '考试（平时30%+期中20%+期末50%）',
      extraInfo: '无实验课，每月1次单元测试（随堂）',
      preCourse: '无（面向大一新生）'
    },
    {
      name: '大学英语（四级强化）',
      time: '周二 10:00-11:40（第3-4节）| 周四 14:00-15:40（第5-6节）',
      teacher: '李老师（讲师）| 办公室：外语学院205 | 邮箱：li_english@school.edu',
      location: '教2-202（语音实验室）',
      progress: 20,
      courseType: '公共基础必修课',
      credit: 3,
      classMode: '线上线下混合（课堂+学习通打卡）',
      homework: '双周一次作文+每周3次听力打卡（学习通平台）',
      textbook: '《新视野大学英语（第三版）读写教程2》，郑树棠，外语教学与研究出版社，2018',
      assessment: '考查（平时40%+四级模拟30%+期末30%）',
      extraInfo: '每月1次英语角（周三晚19:00，外语角广场）',
      preCourse: '高中英语（高考成绩≥90分）'
    },
    {
      name: '计算机基础（实验）',
      time: '周三 14:00-15:40（第5-6节）| 周五 09:00-10:40（第2-3节）',
      teacher: '王老师（工程师）| 实验室：实3-303 | 联系电话：138xxxx5678',
      location: '实3-303（计算机机房，机位号：301-320）',
      progress: 40,
      courseType: '公共基础必修课（实验课）',
      credit: 2,
      classMode: '纯线下实验（需带U盘保存实验报告）',
      homework: '每次实验后提交电子版报告，截止时间实验结束后24小时',
      textbook: '《计算机基础实验指导（鸿蒙版）》，刘敏，电子工业出版社，2024',
      assessment: '考查（实验报告60%+操作考核30%+出勤10%）',
      extraInfo: '实验课需提前10分钟到场，迟到15分钟禁止入场',
      preCourse: '无（需掌握基本电脑操作）'
    },
    {
      name: '思想道德修养与法律基础',
      time: '周一 14:00-15:40（第5-6节）| 周五 14:00-15:40（第5-6节）',
      teacher: '陈老师（副教授）| 办公室：马克思主义学院108 | 答疑：周三10:00-11:30',
      location: '教3-301（阶梯教室）',
      progress: 15,
      courseType: '公共基础必修课',
      credit: 3,
      classMode: '线下授课（含小组讨论）',
      homework: '每章1篇读后感（1500字），电子版提交至课程平台',
      textbook: '《思想道德修养与法律基础（2023年版）》，高等教育出版社',
      assessment: '考查（平时50%+期末论文50%）',
      extraInfo: '需加入课程微信群（上课前扫码）',
      preCourse: '无'
    },
    {
      name: '体育（篮球）',
      time: '周二 16:00-17:40（第7-8节）',
      teacher: '刘教练（一级裁判）| 办公室：体育中心202 | 电话：139xxxx1234',
      location: '室外篮球场（1号场）',
      progress: 25,
      courseType: '公共基础必修课',
      credit: 1,
      classMode: '纯线下实践（需穿运动服）',
      homework: '每周3次晨跑打卡（校园跑APP，每次≥2公里）',
      textbook: '《大学体育与健康》，王健，高等教育出版社，2022',
      assessment: '考查（考勤30%+技能40%+体测30%）',
      extraInfo: '雨天改至室内体育馆（提前查看课程群通知）',
      preCourse: '无'
    },
    {
      name: '大学物理（上）',
      time: '周四 08:00-09:40（第1-2节）| 周四 10:00-11:40（第3-4节）',
      teacher: '赵教授（博士）| 办公室：物理学院205 | 答疑：周二15:00-17:00',
      location: '教4-402（实验室+理论课）',
      progress: 10,
      courseType: '专业基础必修课',
      credit: 4,
      classMode: '理论+实验（单周理论，双周实验）',
      homework: '每周实验报告+课后习题，纸质版下周提交',
      textbook: '《大学物理（第六版）》，张三慧，清华大学出版社，2021',
      assessment: '考试（平时20%+实验30%+期末50%）',
      extraInfo: '实验需提前预约（物理实验中心系统）',
      preCourse: '高等数学（函数与极限）'
    },
    {
      name: '形势与政策',
      time: '周三 08:00-09:40（第1-2节）',
      teacher: '杨老师（教授）| 办公室：马克思主义学院105 | 邮箱：yang_xs@school.edu',
      location: '教5-501（多媒体教室）',
      progress: 5,
      courseType: '公共基础必修课',
      credit: 2,
      classMode: '线下授课（每4周1次）',
      homework: '每学期2篇形势分析报告（2000字）',
      textbook: '《形势与政策（2024年版）》，高等教育出版社',
      assessment: '考查（出勤40%+报告60%）',
      extraInfo: '缺勤1次及以上无成绩',
      preCourse: '无'
    }
  ],
  // 第2周课程（8门课，新增更多专业课程）
  [
    {
      name: '高等数学（A）',
      time: '周一 08:00-09:40（第1-2节）| 周三 10:00-11:40（第3-4节）',
      teacher: '张教授（博导）| 办公室：理学院302 | 答疑时间：周五14:00-16:00',
      location: '教1-101（多媒体教室）',
      progress: 50,
      courseType: '专业基础必修课',
      credit: 4,
      classMode: '线下授课（本周讲解"导数应用"章节）',
      homework: '本周习题：教材P89-92（第1、3、5、7题），纸质版下周一带',
      textbook: '《高等数学（第七版）》，同济大学数学系编，高等教育出版社，2020',
      assessment: '考试（下周进行第一次单元测试，范围：第1-2章）',
      extraInfo: '单元测试允许带1张A4公式纸（手写，仅限公式）',
      preCourse: '无（面向大一新生）'
    },
    {
      name: '线性代数',
      time: '周二 10:00-11:40（第3-4节）| 周四 08:00-09:40（第1-2节）',
      teacher: '赵老师（副教授）| 办公室：理学院208 | 答疑群：QQ群789xxxx123',
      location: '教2-203（智慧教室，支持投屏互动）',
      progress: 10,
      courseType: '专业核心必修课',
      credit: 3,
      classMode: '线下授课（需带计算器+笔记本）',
      homework: '首次作业：教材P35-36（第2、4、6题），下周二上课前上交',
      textbook: '《线性代数（第六版）》，同济大学数学系编，高等教育出版社，2019',
      assessment: '考试（平时25%+期中25%+期末50%）',
      extraInfo: '无实验课，课堂会有小组讨论（4人一组）',
      preCourse: '高等数学（第一章函数与极限）'
    },
    {
      name: '大学英语（四级强化）',
      time: '周二 14:00-15:40（第5-6节）| 周四 16:00-17:40（第7-8节）',
      teacher: '李老师（讲师）| 办公室：外语学院205 | 邮箱：li_english@school.edu',
      location: '教2-202（语音实验室）',
      progress: 30,
      courseType: '公共基础必修课',
      credit: 3,
      classMode: '线上线下混合（本周口语测试）',
      homework: '完成四级真题阅读部分（2023年12月卷），拍照上传学习通',
      textbook: '《新视野大学英语（第三版）读写教程2》，郑树棠，外语教学与研究出版社，2018',
      assessment: '考查（平时40%+四级模拟30%+期末30%）',
      extraInfo: '口语测试分组名单已上传课程群',
      preCourse: '高中英语（高考成绩≥90分）'
    },
    {
      name: '计算机网络',
      time: '周一 10:00-11:40（第3-4节）| 周三 16:00-17:40（第7-8节）',
      teacher: '孙老师（副教授）| 办公室：计算机学院306 | 答疑：周四10:00-12:00',
      location: '实3-305（网络实验室）',
      progress: 5,
      courseType: '专业核心必修课',
      credit: 3,
      classMode: '理论+实验（各占50%）',
      homework: '绘制OSI七层模型结构图，标注各层功能',
      textbook: '《计算机网络（第八版）》，谢希仁，电子工业出版社，2023',
      assessment: '考试（平时20%+实验30%+期末50%）',
      extraInfo: '实验需自带笔记本电脑（安装Packet Tracer）',
      preCourse: '计算机基础'
    },
    {
      name: '体育（篮球）',
      time: '周二 16:00-17:40（第7-8节）',
      teacher: '刘教练（一级裁判）| 办公室：体育中心202 | 电话：139xxxx1234',
      location: '室外篮球场（1号场）',
      progress: 35,
      courseType: '公共基础必修课',
      credit: 1,
      classMode: '纯线下实践（本周学习三步上篮）',
      homework: '完成5次校园跑（每次≥2.5公里），截止周日24:00',
      textbook: '《大学体育与健康》，王健，高等教育出版社，2022',
      assessment: '考查（考勤30%+技能40%+体测30%）',
      extraInfo: '下周进行1000米体能测试，提前准备',
      preCourse: '无'
    },
    {
      name: '大学物理实验',
      time: '周五 08:00-11:40（第1-4节）',
      teacher: '吴老师（实验师）| 实验室：物理楼203 | 电话：137xxxx8901',
      location: '物理实验楼203（电磁学实验室）',
      progress: 20,
      courseType: '专业基础必修课（实验）',
      credit: 1,
      classMode: '纯实验（3人一组）',
      homework: '撰写"伏安法测电阻"实验报告，含数据处理和误差分析',
      textbook: '《大学物理实验教程》，李明，科学出版社，2021',
      assessment: '考查（实验操作60%+报告40%）',
      extraInfo: '必须穿实验服，禁止穿凉鞋',
      preCourse: '大学物理（上）'
    },
    {
      name: '军事理论',
      time: '周四 14:00-15:40（第5-6节）',
      teacher: '黄教官（退役军官）| 办公室：武装部103 | 邮箱：huang_junshi@school.edu',
      location: '教5-502（阶梯教室）',
      progress: 10,
      courseType: '公共基础必修课',
      credit: 2,
      classMode: '线下授课（含视频教学）',
      homework: '撰写《现代国防与军队建设》读后感（1000字）',
      textbook: '《军事理论（2024版）》，国防大学出版社',
      assessment: '考查（出勤30%+作业30%+期末测试40%）',
      extraInfo: '期末测试为开卷考试（可带教材和笔记）',
      preCourse: '无'
    },
    {
      name: 'Python程序设计',
      time: '周三 08:00-09:40（第1-2节）| 周五 10:00-11:40（第3-4节）',
      teacher: '周老师（工程师）| 办公室：计算机学院308 | 答疑群：微信群（扫码加入）',
      location: '实3-301（编程实验室）',
      progress: 15,
      courseType: '专业选修课',
      credit: 3,
      classMode: '理论+上机（同步进行）',
      homework: '完成"学生成绩统计"小程序，提交代码和运行结果',
      textbook: '《Python编程：从入门到实践》，埃里克·马瑟斯，人民邮电出版社，2022',
      assessment: '考查（平时40%+项目30%+期末30%）',
      extraInfo: '需安装Python 3.9及以上版本（实验室已预装）',
      preCourse: '计算机基础（基本操作）'
    }
  ]
];

@Entry
@Component
struct CoursePage {
  @State currentWeek: number = 0;

  onBackPress() {
    router.back();
    return true;
  }

  getCurrentCourses(): Course[] {
    return courseData[this.currentWeek] || [];
  }

  build() {
    Column() {
      Navigation() {
        Column() {
          Row() {
            Text(`第${this.currentWeek + 1}周课程表`)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 15 })

            Blank()

            Button('周次说明')
              .fontSize(14)
              .fontColor('#007DFF')
              .backgroundColor(Color.Transparent)
              .border({ width: 1, color: '#007DFF', radius: 15 })
              .padding({ left: 12, right: 12, top: 4, bottom: 4 })
              .margin({ right: 10 })
              .onClick(() => {
                promptAction.showToast({
                  message: `第${this.currentWeek + 1}周重点：高数单元测试（第1周无/第2周有）| 英语角周三晚`,
                  duration: 3000
                });
              })

            Row() {
              Button('<')
                .width(40)
                .height(40)
                .fontSize(16)
                .fontColor(Color.White)
                .backgroundColor('#007DFF')
                .borderRadius(20)
                .enabled(this.currentWeek > 0)
                .onClick(() => {
                  if (this.currentWeek > 0) {
                    this.currentWeek--;
                  }
                })

              Text(`第${this.currentWeek + 1}周`)
                .fontSize(16)
                .margin({ left: 10, right: 10 })
                .fontWeight(FontWeight.Medium)

              Button('>')
                .width(40)
                .height(40)
                .fontSize(16)
                .fontColor(Color.White)
                .backgroundColor('#007DFF')
                .borderRadius(20)
                .enabled(this.currentWeek < courseData.length - 1)
                .onClick(() => {
                  if (this.currentWeek < courseData.length - 1) {
                    this.currentWeek++;
                  }
                })
            }
            .margin({ right: 15 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 10, bottom: 15 })

          Swiper() {
            ForEach(Array.from({ length: courseData.length }, (_, index) => index), (weekIndex: number) => {
              Column() {
                Button(`第${weekIndex + 1}周`)
                  .width(120)
                  .height(44)
                  .backgroundColor(this.currentWeek === weekIndex ? '#007DFF' : '#F5F5F5')
                  .fontColor(this.currentWeek === weekIndex ? Color.White : '#666666')
                  .fontSize(16)
                  .borderRadius(22)
                  .onClick(() => {
                    this.currentWeek = weekIndex;
                  })
              }
              .width('100%')
              .justifyContent(FlexAlign.Center)
            })
          }
          .index(this.currentWeek)
          .indicator(false)
          .loop(false)
          .vertical(false)
          .itemSpace(10)
          .width('80%')
          .height(60)
          .onChange((index: number) => {
            this.currentWeek = index;
          })

          if (this.getCurrentCourses().length > 0) {
            Scroll() {
              Column() {
                ForEach(this.getCurrentCourses(), (course: Course, index: number) => {
                  Column() {
                    Column() {
                      Row() {
                        Text(course.name)
                          .fontSize(20)
                          .fontWeight(FontWeight.Bold)
                          .layoutWeight(1)
                          .fontColor('#333333')

                        Text(`${course.progress}%`)
                          .fontSize(14)
                          .fontColor('#007DFF')
                          .fontWeight(FontWeight.Medium)
                          .backgroundColor('#E8F3FF')
                          .padding({ left: 8, right: 8, top: 2, bottom: 2 })
                          .borderRadius(12)
                      }
                      .width('100%')
                      .margin({ bottom: 10 })

                      Column() {
                        Row() {
                          Text('⏰')
                            .fontSize(16)
                            .margin({ right: 6 })
                          Text(course.time)
                            .fontSize(14)
                            .fontColor('#666666')
                            .maxLines(2)
                            .textOverflow({ overflow: TextOverflow.Ellipsis })
                        }
                        .width('100%')
                        .margin({ bottom: 6 })

                        Row() {
                          Text('📍')
                            .fontSize(16)
                            .margin({ right: 6 })
                          Text(course.location)
                            .fontSize(14)
                            .fontColor('#666666')
                        }
                        .width('100%')
                        .margin({ bottom: 6 })

                        Row() {
                          Text('👨‍🏫')
                            .fontSize(16)
                            .margin({ right: 6 })
                          Text(course.teacher)
                            .fontSize(14)
                            .fontColor('#666666')
                            .maxLines(2)
                            .textOverflow({ overflow: TextOverflow.Ellipsis })
                        }
                        .width('100%')
                      }
                      .width('100%')
                      .margin({ bottom: 10 })

                      // 修复这里：使用多个Row来实现换行效果
                      Column({ space: 8 }) {
                        Row({ space: 8 }) {
                          Text(course.courseType)
                            .fontSize(12)
                            .fontColor('#007DFF')
                            .backgroundColor('#E8F3FF')
                            .padding({ left: 10, right: 10, top: 3, bottom: 3 })
                            .borderRadius(15)

                          Text(`学分：${course.credit}`)
                            .fontSize(12)
                            .fontColor('#34C759')
                            .backgroundColor('#F0FDF4')
                            .padding({ left: 10, right: 10, top: 3, bottom: 3 })
                            .borderRadius(15)
                        }

                        Row({ space: 8 }) {
                          Text(`考核：${course.assessment}`)
                            .fontSize(12)
                            .fontColor('#FF9500')
                            .backgroundColor('#FFF8E6')
                            .padding({ left: 10, right: 10, top: 3, bottom: 3 })
                            .borderRadius(15)

                          Text(`前置：${course.preCourse === '无' ? '无' : '有'}`)
                            .fontSize(12)
                            .fontColor('#AF52DE')
                            .backgroundColor('#FAF5FF')
                            .padding({ left: 10, right: 10, top: 3, bottom: 3 })
                            .borderRadius(15)
                        }
                      }
                      .width('100%')
                      .margin({ bottom: 10 })

                      Column() {
                        Row() {
                          Text('📝')
                            .fontSize(16)
                            .margin({ right: 6 })
                          Text(`作业要求：${course.homework}`)
                            .fontSize(13)
                            .fontColor('#666666')
                            .maxLines(2)
                            .textOverflow({ overflow: TextOverflow.Ellipsis })
                        }
                        .width('100%')
                        .margin({ bottom: 4 })

                        Row() {
                          Text('📚')
                            .fontSize(16)
                            .margin({ right: 6 })
                          Text(`指定教材：${course.textbook}`)
                            .fontSize(13)
                            .fontColor('#666666')
                            .maxLines(2)
                            .textOverflow({ overflow: TextOverflow.Ellipsis })
                        }
                        .width('100%')
                        .margin({ bottom: 4 })

                        Row() {
                          Text('🏫')
                            .fontSize(16)
                            .margin({ right: 6 })
                          Text(`课堂形式：${course.classMode}`)
                            .fontSize(13)
                            .fontColor('#666666')
                        }
                        .width('100%')
                      }
                      .width('100%')
                      .margin({ bottom: 10 })

                      Row() {
                        Text('⚠️')
                          .fontSize(16)
                          .margin({ right: 6 })
                          .fontColor('#FF9500')
                        Text(`重要提示：${course.extraInfo}`)
                          .fontSize(13)
                          .fontColor('#FF9500')
                          .fontWeight(FontWeight.Medium)
                      }
                      .width('100%')
                      .margin({ bottom: 12 })

                      Column() {
                        Row() {
                          Text('课程进度')
                            .fontSize(13)
                            .fontColor('#999999')
                          Blank()
                          Text(`${course.progress}%`)
                            .fontSize(13)
                            .fontColor('#007DFF')
                        }
                        .width('100%')
                        .margin({ bottom: 6 })

                        Progress({ value: course.progress, total: 100 })
                          .width('100%')
                          .height(6)
                          .color('#007DFF')
                          .backgroundColor('#E5E5E5')
                      }
                      .width('100%')
                    }
                    .padding(16)
                    .backgroundColor(Color.White)
                    .borderRadius(12)
                    .width('100%')
                    .shadow({ radius: 3, color: '#00000014', offsetX: 0, offsetY: 2 })
                    .onClick(() => {
                      promptAction.showToast({
                        message: `【${course.name}】详情：\n${course.assessment} | 答疑：${course.teacher.split('|')[2]}`,
                        duration: 3000
                      });
                    })
                  }
                  .width('100%')
                  .margin({ bottom: 15 })
                })
              }
              .width('100%')
              .padding(16)
            }
            .layoutWeight(1)
          } else {
            Column() {
              Image($r('app.media.course'))
                .width(120)
                .height(120)
                .margin({ bottom: 20 })

              Text('本周暂无课程')
                .fontSize(16)
                .fontColor('#999999')
                .margin({ bottom: 8 })

              Text('请切换到其他周次查看课程安排')
                .fontSize(14)
                .fontColor('#CCCCCC')
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.Center)
          }
        }
        .width('100%')
        .height('100%')
      }
      .title('课程表（含详细信息）')
      .titleMode(NavigationTitleMode.Mini)
      .height('100%')
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}