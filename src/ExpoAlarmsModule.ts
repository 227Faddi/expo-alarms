import { NativeModule, requireNativeModule } from 'expo';

import { ExpoAlarmsModuleEvents } from './ExpoAlarms.types';

declare class ExpoAlarmsModule extends NativeModule<ExpoAlarmsModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoAlarmsModule>('ExpoAlarms');
