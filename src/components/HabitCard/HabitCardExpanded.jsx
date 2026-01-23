import "./HabitCard.css"

export default function HabitCardExpanded({ data }) {
    return (
        <div className="habit-card-expanded">
            <div className="habit-header-expanded">
                <div className="habit-title-expanded">{data.title}</div>
                <div className="habit-progress">80%</div>
            </div>
            <img className="character" src="./src/assets/HabitCard/character.png"/>
        </div>
    );
}