import "./MyPage.css";
import { useNavigate } from "react-router-dom";

export default function MyPage() {
  const navigate = useNavigate();

  const user = {
    nickname: "닉네임최대열글자까지",
    email: "1234@gmail.com",
    avatarUrl: "/farmer.svg",
    version: "v 1.0.0",
  };

  const accountItems = [
    { label: "회원정보 확인", onClick: () => navigate("/account") }, 
    { label: "알림 설정", onClick: () => alert("알림 설정") },
  ];

  const etcItems = [
    { label: "공지사항", onClick: () => alert("공지사항") },
    { label: "앱 버전", rightText: user.version, disabled: true },
    { label: "앱 리뷰 남기기", onClick: () => alert("리뷰") },
  ];

  return (
    <div className="mypage">
      

      <main className="mypage__content">
        <section className="profile">
          <img className="profile__avatar" src={user.avatarUrl} alt="profile" />
          <div className="profile__name">{user.nickname}</div>
          <div className="profile__email">{user.email}</div>
        </section>

        <section className="section">
          <div className="section__title">환경설정</div>
          <div className="section__list">
            {accountItems.map((item) => (
              <button
                key={item.label}
                className="item"
                onClick={item.onClick}
                type="button"
              >
                <span className="item__label">{item.label}</span>
                <span className="item__chev"></span>
              </button>
            ))}
          </div>
        </section>

        <section className="section">
          <div className="section__title">기타</div>
          <div className="section__list">
            {etcItems.map((item) => (
              <button
                key={item.label}
                className={`item ${item.disabled ? "is-disabled" : ""}`}
                onClick={item.disabled ? undefined : item.onClick}
                type="button"
              >
                <span className="item__label">{item.label}</span>
                <span className="item__right">
                  {item.rightText ? (
                    <span className="item__rightText">{item.rightText}</span>
                  ) : (
                    <span className="item__chev"></span>
                  )}
                </span>
              </button>
            ))}
          </div>
        </section>

        <button className="logout" type="button" onClick={() => alert("로그아웃")}>
          로그아웃
        </button>
      </main>
    </div>
  );
}
