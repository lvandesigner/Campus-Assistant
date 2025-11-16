import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', 'Ability onCreate');

    // 初始化密码状态 - 使用全局 AppStorage
    AppStorage.SetOrCreate('isPasswordSet', false);
    AppStorage.SetOrCreate('userPassword', '');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage) {
    hilog.info(0x0000, 'testTag', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content.');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy() {
    hilog.info(0x0000, 'testTag', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    hilog.info(0x0000, 'testTag', 'Ability onForeground');
  }

  onBackground() {
    hilog.info(0x0000, 'testTag', 'Ability onBackground');
  }
}