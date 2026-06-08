import { Navigate, Outlet } from "react-router";
import { useAuth } from "../context/AuthContext";
import { BottomNav } from "./BottomNav";

export function ProtectedLayout() {
  const { user } = useAuth();

  if (!user) return <Navigate to="/login" replace />;

  return (
    <div className="min-h-screen bg-gray-900">
      <div className="pb-28">
        <Outlet />
      </div>
      <BottomNav />
    </div>
  );
}
