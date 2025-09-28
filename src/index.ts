import { scheduleAlarmOptions } from "./ExpoAlarms.types";
import ExpoAlarmsModule from "./ExpoAlarmsModule";

export function setAlarm(options: scheduleAlarmOptions): Promise<string> {
  const { hour, minute, label, weekdays } = options;
  return ExpoAlarmsModule.setAlarm(hour, minute, label, weekdays);
}

export function checkPermission(): Promise<boolean> {
  return ExpoAlarmsModule.checkPermission();
}
