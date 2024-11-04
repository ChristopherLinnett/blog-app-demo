import FilledButton from "@/src/components/FilledButton";
import { StyleSheet, Text, View } from "react-native";

export const LoadingFailureView: React.FC<{ onRetry: () => any, dataType: string }> = ({ onRetry, dataType }) => {
  return (
    <View
      style={{
        alignContent: "center",
        justifyContent: "center",
        flex: 1,
        flexDirection: "row",
      }}
    >
      <View style={styles.errorContainer}>
        <Text style={styles.errorText}>
          Failed to load {dataType}. Please try again later.
        </Text>
        <FilledButton
          fillColour="#4CAF50"
          text="Retry"
          textColour="#fff"
          onPressed={onRetry}
        />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  errorContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    maxWidth: "80%",
  },
  errorText: {
    color: "red",
    fontSize: 16,
    marginBottom: 10,
  },
});
