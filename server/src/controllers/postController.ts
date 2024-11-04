import { NextFunction, Request, Response } from "express";
import {
  addPost,
  CompletedPost,
  posts,
  PostTemplate,
  updatePost,
} from "../models/post";
import { tokens } from "../models/tokens";
import { users } from "../models/user";
import { IdRequest, ResponseMessage } from "../types/types";

const getPosts: (
  req: Request<undefined>,
  res: Response<CompletedPost[]>,
  next: NextFunction
) => void = (req, res, _next) => {
  res.status(200).json(posts);
};

const getPostById: (
  req: Request<IdRequest>,
  res: Response<CompletedPost | ResponseMessage>,
  next: NextFunction
) => void = (req, res, _next) => {
  const post = posts.find((post) => post.id === req.params.id);
  if (post) return res.status(200).json(post);
  return res.status(404).json({ message: "Post not found" });
};

const createPost: (
  req: Request<any, any, PostTemplate>,
  res: Response<CompletedPost>,
  next: NextFunction
) => void = (req, res, _next) => {
  const { title, content, author } = req.body;
  const post = addPost({ title, content, author });
  res.status(201).json(post);
};

const editPost: (
  req: Request<IdRequest, any, PostTemplate>,
  res: Response<CompletedPost | ResponseMessage>,
  next: NextFunction
) => void = (req, res, _next) => {
  const userToken = req.header("Authorization")?.replace("Bearer ", "");
  const userId = tokens.find((token) => userToken === token.value)?.id;
  const ReqUserEmail = users.find((user) => user.id === userId)?.email;
  const postUserEmail = posts.find((post) => post.id === req.params.id)?.author;
  if (ReqUserEmail !== postUserEmail)
    return res
      .status(401)
      .json({ message: "Not authorized to edit this post" });
  const updatedPost = updatePost(req.params.id, req.body);
  if (updatedPost) return res.status(200).json(updatedPost);
  return res.status(404).json({ message: "Post not found" });
};

const deletePost: (
  req: Request<IdRequest>,
  res: Response<ResponseMessage>,
  next: NextFunction
) => void = (req, res, _next) => {
  const index = posts.findIndex((post) => post.id === req.params.id);
  if (index === -1) return res.status(404).json({ message: "Post not found" });
  const userToken = req.header("Authorization")?.replace("Bearer ", "");
  const userId = tokens.find((token) => userToken === token.value)?.id;
  const reqUser = users.find((user) => user.id === userId);
  const reqUserEmail = reqUser?.email;
  const postUserEmail = posts.find((post) => post.id === req.params.id)?.author;
  if (reqUserEmail !== postUserEmail && reqUser?.role !== "admin") {
    return res
      .status(401)
      .json({ message: "Not authorized to delete this post" });
  }
  posts.splice(index, 1);
  return res.status(200).json({ message: "Post deleted successfully" });
};

export { createPost, deletePost, editPost, getPostById, getPosts };
