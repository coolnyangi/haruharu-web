import "./HabitCard.css";

export default function HabitCardCollapsed({ data }) {
    return (
        <div className="habit-card-collapsed">
            <div className="habit-title">{data.title}</div>
        </div>
    );
}