import { NavLink, useLocation, useNavigate } from "react-router-dom";
import "./BottomNav.css";
import { use } from "react";

export default function BottomNav() {
    const navigate = useNavigate();
    const location = useLocation();

    const navItems = [
        {label: '홈', path: '/', image: './src/assets/BottomNav/Home_fill.png' },
        {label: '컬렉션', path: '/collection', image: './src/assets/BottomNav/Star.png'},
        {label: '마이페이지', path: '/mypage', image: './src/assets/BottomNav/User_alt.png'},
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
                        <img className="nav-icon" src={item.image} />
                        <span className="nav-link">{item.label}</span>
                    </div>
                );
            })}
        </nav>
    );
}