import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

@Entry
@Component
struct Index {
  private tabsController: TabsController = new TabsController();
  @State currentIndex: number = 0;

  // 轮播图数据
  @State bannerImages: Resource[] = [
  $r('app.media.course'),
  $r('app.media.course'),
  $r('app.media.course'),
  $r('app.media.course')
  ];

  // 功能模块数据
  @State functionItems: any[] = [
    { name: '课程表', icon: $r('app.media.course'), path: 'pages/CoursePage' },
    { name: '请假申请', icon: $r('app.media.course'), path: 'pages/LeaveApplyPage' },
    { name: '校园通知', icon: $r('app.media.course'), path: 'pages/NoticeListPage' },
    { name: '校园地图', icon: $r('app.media.course'), path: 'pages/CampusMapPage' },
    { name: '活动中心', icon: $r('app.media.course'), path: 'pages/ActivityCalendarPage' }
  ];

  @Builder TabItem(
    title: string,
    iconNormal: string,
    iconSelected: string,
    targetIndex: number
  ) {
    Column() {
      Image(this.currentIndex === targetIndex ? iconSelected : iconNormal)
        .size({ width: 32, height: 32 })
      Text(title)
        .fontSize(16)
        .fontColor(this.currentIndex === targetIndex ? '#007DFF' : Color.Gray)
    }
    .size({ width: '100%', height: 60 })
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(targetIndex);
    })
  }

  // 处理功能模块点击 - 启用真正的页面跳转
  handleFunctionClick(item: any) {
    console.info(`点击功能模块: ${item.name}, 路径: ${item.path}`);

    // 启用真正的页面跳转
    router.pushUrl({
      url: item.path
    }, router.RouterMode.Standard, (err) => {
      if (err) {
        console.error(`跳转到${item.name}失败:`, err);
        promptAction.showToast({
          message: `页面暂未开发: ${item.name}`,
          duration: 2000
        });
      } else {
        console.info(`跳转到${item.name}成功`);
      }
    });
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      // 1. 主页Tab
      TabContent() {
        Column() {
          // 顶部轮播图
          Swiper() {
            ForEach(this.bannerImages, (image: Resource, index: number) => {
              Image(image)
                .size({ width: '100%', height: '100%' })
                .objectFit(ImageFit.Cover)
                .borderRadius(10)
            })
          }
          .size({ width: '90%', height: 180 })
          .autoPlay(true)
          .interval(3000)
          .loop(true)
          .indicator(true)
          .margin({ top: 10, bottom: 15 })

          // 滚动通知
          Column() {
            Marquee({
              start: true,
              step: 6,
              loop: -1,
              fromStart: true,
              src: '【紧急通知】本周六校园网络维护，暂停服务6小时，请各位师生提前做好准备！'
            })
              .fontSize(16)
              .fontColor(Color.Red)
              .width('100%')
              .height(40)
          }
          .backgroundColor('#FFF3F3')
          .padding(10)
          .borderRadius(5)
          .margin({ left: 20, right: 20, bottom: 20 })
          .width('90%')

          // 核心功能入口Grid
          Grid() {
            ForEach(this.functionItems, (item: any, index: number) => {
              GridItem() {
                Column() {
                  Image(item.icon)
                    .size({ width: 50, height: 50 })
                    .margin({ bottom: 8 })
                  Text(item.name)
                    .fontSize(14)
                    .textAlign(TextAlign.Center)
                    .maxLines(1)
                }
                .width('100%')
                .padding(12)
                .backgroundColor(Color.White)
                .borderRadius(12)
                .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
                .onClick(() => {
                  this.handleFunctionClick(item);
                })
              }
              .width('100%')
              .height(100)
            })
          }
          .columnsTemplate('1fr 1fr 1fr')
          .columnsGap(15)
          .rowsGap(15)
          .padding(20)
          .layoutWeight(1)
          .width('100%')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F5')
        .justifyContent(FlexAlign.Start)
      }
      .tabBar(this.TabItem('主页', '/images/home_normal.png', '/images/home_selected.png', 0))

      // 2. 消息Tab
      TabContent() {
        Column() {
          Text('消息中心')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20, bottom: 15 })

          // 添加消息统计
          Row() {
            Text('未读消息 3')
              .fontSize(14)
              .fontColor('#FF3B30')
              .backgroundColor('#FFEBEE')
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .borderRadius(10)

            Text('全部消息 12')
              .fontSize(14)
              .fontColor('#666')
              .margin({ left: 10 })
          }
          .width('90%')
          .justifyContent(FlexAlign.Start)
          .margin({ bottom: 10 })

          List() {
            // 未读消息 - 带有红点
            ListItem() {
              Row() {
                Badge({ count: 1, position: BadgePosition.RightTop, style: { badgeColor: '#FF3B30' } }) {
                  Column() {
                    Text('【紧急】校园网络维护通知')
                      .fontSize(16)
                      .fontColor('#000')
                      .fontWeight(FontWeight.Bold)
                    Text('本周六8:00-14:00进行网络设备升级，期间校园网将中断服务...')
                      .fontSize(14)
                      .fontColor('#666')
                      .maxLines(1)
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                Text('10分钟前')
                  .fontSize(12)
                  .fontColor('#999')
                  .margin({ left: 'auto' })
              }
              .padding(15)
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/NoticeDetailPage' });
            })

            ListItem() {
              Row() {
                Badge({ count: 1, position: BadgePosition.RightTop, style: { badgeColor: '#FF3B30' } }) {
                  Column() {
                    Text('2025年秋季运动会报名')
                      .fontSize(16)
                      .fontColor('#000')
                      .fontWeight(FontWeight.Bold)
                    Text('运动会将于10月15日举行，请各班体育委员组织报名...')
                      .fontSize(14)
                      .fontColor('#666')
                      .maxLines(1)
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                Text('30分钟前')
                  .fontSize(12)
                  .fontColor('#999')
                  .margin({ left: 'auto' })
              }
              .padding(15)
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/SportEventPage' });
            })

            ListItem() {
              Row() {
                Badge({ count: 1, position: BadgePosition.RightTop, style: { badgeColor: '#34C759' } }) {
                  Column() {
                    Text('图书馆借阅到期提醒')
                      .fontSize(16)
                      .fontColor('#000')
                    Text('您借阅的《HarmonyOS应用开发实战》将于3天后到期...')
                      .fontSize(14)
                      .fontColor('#666')
                      .maxLines(1)
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                Text('1小时前')
                  .fontSize(12)
                  .fontColor('#999')
                  .margin({ left: 'auto' })
              }
              .padding(15)
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/LibraryRemindPage' });
            })

            // 已读消息
            ListItem() {
              Row() {
                Column() {
                  Text('请假审批通过')
                    .fontSize(16)
                    .fontColor('#000')
                  Text('您于10月8日提交的事假申请已通过审批')
                    .fontSize(14)
                    .fontColor('#666')
                    .maxLines(1)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                Text('2小时前')
                  .fontSize(12)
                  .fontColor('#999')
                  .margin({ left: 'auto' })
              }
              .padding(15)
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/LeaveDetailPage' });
            })

            ListItem() {
              Row() {
                Column() {
                  Text('成绩发布通知')
                    .fontSize(16)
                    .fontColor('#000')
                  Text('《移动应用开发》课程期末考试成绩已发布')
                    .fontSize(14)
                    .fontColor('#666')
                    .maxLines(1)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                Text('3小时前')
                  .fontSize(12)
                  .fontColor('#999')
                  .margin({ left: 'auto' })
              }
              .padding(15)
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/GradeQueryPage' });
            })

            ListItem() {
              Row() {
                Column() {
                  Text('社团活动邀请')
                    .fontSize(16)
                    .fontColor('#000')
                  Text('编程社团本周五晚上7点举办技术分享会，欢迎参加')
                    .fontSize(14)
                    .fontColor('#666')
                    .maxLines(1)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                Text('5小时前')
                  .fontSize(12)
                  .fontColor('#999')
                  .margin({ left: 'auto' })
              }
              .padding(15)
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/ClubActivityPage' });
            })

            ListItem() {
              Row() {
                Column() {
                  Text('宿舍卫生检查')
                    .fontSize(16)
                    .fontColor('#000')
                  Text('本周宿舍卫生检查评分：95分，继续保持！')
                    .fontSize(14)
                    .fontColor('#666')
                    .maxLines(1)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                Text('昨天')
                  .fontSize(12)
                  .fontColor('#999')
                  .margin({ left: 'auto' })
              }
              .padding(15)
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/DormitoryPage' });
            })

            ListItem() {
              Row() {
                Column() {
                  Text('校园卡消费提醒')
                    .fontSize(16)
                    .fontColor('#000')
                  Text('您今天在第二食堂消费28.5元，余额126.3元')
                    .fontSize(14)
                    .fontColor('#666')
                    .maxLines(1)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                Text('昨天')
                  .fontSize(12)
                  .fontColor('#999')
                  .margin({ left: 'auto' })
              }
              .padding(15)
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/CampusCardPage' });
            })

            ListItem() {
              Row() {
                Column() {
                  Text('讲座通知')
                    .fontSize(16)
                    .fontColor('#000')
                  Text('人工智能前沿技术讲座将于下周一下午2点在学术报告厅举行')
                    .fontSize(14)
                    .fontColor('#666')
                    .maxLines(1)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                Text('2天前')
                  .fontSize(12)
                  .fontColor('#999')
                  .margin({ left: 'auto' })
              }
              .padding(15)
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/LecturePage' });
            })

            ListItem() {
              Row() {
                Column() {
                  Text('志愿服务报名')
                    .fontSize(16)
                    .fontColor('#000')
                  Text('社区清洁志愿服务活动开始报名，欢迎同学们积极参与')
                    .fontSize(14)
                    .fontColor('#666')
                    .maxLines(1)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                Text('3天前')
                  .fontSize(12)
                  .fontColor('#999')
                  .margin({ left: 'auto' })
              }
              .padding(15)
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/VolunteerPage' });
            })
          }
          .width('100%')
          .layoutWeight(1)
          .divider({ strokeWidth: 1, color: '#F5F5F5' })
        }
      }
      .tabBar(this.TabItem('消息', '/images/message_normal.png', '/images/message_selected.png', 1))

      // 3. 我的Tab - 修改这个部分，确保个人中心入口在可视区域
      TabContent() {
        Scroll() {
          Column() {
            // ========== 将个人中心入口移到最前面 ==========
            Column() {
              Row() {
                Column() {
                  Text('完整个人中心')
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FFFFFF')
                    .margin({ bottom: 8 })
                  Text('查看详细个人信息和全部设置选项')
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                    .opacity(0.9)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Image($r('app.media.arrow_right'))
                  .size({ width: 28, height: 28 })
                  .fillColor(Color.White)
                  .margin({ right: 10 })
              }
              .width('100%')
              .padding(25)
              .backgroundColor('#007DFF')
              .borderRadius(16)
              .onClick(() => {
                console.info('点击进入完整个人中心');
                router.pushUrl({
                  url: 'pages/MinePage'
                }).then(() => {
                  console.info('成功跳转到MinePage');
                }).catch((err) => {
                  console.error('跳转失败:', err);
                  promptAction.showToast({ message: '页面跳转失败，请稍后重试' });
                });
              })
            }
            .width('95%')
            .margin({ top: 15, bottom: 15 })
            .shadow({ radius: 12, color: '#40007DFF', offsetX: 0, offsetY: 6 })

            // 顶部个人信息区域 - 简化版本
            Column() {
              // 头像和基本信息
              Row() {
                Image($r('app.media.course'))
                  .size({ width: 60, height: 60 })
                  .borderRadius(30)
                  .border({ width: 2, color: '#007DFF' })

                Column() {
                  Text('xxx')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#333333')
                    .margin({ bottom: 3 })

                  Text('学号: xxxxxxxx')
                    .fontSize(12)
                    .fontColor('#666666')
                    .margin({ bottom: 2 })

                  Text('xxx学院')
                    .fontSize(11)
                    .fontColor('#666666')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
                .margin({ left: 12 })
              }
              .width('100%')
              .padding({ left: 15, right: 15, top: 15, bottom: 15 })

              // 简化的数据统计
              Grid() {
                GridItem() {
                  Column() {
                    Text('5')
                      .fontSize(14)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#333333')
                    Text('请假')
                      .fontSize(10)
                      .fontColor('#666666')
                  }
                  .padding(8)
                  .backgroundColor(Color.White)
                  .borderRadius(6)
                  .width('100%')
                  .alignItems(HorizontalAlign.Center)
                }

                GridItem() {
                  Column() {
                    Text('3')
                      .fontSize(14)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#333333')
                    Text('通知')
                      .fontSize(10)
                      .fontColor('#666666')
                  }
                  .padding(8)
                  .backgroundColor(Color.White)
                  .borderRadius(6)
                  .width('100%')
                  .alignItems(HorizontalAlign.Center)
                }

                GridItem() {
                  Column() {
                    Text('12')
                      .fontSize(14)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#333333')
                    Text('课程')
                      .fontSize(10)
                      .fontColor('#666666')
                  }
                  .padding(8)
                  .backgroundColor(Color.White)
                  .borderRadius(6)
                  .width('100%')
                  .alignItems(HorizontalAlign.Center)
                }

                GridItem() {
                  Column() {
                    Text('8')
                      .fontSize(14)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#333333')
                    Text('借阅')
                      .fontSize(10)
                      .fontColor('#666666')
                  }
                  .padding(8)
                  .backgroundColor(Color.White)
                  .borderRadius(6)
                  .width('100%')
                  .alignItems(HorizontalAlign.Center)
                }
              }
              .columnsTemplate('1fr 1fr 1fr 1fr')
              .columnsGap(6)
              .rowsGap(6)
              .padding({ left: 15, right: 15, bottom: 15 })
            }
            .backgroundColor(Color.White)
            .width('100%')
            .borderRadius(10)
            .margin({ bottom: 15, left: 10, right: 10 })
            .border({ width: 1, color: '#E0E0E0' })
            .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })

            // 快捷功能入口 - 简化版本
            Column() {
              Text('快捷功能')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .margin({ left: 15, top: 10, bottom: 10 })
                .alignSelf(ItemAlign.Start)

              Grid() {
                GridItem() {
                  Column() {
                    Text('📱')
                      .fontSize(24)
                      .margin({ bottom: 6 })
                    Text('二维码')
                      .fontSize(11)
                      .textAlign(TextAlign.Center)
                  }
                  .width('100%')
                  .padding(12)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(10)
                  .border({ width: 1, color: '#E8E8E8' })
                  .onClick(() => {
                    promptAction.showToast({ message: '生成个人二维码' });
                  })
                }

                GridItem() {
                  Column() {
                    Text('📅')
                      .fontSize(24)
                      .margin({ bottom: 6 })
                    Text('课程表')
                      .fontSize(11)
                      .textAlign(TextAlign.Center)
                  }
                  .width('100%')
                  .padding(12)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(10)
                  .border({ width: 1, color: '#E8E8E8' })
                  .onClick(() => {
                    router.pushUrl({ url: 'pages/CoursePage' });
                  })
                }

                GridItem() {
                  Column() {
                    Text('📊')
                      .fontSize(24)
                      .margin({ bottom: 6 })
                    Text('成绩')
                      .fontSize(11)
                      .textAlign(TextAlign.Center)
                  }
                  .width('100%')
                  .padding(12)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(10)
                  .border({ width: 1, color: '#E8E8E8' })
                  .onClick(() => {
                    router.pushUrl({ url: 'pages/GradeQueryPage' });
                  })
                }

                GridItem() {
                  Column() {
                    Text('📚')
                      .fontSize(24)
                      .margin({ bottom: 6 })
                    Text('借阅')
                      .fontSize(11)
                      .textAlign(TextAlign.Center)
                  }
                  .width('100%')
                  .padding(12)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(10)
                  .border({ width: 1, color: '#E8E8E8' })
                  .onClick(() => {
                    router.pushUrl({ url: 'pages/MyBorrowPage' });
                  })
                }
              }
              .columnsTemplate('1fr 1fr 1fr 1fr')
              .columnsGap(8)
              .rowsGap(8)
              .padding({ left: 15, right: 15, bottom: 15 })
            }
            .width('100%')
            .backgroundColor('#F8F8F8')
            .borderRadius(10)
            .margin({ left: 10, right: 10, bottom: 20 })
            .border({ width: 1, color: '#E8E8E8' })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F0F0F0')
      }
      .tabBar(this.TabItem('我的', '/images/mine_normal.png', '/images/mine_selected.png', 2))
    }
    .onChange((index) => {
      this.currentIndex = index;
    })
    .size({ width: '100%', height: '100%' })
    .backgroundColor('#F5F5F5')
  }
}