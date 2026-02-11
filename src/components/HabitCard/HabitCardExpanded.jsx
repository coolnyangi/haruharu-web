import "./HabitCard.css"

export default function HabitCardExpanded({ data }) {
    return (
        <div className="habit-card-expanded">
            <div className="habit-header-expanded">
                <div className="habit-info">
                    <div className="habit-flower">🌷 사용자설정꽃</div>
                    <div className="habit-title">{data.title}</div>
                </div>
                <div className="habit-percent">80%</div>    
            </div>
            <img className="character" src="./src/assets/HabitCard/character.png"/>
        </div>
    );
}