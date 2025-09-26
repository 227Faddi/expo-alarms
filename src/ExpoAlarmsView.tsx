import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoAlarmsViewProps } from './ExpoAlarms.types';

const NativeView: React.ComponentType<ExpoAlarmsViewProps> =
  requireNativeView('ExpoAlarms');

export default function ExpoAlarmsView(props: ExpoAlarmsViewProps) {
  return <NativeView {...props} />;
}
