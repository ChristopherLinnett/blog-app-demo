import { NextFunction, Request, Response } from "express";
import jwt from "jsonwebtoken";
import { Token, tokens } from "../models/tokens";
import { users } from "../models/user";
import { ResponseMessage } from "../types/types";

export const checkToken: (
  req: Request<any, any, any, any, TokenHeader>,
  res: Response<ResponseMessage>,
  next: NextFunction
) => void = (req, res, next) => {
  // Get token from request headers
  const tokenValue = req.header("Authorization")?.replace("Bearer ", "");
  if (!tokenValue) {
    return res.status(401).json({ message: "Unauthorized: No token provided" });
  }

  const tokenIndex = tokens.findIndex((t) => t.value === tokenValue);
  const token = tokenIndex !== -1 ? tokens[tokenIndex] : null;

  if (!token) {
    return res.status(401).json({ message: "Unauthorized: Invalid token" });
  }

  const now = new Date().getTime();
  if (now > token.expires) {
    tokens.splice(tokenIndex, 1);
    return res.status(401).json({ message: "Token expired" });
  }

  token.expires = now + 10 * 60 * 1000; // Extend by 10 minutes
  next();
};

export const clearExistingToken: (userId: string) => void = (userId) => {
  const tokenIndex = tokens.findIndex((t) => t.id === userId);
  if (tokenIndex === -1) return;
  tokens.splice(tokenIndex);
  return;
};

export const createNewToken: (userId: string) => Token = (userId) => {
  const newSignature = jwt.sign({ id: userId }, `${new Date().getTime()}`, {
    expiresIn: "10m",
  });
  const newToken: Token = {
    id: userId,
    value: newSignature,
    expires: new Date().getTime() + 10 * 60 * 1000,
  };
  tokens.push(newToken);
  const newVal = tokens.map((token) =>
    users.find((user) => user.id === token.id)
  );
  return newToken;
};

interface TokenHeader {
  token: string;
}
