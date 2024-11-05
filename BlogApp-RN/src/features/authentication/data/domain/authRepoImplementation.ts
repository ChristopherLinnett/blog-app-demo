import { handleException } from "@/src/core/errors/handleException";
import { left, right } from "fp-ts/lib/Either";
import { AsyncResult } from "../../../../core/typedefs/asyncResult";
import AuthRepo from "../../domain/repos/authRepo";
import AuthDatasource from "../datasources/authDatasource";
import { AuthResponse } from "../models/authResponse";
import { ResponseMessage } from "../models/responseMessage";

class AuthRepoImplementation implements AuthRepo {
  constructor(private datasource: AuthDatasource) {}
  login: (username: string, password: string) => AsyncResult<AuthResponse> =
    async (username: string, password: string) => {
      try {
        const result = await this.datasource.login(username, password);
        return right(result);
      } catch (exception) {
        return left(handleException(exception));
      }
    };

  logout: () => AsyncResult<ResponseMessage> = async () => {
    try {
      const result = await this.datasource.logout();
      return right(result);
    } catch (exception) {
      return left(handleException(exception));
    }
  };

  signUp: (username: string, password: string) => AsyncResult<AuthResponse> =
    async (username: string, password: string) => {
      try {
        const result = await this.datasource.signUp(username, password);
        return right(result);
      } catch (exception) {
        return left(handleException(exception));
      }
    };
}

export default AuthRepoImplementation;
