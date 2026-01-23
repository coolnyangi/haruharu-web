import { useState } from 'react';
import "./Home.css";
import HabitCard from '../components/HabitCard/HabitCard.jsx';

export default function Home() {
    const [openIndex, setOpenIndex] = useState(null);

    const data = [
        { id: 0, title: "매일 영어공부 10분" },
        { id: 1, title: "매일 수학공부 10분" },
        { id: 2, title: "매일 국어공부 10분" },
    ];
    return (
        <>
          {data.map((item, index) => (
            <HabitCard
              key={index}
              isOpen={openIndex === index}
              onClick={() =>
                setOpenIndex(openIndex === index ? null : index)
              }
              data={item}
            />
          ))}
          <button className='habit-button'>
            <img className="button-icon" src="./src/assets/HabitCard/plus.png" />
          </button>
        </>
      );
}