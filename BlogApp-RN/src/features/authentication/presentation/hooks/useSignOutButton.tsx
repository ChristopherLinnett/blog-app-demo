import { useAuthState } from "@/src/features/authentication/presentation/state/authStateProvider";
import { useNavigation } from "@react-navigation/native";
import { useQueryClient } from "@tanstack/react-query";
import { useLayoutEffect } from "react";
import { Button } from "react-native";

export const useSignoutButton = () => {
  const navigation = useNavigation();
  const queryClient = useQueryClient();
  const clearUser = useAuthState().notifier.clearUser;
  const signOut = () => {
    clearUser();
    queryClient.clear();
  };
  useLayoutEffect(() => {
    navigation.setOptions({
      headerRight: () => <Button title="Sign Out" onPress={signOut} />,
    });
  }, []);
};
