import { Router } from "express";
import {
  createPost,
  deletePost,
  editPost,
  getPostById,
  getPosts,
} from "../controllers/postController";

const router = Router();

router.get("/", getPosts);
router.get("/:id", getPostById);
router.post("/", createPost);
router.put("/:id", editPost);
router.delete("/:id", deletePost);

export { router as postRoutes };
