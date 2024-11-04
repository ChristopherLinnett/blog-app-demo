import FilledButton from "@/src/components/FilledButton";
import { LoadingView } from "@/src/components/LoadingView";
import { StyleSheet, Text, TextInput, View } from "react-native";
import { useAuthForm } from "../hooks/useAuthForm";
import { useHandleAuth } from "../hooks/useHandleAuth";

const AuthPage = () => {
  const [email, password, error] = useAuthForm(); // Creates local state for managing the email, password, and errors. Provides nested value, and update function

  const { loading: signUpLoading, fn: signUp } = useHandleAuth("signUp"); //Gives back the function and loading state for signUpProcess
  const { loading: loginLoading, fn: login } = useHandleAuth("login"); // Gives back the function and loading state for loginProcess

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Welcome</Text>
      <Text style={styles.subtitle}>Please sign in to continue</Text>
      <TextInput
        editable={!signUpLoading && !loginLoading}
        style={styles.input}
        placeholder="Email"
        placeholderTextColor="#888"
        value={email.get}
        onChangeText={email.set}
        keyboardType="email-address"
        autoCapitalize="none"
      />
      <TextInput
        editable={!signUpLoading && !loginLoading}
        style={styles.input}
        placeholder="Password"
        placeholderTextColor="#888"
        value={password.get}
        onChangeText={password.set}
        secureTextEntry
      />
      {signUpLoading || loginLoading ? (
        <LoadingView />
      ) : (
        <Text
          style={{
            ...styles.errorMessage,
            color: error.get.length > 0 ? "red" : "transparent",
          }}
        >
          {error.get.length > 0 ? `${error.get}` : "None"}
        </Text>
      )}
      <FilledButton
        fillColour={styles.button.backgroundColor}
        text="Log In"
        disabled={signUpLoading || loginLoading}
        textColour={styles.buttonText.color}
        onPressed={() => login(email.get, password.get, error.set)}
      />
      <FilledButton
        fillColour={"transparent"}
        text="Sign Up"
        disabled={signUpLoading || loginLoading}
        textColour={styles.secondaryButtonText.color}
        onPressed={() => signUp(email.get, password.get, error.set)}
      />
    </View>
  );
};

export default AuthPage;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    padding: 20,
    backgroundColor: "#f5f5f5",
  },
  title: {
    fontSize: 32,
    fontWeight: "bold",
    color: "#333",
    marginBottom: 10,
  },
  subtitle: {
    fontSize: 16,
    color: "#666",
    marginBottom: 30,
  },
  input: {
    width: "100%",
    padding: 15,
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 8,
    marginBottom: 20,
    backgroundColor: "#fff",
  },
  button: {
    width: "100%",
    padding: 15,
    backgroundColor: "#4CAF50",
    borderRadius: 8,
    alignItems: "center",
    marginTop: 10,
  },
  buttonText: {
    color: "#fff",
    fontSize: 18,
    fontWeight: "bold",
  },
  secondaryButton: {
    marginTop: 15,
  },
  secondaryButtonText: {
    color: "#4CAF50",
    fontSize: 16,
    fontWeight: "bold",
  },
  errorMessage: {
    fontSize: 16,
    paddingVertical: 8.5,
  },
});
