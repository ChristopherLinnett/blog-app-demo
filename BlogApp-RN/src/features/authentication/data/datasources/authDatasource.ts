import { AuthResponse } from "../models/authResponse";
import { ResponseMessage } from "../models/responseMessage";

abstract class AuthDatasource {
  abstract login: (username: string, password: string) => Promise<AuthResponse>;
  abstract logout: () => Promise<ResponseMessage>;
  abstract signUp: (username: string, password: string) => Promise<AuthResponse>;
}

export default AuthDatasource;
