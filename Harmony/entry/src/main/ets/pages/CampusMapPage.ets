import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 定义地点数据类型接口
interface CampusLocation {
  id: number;
  name: string;
  type: string;
  desc: string;
}

// 校园地点数据
const campusLocations: CampusLocation[] = [
  { id: 1, name: '教学楼1栋', type: 'teaching', desc: '主要承担电子信息与物理学院课程' },
  { id: 2, name: '图书馆', type: 'library', desc: '开放时间：08:00-22:00' },
  { id: 3, name: '第一食堂', type: 'canteen', desc: '推荐窗口：三楼麻辣烫' },
  { id: 4, name: '操场', type: 'sports', desc: '包含400米跑道和足球场' },
  { id: 5, name: '教学楼2栋', type: 'teaching', desc: '主要承担文学院课程' },
  { id: 6, name: '第二食堂', type: 'canteen', desc: '推荐窗口：二楼早餐区' },
];

@Entry
@Component
struct CampusMapPage {
  @State selectedType: string = 'all';
  @State filteredLocations: CampusLocation[] = campusLocations;
  @State showDetail: boolean = false;
  @State currentLocation: CampusLocation | null = null;

  // 返回主页
  onBackPress() {
    router.back();
    promptAction.showToast({ message: '返回主页' });
    return true;
  }

  filterLocations(type: string) {
    this.selectedType = type;
    this.filteredLocations = type === 'all'
      ? campusLocations
      : campusLocations.filter(item => item.type === type);
  }

  build() {
    // 最外层Column：占满屏幕
    Column() {
      // 自定义导航栏
      Row() {
        Button('← 返回')
          .fontSize(16)
          .fontColor('#007DFF')
          .backgroundColor(Color.Transparent)
          .borderColor(Color.Transparent)
          .onClick(() => {
            router.back();
            promptAction.showToast({ message: '返回主页' });
          })

        Text('校园地图')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 5, bottom: 5, left: 10, right: 10 })
      .backgroundColor(Color.White)

      // 用Divider替代borderBottom实现底部边框效果
      Divider()
        .color('#EEEEEE')
        .height(0.5)
        .width('100%')

      // 侧边栏容器
      SideBarContainer(SideBarContainerType.Embed) {
        // 左侧侧边栏
        List() {
          ListItem() { Button('全部地点').width('100%').backgroundColor(this.selectedType === 'all' ? '#1677FF' : '#F5F5F5').fontColor(this.selectedType === 'all' ? Color.White : Color.Black).onClick(() => this.filterLocations('all')) }
          ListItem() { Button('教学楼').width('100%').backgroundColor(this.selectedType === 'teaching' ? '#1677FF' : '#F5F5F5').fontColor(this.selectedType === 'teaching' ? Color.White : Color.Black).onClick(() => this.filterLocations('teaching')) }
          ListItem() { Button('图书馆').width('100%').backgroundColor(this.selectedType === 'library' ? '#1677FF' : '#F5F5F5').fontColor(this.selectedType === 'library' ? Color.White : Color.Black).onClick(() => this.filterLocations('library')) }
          ListItem() { Button('食堂').width('100%').backgroundColor(this.selectedType === 'canteen' ? '#1677FF' : '#F5F5F5').fontColor(this.selectedType === 'canteen' ? Color.White : Color.Black).onClick(() => this.filterLocations('canteen')) }
          ListItem() { Button('运动场地').width('100%').backgroundColor(this.selectedType === 'sports' ? '#1677FF' : '#F5F5F5').fontColor(this.selectedType === 'sports' ? Color.White : Color.Black).onClick(() => this.filterLocations('sports')) }
        }
        .width(150)
        .backgroundColor('#F0F0F0')
        .padding(10)

        // 右侧主内容区
        Column() {
          // 地图图片
          Image($r('app.media.course'))
            .width('100%')
            .height(250)
            .backgroundColor('#EEEEEE')
            .objectFit(ImageFit.Cover)
            .alt($r('app.media.icon'))
            .margin({ bottom: 5 })

          // 地点列表
          List() {
            ForEach(this.filteredLocations, (item) => {
              ListItem() {
                Row() {
                  Text(item.name)
                    .fontSize(17)
                  Button('查看详情')
                    .fontSize(14)
                    .margin({ left: 'auto' })
                    .onClick(() => {
                      this.currentLocation = item;
                      this.showDetail = true;
                    })
                }
                .padding(15)
                .backgroundColor(Color.White)
                .borderRadius(8)
                .margin({ bottom: 8 })
              }
            })
          }
          .padding(10)
          .backgroundColor('#F9F9F9')
          .layoutWeight(1)
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // 详情弹窗
      if (this.showDetail && this.currentLocation) {
        Column() {
          Text(this.currentLocation.name).fontSize(20).fontWeight(FontWeight.Bold).margin({ bottom: 15 })
          Text(`描述：${this.currentLocation.desc}`).fontSize(16).margin({ bottom: 20 })
          Button('关闭').width('50%').onClick(() => this.showDetail = false)
        }
        .padding(20)
        .backgroundColor(Color.White)
        .borderRadius(10)
        .width('80%')
        .position({ x: '10%', y: '25%' })
        .shadow({ radius: 10, color: 'rgba(0,0,0,0.3)' })
      }
    }
    .size({ width: '100%', height: '100%' })
    .backgroundColor('#F5F5F5')
  }
}