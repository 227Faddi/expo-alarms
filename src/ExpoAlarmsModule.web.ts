import { registerWebModule, NativeModule } from 'expo';

import { ExpoAlarmsModuleEvents } from './ExpoAlarms.types';

class ExpoAlarmsModule extends NativeModule<ExpoAlarmsModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpoAlarmsModule, 'ExpoAlarmsModule');
