import * as Alarms from "expo-alarms";
import { useEffect, useState } from "react";
import { Text, View } from "react-native";

export default function App() {
  const [permission, setPermission] = useState("");

  const askPermission = async () => {
    const response = await Alarms.askPermission();
    console.log(response);
    setPermission(response);
  };

  useEffect(() => {
    askPermission();
  }, []);

  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Text>API key: {Alarms.getApiKey()}</Text>
      <Text>Permission: {permission}</Text>
    </View>
  );
}
