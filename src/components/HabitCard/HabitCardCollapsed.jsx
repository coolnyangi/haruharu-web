import "./HabitCard.css";

export default function HabitCardCollapsed({ data }) {
    return (
        <div className="habit-card-collapsed">
            <div className="habit-info">
                <div className="habit-flower">🌷 사용자설정꽃</div>
                <div className="habit-title">{data.title}</div>
            </div>
            <div className="habit-percent">80%</div>
        </div>
    );
}