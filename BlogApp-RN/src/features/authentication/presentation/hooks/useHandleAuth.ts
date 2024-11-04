import { useDependencyFn } from "@/src/core/dependency_injection/useDependencyFn";
import { isLeft } from "fp-ts/lib/Either";
import { useState } from "react";
import AuthState from "../state/authState";
import { useAuthState } from "../state/authStateProvider";

export const useHandleAuth = (type: "signUp" | "login") => {
  const authFn = useDependencyFn(type);
  const { createAuth, clearUser } = useAuthState().notifier;
  const [loading, setLoading] = useState(false);
  const fn = async (
    email: string,
    password: string,
    onError: (message: string) => void
  ) => {
    clearUser();
    setLoading(true);
    const result = await authFn(email, password);
    if (isLeft(result)) {
      setLoading(false);
      return onError(result.left.message);
    }
    setLoading(false);
    createAuth(new AuthState(result.right.user, result.right.token));
  };

  return { loading: loading, fn: fn };
};
