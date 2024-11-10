import bodyParser from "body-parser";
import cors from "cors";
import express, { NextFunction, Request, Response } from "express";
import { checkToken } from "./controllers/authTokenController";
import { authRoutes } from "./routes/authRoutes";
import { commentRoutes } from "./routes/commentRoutes";
import { postRoutes } from "./routes/postRoutes";

const PORT = 3001;

const app = express();
app.use(cors());
app.use(bodyParser.json());
function delayResponse(ms: number) {
  return (req: Request, res: Response, next: NextFunction) => {
    setTimeout(() => next(), ms);
  };
}
app.use(delayResponse(2000));
app.use("/api/auth", authRoutes);
app.use(checkToken);

app.use("/api/posts", postRoutes);
app.use("/api/comments", commentRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

export default app;
