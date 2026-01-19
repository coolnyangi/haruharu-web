import { NavLink, useLocation, useNavigate } from "react-router-dom";
import "./BottomNav.css";
import { use } from "react";

export default function BottomNav() {
    const navigate = useNavigate();
    const location = useLocation();

    const navItems = [
        {label: '홈', path: '/'},
        {label: '로그인', path: '/login'},
    ];

    return (
        <nav className="bottom-nav">
            {navItems.map((item) => {
                const isActive = location.pathname === item.path;

                return (
                    <div
                        key={item.path}
                        className={`nav-item ${isActive ? 'active' : ''}`}
                        onClick={() => navigate(item.path)}
                    >
                        <span className="nav-link">{item.label}</span>
                    </div>
                );
            })}
        </nav>
    );
}