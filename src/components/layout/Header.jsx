import { NavLink, useLocation, useNavigate } from "react-router-dom";
import "./Header.css";
import { use } from "react";

export default function Header() {
    const navigate = useNavigate();

    return (
        <div className="header">
            <img className="header-title" src="./src/assets/Header/NAME.png" onClick={() => navigate('/')} />
            <img className="notification" src="./src/assets/Header/Bell.png"/>
        </div>
    );
}