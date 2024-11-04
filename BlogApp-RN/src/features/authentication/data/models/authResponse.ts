import { User } from "../../presentation/state/authState";
import { Token } from "./token";

export interface AuthResponse {
    user: User;
    token: Token;
  }