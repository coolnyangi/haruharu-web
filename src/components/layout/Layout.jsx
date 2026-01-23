import { Outlet } from "react-router-dom";
import BottomNav from "./BottomNav";
import Header from "./Header";
import "./Layout.css";
import "./BottomNav.css";
import "./Header.css";

export default function Layout() {
    return (
        <div className="layout">
            <Header />
            <main className="content">
                <Outlet />
            </main>
            <BottomNav />
        </div>
    );
}