import { useState } from "react";
import "./HabitCard.css"
import water from "../../assets/HabitCard/water.png";
import sun from "../../assets/HabitCard/sun.png";
import cloud from "../../assets/HabitCard/cloud.png";

export default function HabitCardExpanded({ data }) {
    const [completedCount, setCompletedCount] = useState(0);

    const handleClick = (index) => {
    setCompletedCount(index + 1);
    };

    const progress = Math.round((completedCount / 21) * 100);

    const iconMap = { water, sun, cloud };

    return (
        <div className="habit-card-expanded">
            <div className="habit-header-expanded">
                <div className="habit-header-title">
                    <div className="habit-info">
                        <div className="habit-flower">🌷 사용자설정꽃</div>
                        <div className="habit-title">{data.title}</div>
                    </div>
                    <div className="habit-percent">{progress}%</div>  
                </div>
                <div className="habit-header-progress">
                    <div className="habit-progress-bar">
                        <div className={`habit-progress-fill fill-${data.id}`} style={{ width: `${progress}%` }}></div>
                    </div>
                    <div className="habit-sub-info">
                        <div className="start-date">시작일 0000.00.00</div>
                        <div className="delete">삭제</div>
                    </div>
                </div>
            </div>
            <img className="character" src="./src/assets/HabitCard/character.png"/>
            <div className="habit-grid">
                {Array.from({ length: 21 }).map((_, index) => (
                <button
                    key={index}
                    onClick={(e) => {
                        e.stopPropagation();
                        handleClick(index);
                      }}
                    style={{ opacity: index < completedCount ? 1 : 0.4 }}
                    className="habit-item"
                >
                    <img src={iconMap[data.iconType]} />
                </button>
                ))}
            </div>
        </div>
    );
}

