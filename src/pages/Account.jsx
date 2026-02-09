import { useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import "./Account.css";

export default function Account() {
  const navigate = useNavigate();

  // 데모용 사용자 데이터(나중에 전역상태/서버에서 가져오면 됨)
  const user = useMemo(
    () => ({
      email: "1234@gmail.com",
      nickname: "닉네임최대열글자까지",
    }),
    []
  );

  // 닉네임 변경
  const [nickname, setNickname] = useState(user.nickname);

  // 비밀번호 변경
  const [currentPw, setCurrentPw] = useState("");
  const [newPw, setNewPw] = useState("");
  const [newPw2, setNewPw2] = useState("");

  const [nickMsg, setNickMsg] = useState("");
  const [pwMsg, setPwMsg] = useState("");

  function handleChangeNickname() {
    const trimmed = nickname.trim();

    if (trimmed.length < 2 || trimmed.length > 10) {
      setNickMsg("닉네임은 2~10자로 입력해주세요.");
      return;
    }
    setNickMsg("");

    // TODO: API 붙일 자리
    alert(`닉네임이 "${trimmed}"로 변경되었습니다.`);
  }

  function handleChangePassword() {
    if (currentPw.length < 4) {
      setPwMsg("현재 비밀번호를 입력해주세요.");
      return;
    }
    if (newPw.length < 6) {
      setPwMsg("새 비밀번호는 6자 이상으로 입력해주세요.");
      return;
    }
    if (newPw !== newPw2) {
      setPwMsg("새 비밀번호가 서로 일치하지 않습니다.");
      return;
    }
    setPwMsg("");

    // TODO: API 붙일 자리
    alert("비밀번호가 변경되었습니다.");
    setCurrentPw("");
    setNewPw("");
    setNewPw2("");
  }

  return (
    <div className="account">
      <header className="account__header">
        <button className="account__back" type="button" onClick={() => navigate(-1)}>
          ←
        </button>
        <div className="account__title">회원정보 확인</div>
        <div className="account__spacer" />
      </header>

      <main className="account__content">
        {/* 이메일(읽기 전용) */}
        <section className="block">
          <div className="block__label">이메일</div>
          <div className="readonly">
            <span className="readonly__text">{user.email}</span>
          </div>
        </section>

        {/* 닉네임 변경 */}
        <section className="block">
          <div className="block__label">닉네임 변경</div>
          <div className="row">
            <input
              className="input"
              value={nickname}
              onChange={(e) => setNickname(e.target.value)}
              placeholder="닉네임(2~10자)"
            />
            <button className="btn" type="button" onClick={handleChangeNickname}>
              변경하기
            </button>
          </div>
          {nickMsg ? <div className="msg">{nickMsg}</div> : null}
        </section>

        {/* 비밀번호 변경 */}
        <section className="block">
          <div className="block__label">비밀번호</div>

          <input
            className="input input--full"
            type="password"
            value={currentPw}
            onChange={(e) => setCurrentPw(e.target.value)}
            placeholder="현재 비밀번호"
          />

          <div className="space" />

          <input
            className="input input--full"
            type="password"
            value={newPw}
            onChange={(e) => setNewPw(e.target.value)}
            placeholder="새 비밀번호 (6자 이상)"
          />

          <div className="space" />

          <input
            className="input input--full"
            type="password"
            value={newPw2}
            onChange={(e) => setNewPw2(e.target.value)}
            placeholder="새 비밀번호 확인"
          />

          {pwMsg ? <div className="msg">{pwMsg}</div> : null}

          <button className="btn btn--full" type="button" onClick={handleChangePassword}>
            비밀번호 변경하기
          </button>
        </section>
      </main>
    </div>
  );
}
