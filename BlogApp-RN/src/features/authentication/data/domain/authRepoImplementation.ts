import { left, right } from "fp-ts/lib/Either";
import {
  AuthException,
  ServerException,
} from "../../../../core/errors/exceptions";
import {
  AuthFailure,
  ServerFailure,
  UnknownFailure,
} from "../../../../core/errors/failures";
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
        if (exception instanceof AuthException) {
          return left(AuthFailure.fromException(exception));
        }
        return left(new UnknownFailure("Unknown Error Has Occurred", 500));
      }
    };

  logout: () => AsyncResult<ResponseMessage> = async () => {
    try {
      const result = await this.datasource.logout();
      return right(result);
    } catch (exception) {
      if (exception instanceof ServerException) {
        return left(ServerFailure.fromException(exception));
      }
      return left(new UnknownFailure("Unknown Error Has Occurred", 500));
    }
  };

  signUp: (username: string, password: string) => AsyncResult<AuthResponse> =
    async (username: string, password: string) => {
      try {
        const result = await this.datasource.signUp(username, password);
        return right(result);
      } catch (exception) {
        if (exception instanceof AuthException) {
          return left(AuthFailure.fromException(exception));
        }
        return left(new UnknownFailure("Unknown Error Has Occurred", 500));
      }
    };
}

export default AuthRepoImplementation;
