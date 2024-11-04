import { AsyncResult } from "../../../../core/typedefs/asyncResult";
import { AuthResponse } from "../../data/models/authResponse";
import { ResponseMessage } from "../../data/models/responseMessage";

abstract class AuthRepo {
  abstract login: (username: string, password: string) => AsyncResult<AuthResponse>;
  abstract logout: () => AsyncResult<ResponseMessage>;
  abstract signUp: (username: string, password: string) => AsyncResult<AuthResponse>;
}

export default AuthRepo;
