import { useContext } from "use-context-selector";

import { StateNotifier } from "@/src/core/typedefs/stateNotifier";
import AuthState from "./authState";
import { AuthContext, AuthNotifierFunctions } from "./authStateNotifier";

export const useAuthState = (): StateNotifier<
  AuthState,
  AuthNotifierFunctions
> => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error("useAuth must be used within a DIProvider");
  }
  return context;
};
