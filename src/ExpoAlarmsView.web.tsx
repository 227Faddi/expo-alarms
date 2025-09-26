import * as React from 'react';

import { ExpoAlarmsViewProps } from './ExpoAlarms.types';

export default function ExpoAlarmsView(props: ExpoAlarmsViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
