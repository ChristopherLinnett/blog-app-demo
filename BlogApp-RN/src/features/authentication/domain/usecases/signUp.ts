import { AsyncResult } from "../../../../core/typedefs/asyncResult";
import { AuthResponse } from "../../data/models/authResponse";
import AuthRepo from "../repos/authRepo";

class SignUp {
  constructor(private repo: AuthRepo) {}

  call: (username: string, password: string) => AsyncResult<AuthResponse> = (
    username,
    password
  ) => {
    return this.repo.signUp(username, password);
  };
}

export default SignUp;
