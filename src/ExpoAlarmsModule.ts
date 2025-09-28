import { NativeModule, requireNativeModule } from "expo";

declare class ExpoAlarmsModule extends NativeModule {
  setAlarm(
    hour: number,
    minute: number,
    label: string,
    weekdays?: number[]
  ): Promise<string>;
  checkPermission(): Promise<boolean>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoAlarmsModule>("ExpoAlarms");
