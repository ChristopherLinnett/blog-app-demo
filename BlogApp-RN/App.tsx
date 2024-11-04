import AppNavigator from "./src/core/app/AppRouter";
import { DIProvider } from "./src/core/dependency_injection/dep_injection";
import { AuthStateProvider } from "./src/features/authentication/presentation/state/authStateNotifier";

export default function App() {
  return (
    <AuthStateProvider>
      <DIProvider>
        <AppNavigator />
      </DIProvider>
    </AuthStateProvider>
  );
}
