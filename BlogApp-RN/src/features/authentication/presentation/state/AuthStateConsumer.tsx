import React, { ReactNode } from "react";
import AuthState from "./authState";
import { useAuthSelector } from "./authStateNotifier";

type SelectedAuthState<T extends keyof AuthState> = {
  [P in T]: AuthState[P];
};

interface AuthStateConsumerProps<T extends keyof AuthState> {
  listenTo: T | T[];
  children: (selectedValues: SelectedAuthState<T>) => ReactNode;
}

export const AuthStateConsumer = <T extends keyof AuthState>({
  listenTo: properties,
  children,
}: AuthStateConsumerProps<T>): JSX.Element => {
  const selectedValues = (
    Array.isArray(properties)
      ? properties.reduce((acc, prop) => {
          acc[prop] = useAuthSelector((state) => state[prop]);
          return acc;
        }, {} as SelectedAuthState<T>)
      : { [properties]: useAuthSelector((state) => state[properties]) }
  ) as SelectedAuthState<T>;

  return <>{children(selectedValues)}</>;
};
