import ExpoAlarmsModule from "./ExpoAlarmsModule";

export function setAlarm(): Promise<string> {
  return ExpoAlarmsModule.setAlarm();
}

export function checkPermission(): Promise<boolean> {
  return ExpoAlarmsModule.checkPermission();
}
