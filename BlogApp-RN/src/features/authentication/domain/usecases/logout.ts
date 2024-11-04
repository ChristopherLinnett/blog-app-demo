import { AsyncResult } from "../../../../core/typedefs/asyncResult";
import { ResponseMessage } from "../../data/models/responseMessage";
import AuthRepo from "../repos/authRepo";

class Logout {
  constructor(private repo: AuthRepo) {}
  call: () => AsyncResult<ResponseMessage> = () => {
    return this.repo.logout();
  };
}

export default Logout;
