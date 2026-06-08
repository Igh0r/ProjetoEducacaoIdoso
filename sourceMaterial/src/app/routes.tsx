import { createBrowserRouter } from "react-router";
import { Login } from "./components/Login";
import { ProtectedLayout } from "./components/ProtectedLayout";
import { Home } from "./components/Home";
import { CategoryLessons } from "./components/CategoryLessons";
import { Lesson } from "./components/Lesson";
import { Progress } from "./components/ProgressPage";
import { AppLauncher } from "./components/AppLauncher";
import { ProfilePage } from "./components/ProfilePage";
import { AISearch } from "./components/AISearch";

export const router = createBrowserRouter([
  {
    path: "/login",
    Component: Login,
  },
  {
    Component: ProtectedLayout,
    children: [
      { path: "/", Component: Home },
      { path: "/category/:categoryId", Component: CategoryLessons },
      { path: "/lesson/:lessonId", Component: Lesson },
      { path: "/progress", Component: Progress },
      { path: "/apps", Component: AppLauncher },
      { path: "/profile", Component: ProfilePage },
      { path: "/search", Component: AISearch },
    ],
  },
]);
