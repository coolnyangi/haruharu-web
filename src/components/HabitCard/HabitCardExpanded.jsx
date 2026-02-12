import "./HabitCard.css"

export default function HabitCardExpanded({ data }) {
    return (
        <div className="habit-card-expanded">
            <div className="habit-header-expanded">
                <div className="habit-header-title">
                    <div className="habit-info">
                        <div className="habit-flower">🌷 사용자설정꽃</div>
                        <div className="habit-title">{data.title}</div>
                    </div>
                    <div className="habit-percent">80%</div>  
                </div>
                <div className="habit-header-progress">
                    <div className="habit-progress-bar">
                        <div className={`habit-progress-fill fill-${data.id}`} style={{ width: "80%" }}></div>
                    </div>
                    <div className="habit-sub-info">
                        <div className="start-date">시작일 0000.00.00</div>
                        <div className="delete">삭제</div>
                    </div>
                </div>
            </div>
            <img className="character" src="./src/assets/HabitCard/character.png"/>
        </div>
    );
}