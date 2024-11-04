import { ActivityIndicator, StyleSheet, View, ViewStyle } from "react-native";

export const LoadingView: React.FC<{ style?: ViewStyle }> = ({ style }) => {
  return (
    <View style={{ ...styles.loader, ...style }}>
      <ActivityIndicator size="large" color="#4CAF50" />
    </View>
  );
};

const styles = StyleSheet.create({
  loader: {
    justifyContent: "center",
    alignItems: "center",
  },
});
