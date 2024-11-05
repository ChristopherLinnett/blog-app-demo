import { AxiosError, AxiosInstance, AxiosResponse } from "axios";
import { Platform } from "react-native";
import {
  AuthException,
  ServerException,
  UnknownException,
} from "../../../../core/errors/exceptions";
import { AuthResponse } from "../models/authResponse";
import { ResponseMessage } from "../models/responseMessage";
import AuthDatasource from "./authDatasource";

class AuthDatasourceImplementation implements AuthDatasource {
  url: string;
  constructor(private httpClient: AxiosInstance) {
    const address = Platform.OS === "ios" ? "localhost" : "10.0.2.2";
    this.url = `http://${address}:3001/api/auth`;
  }

  login: (username: string, password: string) => Promise<AuthResponse> = async (
    username,
    password
  ) => {
    const endpoint = `${this.url}/login`;
    const body: AuthRequest = { username: username, password: password };
    try {
      const response: AxiosResponse<AuthResponse> =
        await this.httpClient.post<AuthResponse>(endpoint, body);
      const authResponse: AuthResponse = response.data;
      return authResponse;
    } catch (exception) {
      if (exception instanceof AxiosError) {
        if (exception.code === "ERR_NETWORK") {
          throw new ServerException("Could not connect to the server", 503);
        }
        throw new AuthException(
          exception.response?.data["message"] as string,
          exception.code
        );
      }
      throw new UnknownException("An Unknown Exception has occurred", 500);
    }
  };

  signUp: (username: string, password: string) => Promise<AuthResponse> =
    async (username, password) => {
      const endpoint = `${this.url}/signUp`;
      const body: AuthRequest = { username, password };
      try {
        const response: AxiosResponse<AuthResponse> =
          await this.httpClient.post<AuthResponse>(endpoint, body);
        return response.data;
      } catch (exception) {
        if (exception instanceof AxiosError) {
          if (exception.code === "ERR_NETWORK") {
            throw new ServerException("Could not connect to the server", 503);
          }
          throw new AuthException(
            exception.response?.data["message"] as string,
            exception.code
          );
        }
        throw new UnknownException("An Unknown Exception has occurred", 500);
      }
    };

  logout: () => Promise<ResponseMessage> = () => {
    const success: ResponseMessage = { message: "success" };
    return Promise.resolve(success);
  };
}


export default AuthDatasourceImplementation;
