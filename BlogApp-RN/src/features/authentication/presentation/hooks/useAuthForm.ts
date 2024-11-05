import { useState } from "react";

export const useAuthForm = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [errorMessage, setErrorMessage] = useState("");

  const updateEmail = (value: string) => {
    if (errorMessage.length > 0) {
      setErrorMessage("");
    }
    setEmail(value);
  };

  const updateError = (error: string | undefined) => {
    setErrorMessage(error ?? "");
  };

  const updatePassword = (value: string) => {
    if (errorMessage.length > 0) {
      setErrorMessage("");
    }
    setPassword(value);
  };

  return [
    { get: email, set: updateEmail },
    { get: password, set: updatePassword },
    { get: errorMessage, set: updateError },
  ];
};
