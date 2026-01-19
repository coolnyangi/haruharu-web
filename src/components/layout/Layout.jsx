import { Outlet } from "react-router-dom";
import BottomNav from "./BottomNav";
import "./BottomNav.css";

export default function Layout() {
    return (
        <div className="layout">
            <main className="content">
                <Outlet />
            </main>
            <BottomNav />
        </div>
    );
}