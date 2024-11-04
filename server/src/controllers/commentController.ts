import { NextFunction, Request, Response } from "express";
import {
  addComment,
  comments,
  CommentTemplate,
  CompletedComment,
} from "../models/comment";

const getCommentsByPostId: (
  req: Request<PostIdParams>,
  res: Response<CompletedComment[]>,
  next: NextFunction
) => void = (req, res, _next) => {
  const postComments = comments.filter(
    (comment) => comment.postId === req.params.postId
  );
  res.status(200).json(postComments);
};

const createComment: (
  req: Request<PostIdParams, any, CommentTemplate>,
  res: Response<CompletedComment>,
  next: NextFunction
) => void = (req, res, _next) => {
  const { postId } = req.params;
  const { content, author } = req.body;
  const comment = addComment({ postId, content, author });
  res.status(201).json(comment);
};

export { createComment, getCommentsByPostId };

interface PostIdParams {
  postId: string;
}
