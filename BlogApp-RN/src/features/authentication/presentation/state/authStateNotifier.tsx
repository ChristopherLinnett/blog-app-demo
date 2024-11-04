import { StateNotifier } from "@/src/core/typedefs/stateNotifier";
import { ReactNode, useMemo, useState } from "react";
import { createContext, useContextSelector } from "use-context-selector";
import AuthState from "./authState";

type AuthContextType = StateNotifier<AuthState, AuthNotifierFunctions>;

export interface AuthNotifierFunctions {
  createAuth: (newState: AuthState) => void;
  clearUser: () => void;
  refreshToken: () => void;
}

export const AuthContext = createContext<AuthContextType | undefined>(
  undefined
);

export const AuthStateProvider: React.FC<{ children: ReactNode }> = ({
  children,
}) => {
  const [state, setState] = useState<AuthState>(new AuthState({}, {}));
  const notifier: AuthNotifierFunctions = useMemo(
    () => ({
      createAuth: (newState: AuthState) => setState(newState),
      clearUser: () => setState(new AuthState({}, {})),
      refreshToken: () =>
        state.token.value !== undefined
          ? setState((prevState) =>
              prevState.copyWith({
                token: {
                  ...prevState.token,
                  expires: new Date().getTime() + 10 * 60 * 1000,
                },
              })
            )
          : null,
    }),
    []
  );

  const stateValue = useMemo(
    () => ({
      state,
      notifier,
    }),
    [state, notifier]
  );

  return (
    <AuthContext.Provider value={stateValue}>{children}</AuthContext.Provider>
  );
};

export const useAuthSelector = <T,>(selector: (state: AuthState) => T): T => {
  return useContextSelector(AuthContext, (context) => {
    if (!context)
      throw new Error("useAuthSelector must be used within an AuthProvider");
    return selector(context.state);
  });
};
