import AuthPage from "@/src/features/authentication/presentation/pages/AuthPage";
import { AuthStateConsumer } from "@/src/features/authentication/presentation/state/AuthStateConsumer";
import PostDetailsPage from "@/src/features/posts/presentation/pages/PostDetailPage";
import PostListPage from "@/src/features/posts/presentation/pages/PostListPage";
import { NavigationContainer, ParamListBase } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import React from "react";

const Stack = createNativeStackNavigator<RootStackParamList>();

export interface RootStackParamList extends ParamListBase {
  PostList: undefined;
  PostDetails: { postId: string };
}

const authenticatedScreens = () => (
  <>
    <Stack.Screen
      name="PostList"
      component={PostListPage}
      options={{ title: "All Posts" }}
    />
    <Stack.Screen
      name="PostDetails"
      component={PostDetailsPage}
      options={{ title: "Comments" }}
    />
  </>
);

const unauthenticatedScreens = () => (
  <Stack.Screen
    name="Authentication"
    component={AuthPage}
    options={{ headerShown: false }}
  />
);

export default function AppNavigator() {
  const queryClient = new QueryClient();
  return (
    <QueryClientProvider client={queryClient}>
      <AuthStateConsumer listenTo={"signedIn"}>
        {({ signedIn }) => (
          <NavigationContainer>
            <Stack.Navigator>
              {signedIn ? authenticatedScreens() : unauthenticatedScreens()}
            </Stack.Navigator>
          </NavigationContainer>
        )}
      </AuthStateConsumer>
    </QueryClientProvider>
  );
}
