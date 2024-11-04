import { Router } from "express";
import {
  createComment,
  getCommentsByPostId,
} from "../controllers/commentController";

const router = Router();

router.get("/:postId", getCommentsByPostId);
router.post("/:postId", createComment);

export { router as commentRoutes };
