import { useServices } from "@/src/core/dependency_injection/dep_injection";
import { AuthException } from "@/src/core/errors/exceptions";
import { useQuery } from "@tanstack/react-query";
import { isRight } from "fp-ts/lib/Either";
import { PostDetails } from "../../data/models/postDetails";
import { CompletedComment } from "../../data/models/completedComment";

const useGetComments = (postId: string) => {
  const { getComments } = useServices();

  return useQuery<CompletedComment[], AuthException>({
    queryKey: ["comments", postId],
    queryFn: () =>
      getComments(postId).then((response) => {
        if (isRight(response)) {
          return response.right;
        }
        throw new AuthException(
          response.left.message,
          response.left.statusCode
        );
      }),
  });
};

export default useGetComments;
