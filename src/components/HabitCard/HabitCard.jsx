import "./HabitCard.css";
import HabitCardExpanded from "./HabitCardExpanded";
import HabitCardCollapsed from "./HabitCardCollapsed";

export default function HabitCard({ isOpen, onClick, data }) {
    return (
        <div className={`habit-card card-${data.id}`} onClick={onClick}>
            {isOpen ? (
                <HabitCardExpanded data={data} />
            ) : (
                <HabitCardCollapsed data={data} />
            )}
        </div>
    )
}