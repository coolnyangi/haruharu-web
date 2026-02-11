import { useState } from 'react';
import "./Home.css";
import HabitCard from '../components/HabitCard/HabitCard.jsx';
import 'pretendard/dist/web/static/pretendard.css';

export default function Home() {
    const [openIndex, setOpenIndex] = useState(null);

    const data = [
        { id: 0, title: "매일 영어공부 10분" },
        { id: 1, title: "매일 수학공부 10분" },
        { id: 2, title: "매일 국어공부 10분" },
    ];
    return (
        <>
          <div className='home-header'>
            <div className="home-title">📙 21일 동안 서비스이름과 함께<br />좋은 습관을 만들어봐요!</div>
            <div className='home-sub-title'>서비스의 정체성을 드러낼 수 있는 상단<br />근데 좋은 디자인, 멘트가 안 떠오른다!</div>
          </div>
          <div className='habit-card-container'>
            {data.length === 0 ? (
              <div className='no-habit-message'>
                아직 추가된 습관이 없어요!<br />
                아래 플러스 버튼을 눌러 습관을 추가해보세요!
              </div>
            ) : (
              data.map((item, index) => (
                <HabitCard
                  key={index}
                  isOpen={openIndex === index}
                  onClick={() =>
                    setOpenIndex(openIndex === index ? null : index)
                  }
                  data={item}
                />
              ))
            )}
          </div>
          <button className='habit-button'>
            <img className="button-icon" src="./src/assets/HabitCard/plus.png" />
          </button>
        </>
      );
}