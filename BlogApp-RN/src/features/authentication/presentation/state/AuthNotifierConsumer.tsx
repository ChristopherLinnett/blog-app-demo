import React, { ReactNode } from "react";
import { AuthNotifierFunctions } from "./authStateNotifier";
import { useAuthState } from "./authStateProvider";

export const AuthNotifierConsumer: React.FC<{
  children: (notifier: AuthNotifierFunctions) => ReactNode;
}> = ({ children }) => {
  const { notifier } = useAuthState();

  return <>{children(notifier)}</>;
};
