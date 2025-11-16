import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 通知数据结构（不变）
interface Notice {
  id: number;
  title: string;
  time: string;
  isRead: boolean;
  content: string;
  source: string;
}

@Entry
@Component
struct NoticeListPage {
  @State notices: Notice[] = [
    { id: 1, title: '2025年秋季运动会报名通知', time: '2025-10-24', isRead: false, content: '运动会11月15日举行...', source: '体育部' },
    { id: 2, title: '图书馆新增电子资源', time: '2025-10-23', isRead: true, content: '新增知网数据库...', source: '图书馆' }
  ];
  @State searchKey: string = '';
  @State filteredNotices: Notice[] = [];

  aboutToAppear() {
    this.filteredNotices = this.notices;
  }

  filterNotices(key: string) {
    this.filteredNotices = key ? this.notices.filter(n => n.title.includes(key) || n.source.includes(key)) : this.notices;
  }

  markAsRead(noticeId: number) {
    this.notices = this.notices.map(n => n.id === noticeId ? { ...n, isRead: true } : n);
    this.filterNotices(this.searchKey);
  }

  build() {
    Column() {
      // 顶部导航栏：添加返回按钮（核心修改）
      Row() {
        Button('返回')
          .fontSize(16)
          .fontColor('#007DFF')
          .backgroundColor(Color.Transparent)
          .onClick(() => router.back()) // 点击返回上一页

        Text('校园通知')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(15)
      .backgroundColor(Color.White)

      // 搜索框（不变）
      Search({ placeholder: '搜索通知', value: this.searchKey })
        .width('90%')
        .margin({ top: 10, bottom: 10 })
        .onChange((value) => { this.searchKey = value; this.filterNotices(value); })
        .searchButton('搜索')
        .onSubmit(() => {
          promptAction.showToast({ message: `找到${this.filteredNotices.length}条通知` });
        })

      // 通知列表（不变，注释详情页跳转）
      if (this.filteredNotices.length > 0) {
        List() {
          ForEach(this.filteredNotices, (notice: Notice) => {
            ListItem() {
              Column() {
                Row() {
                  Column() {
                    Row() {
                      if (!notice.isRead) {
                        Badge({ count: 1, position: BadgePosition.RightTop, style: { badgeColor: '#FF3B30' } }) {
                          Text(notice.title).fontSize(17).maxLines(2).textOverflow({ overflow: TextOverflow.Ellipsis })
                        }
                      } else {
                        Text(notice.title).fontSize(17).fontColor('#888').maxLines(2).textOverflow({ overflow: TextOverflow.Ellipsis })
                      }
                    }
                    Row() {
                      Text(notice.source).fontSize(14).fontColor('#666'); Blank(); Text(notice.time).fontSize(14).fontColor('#999')
                    }.margin({ top: 8 })
                  }.layoutWeight(1)
                  Image($r('app.media.arrow_right')).width(20).height(20).margin({ left: 10 })
                }
              }
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
              .onClick(() => {
                this.markAsRead(notice.id);
                // 注释详情页跳转，聚焦5个模块
                promptAction.showToast({ message: `查看${notice.title}详情` });
              })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })
      } else {
        Column() {
          Image($r('app.media.course')).width(120).height(120).margin({ bottom: 20 })
          Text('未找到相关通知').fontSize(16).fontColor('#999')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}