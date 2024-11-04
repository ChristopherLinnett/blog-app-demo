import { useServices } from "@/src/core/dependency_injection/dep_injection";
import { AuthException } from "@/src/core/errors/exceptions";
import { useAuthSelector } from "@/src/features/authentication/presentation/state/authStateNotifier";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { isRight } from "fp-ts/lib/Either";
import { PostTemplate } from "../../data/models/postTemplate";

export const useAddPost = (sideEffect: () => void) => {
  const queryClient = useQueryClient();
  const { addPost } = useServices();
  const email = useAuthSelector((state) => state.email);

  return useMutation({
    mutationFn: async (newPost: { title: string; content: string }) => {
      const response = await addPost({ ...newPost, author: email });
      if (isRight(response)) {
        return response.right;
      }
      throw new AuthException(response.left.message, response.left.statusCode);
    },
    onMutate: async (newPost) => {
      await queryClient.cancelQueries({ queryKey: ["posts"] });

      const previousPosts = queryClient.getQueryData<PostTemplate[]>(["posts"]);
      if (sideEffect) {
        sideEffect();
      }
      const optimisticPost = {
        id: "temp" + Date.now().toString(),
        title: newPost.title,
        content: newPost.content,
        author: email,
      };
      queryClient.setQueryData<PostTemplate[]>(["posts"], (oldPosts) =>
        oldPosts ? [...oldPosts, optimisticPost] : [optimisticPost]
      );

      return { previousPosts };
    },
    onError: (error, newPost, context) => {
      if (context?.previousPosts) {
        queryClient.setQueryData(["posts"], context.previousPosts);
      }
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ["posts"] });
    },
    onSuccess: () => {},
  }).mutate;
};
