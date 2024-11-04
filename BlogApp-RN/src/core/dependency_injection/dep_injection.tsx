import { useAuthState } from "@/src/features/authentication/presentation/state/authStateProvider";
import axios from "axios";
import { createContext, ReactNode, useContext } from "react";
import { Services } from "./services";

const DIContext = createContext<Services | undefined>(undefined);

export const DIProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const axiosClient = axios.create();
  const { notifier, state: authState } = useAuthState();
  const { refreshToken } = notifier;

  axiosClient.interceptors.request.use(
    (config) => {
      const token = authState.token.value; // Access current token from auth state
      if (token) {
        config.headers["Authorization"] = `Bearer ${token}`;
      }
      return config;
    },
    (error) => {
      return Promise.reject("Your Authorization Token has expired");
    }
  );

  axiosClient.interceptors.response.use(
    (response) => {
      refreshToken(); // Extend token expiry on each successful response
      return response;
    },
    (error) => {
      return Promise.reject(error); // Forward errors as usual
    }
  );
  const services = new Services(axiosClient);

  return <DIContext.Provider value={services}>{children}</DIContext.Provider>;
};

export const useServices = (): Services => {
  const context = useContext(DIContext);
  if (context === undefined) {
    throw new Error("useServices must be used within a DIProvider");
  }
  return context;
};
