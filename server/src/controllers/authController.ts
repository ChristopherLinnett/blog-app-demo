import { NextFunction, Request, Response } from "express";
import { v4 as uuidv4 } from "uuid";
import { Token } from "../models/tokens";
import { User, users, UserWithPassword } from "../models/user";
import { ResponseMessage } from "../types/types";
import { clearExistingToken, createNewToken } from "./authTokenController";

const login: (req: Request, res: Response, next: NextFunction) => void = (
  req: Request<any, any, UserRequest>,
  res: Response<AuthResponse | ResponseMessage>,
  _next: NextFunction
) => {
  const { username, password } = req.body;
  if (username === undefined || password === undefined) {
    return res.status(402).json({ message: "Please fill out all fields" });
  }
  const user: UserWithPassword | undefined = users.find(
    (user) => user.email === username
  );
  if (!user) {
    return res.status(401).json({ message: "User not found" });
  }
  if (user.password !== password) {
    return res.status(401).json({ message: "Incorrect password" });
  }
  clearExistingToken(user.id);
  const newToken = createNewToken(user.id);
  return res.status(200).json({
    user: { id: user.id, email: user.email, role: user.role },
    token: newToken,
  });
};

const signUp: (req: Request, res: Response, next: NextFunction) => void = (
  req: Request<any, any, UserRequest>,
  res: Response<AuthResponse | ResponseMessage>
) => {
  const { username, password } = req.body;
  if (username === undefined || password === undefined) {
    return res.status(402).json({ message: "Please fill out all fields" });
  }
  const user = users.find((user) => user.email === username);
  if (user) {
    return res.status(409).json({ message: "User already exists" });
  }
  const newUserId = uuidv4();
  const newUser: UserWithPassword = {
    email: username,
    id: newUserId,
    role: "student",
    password: password,
  };
  users.push(newUser);
  const newToken = createNewToken(newUserId);
  return res.status(200).json({
    user: { id: newUser.id, email: newUser.email, role: newUser.role },
    token: newToken,
  });
};

interface AuthResponse {
  user: User;
  token: Token;
}

interface UserRequest {
  username: string;
  password: string;
}

export { login, signUp };
