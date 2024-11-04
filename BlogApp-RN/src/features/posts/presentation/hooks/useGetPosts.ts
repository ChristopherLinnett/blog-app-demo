import { useServices } from "@/src/core/dependency_injection/dep_injection";
import { AuthException } from "@/src/core/errors/exceptions";
import { useQuery } from "@tanstack/react-query";
import { isRight } from "fp-ts/lib/Either";
import { CompletedPost } from "../../data/models/completedPost";

const useGetPosts = () => {
  const { getPosts } = useServices();

  return useQuery<CompletedPost[], AuthException>({
    queryKey: ["posts"],
    queryFn: () =>
      getPosts().then((response) => {
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

export default useGetPosts;
