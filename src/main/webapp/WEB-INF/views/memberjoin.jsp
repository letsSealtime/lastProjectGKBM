<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	/* 배경색 설정 */
	background-color: #f4f4f4;
	/* 패딩 추가 */
	padding: 20px;
}

#mainbox {
	/* 배경색 설정 */
	background-color: #ffffff;
	/* 모서리 둥글게 */
	border-radius: 10px;
	/* 그림자 효과 */
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	/* 내부 여백 추가 */
	padding: 20px;
	/* 최대 너비 설정 */
	max-width: 400px;
	/* 중앙 정렬 */
	margin: 150px auto;
	/* 텍스트 중앙 정렬 */
	text-align: center;
}

/* ---------- 로고 css ---------- */
#logo {
	/* border: 1px solid black; */
	/* 이미지 박스의 너비 */
	width: 100px;
	/* 이미지 박스의 높이 */
	height: 80px;
	/* 이미지박스에 flex 부여 */
	display: flex;
	/* 이미지 위아래 중앙정렬 */
	align-items: center;
	/* 이미지를 중앙정렬 */
	justify-content: center;
	/* 이미지의 박스를 중앙 정렬 */
	margin: 0 auto;
}

#logo img {
	/* 이미지의 너비크기 */
	width: 150%;
}

/* ---------- id와 pw css ---------- */
#id, #pw, #name, #email, #phone, #grade {
	/* 너비 조정 */
	width: calc(100% - 20px);
	/* 내부 여백 추가 */
	padding: 10px;
	/* 경계선 색상 */
	border: 1px solid #ccc;
	/* 모서리 둥글게 */
	border-radius: 5px;
	/* 여백 추가 */
	margin-top: 10px;
}

/* ---------- 아이디찾기와 비번찾기, 회원가입 css ---------- */
.find_id, .find_pw, .create_id {
	/* 위쪽여백 추가 */
	margin-top: 20px;
	/* 버튼 너비 30% */
	width: 30%;
	/* 배경색을 초록으로 변경 */
	background-color: #4a90e2;
	/* 텍스트 색상 */
	color: white;
	/* 내부여백 추가 */
	padding: 5px;
	/* 버튼의 border 제거 */
	border: none;
	/* 모서리 둥글게 */
	border-radius: 10px;
	/* 폰트 크기 조정 */
	font-size: 15px;
	/* 커서 포인터로 변경 */
	cursor: pointer;
	/* 배경색과 변형 효과 */
	transition: background-color 0.3s, transform 0.2s;
}

.find_id:hover, .find_pw:hover, .create_id:hover {
	/* 호버 시 배경색 변경 */
	background-color: #2f6baf;
	/* 호버 시 약간 확대 */
	transform: scale(1.07);
}

/* ---------- 로그인 css ---------- */
.login {
	/* 위쪽여백 추가 */
	margin-top: 20px;
	/* 버튼 너비 100% */
	width: 100%;
	/* 로그인 버튼 배경색을 초록색으로 변경 */
	background-color: #4a90e2;
	/* 텍스트 색상 */
	color: white;
	/* 내부 여백 추가 */
	padding: 12px;
	/* 버튼의 border 제거 */
	border: none;
	/* 모서리 둥글게 */
	border-radius: 10px;
	/* 폰트 크기 조정 */
	font-size: 16px;
	/* 커서 포인터로 변경 */
	cursor: pointer;
	/* 배경색과 변형 효과 */
	transition: background-color 0.3s, transform 0.2s;
}

.login:hover {
	/* 호버 시 배경색 변경 */
	background-color: #2f6baf;
	/* 호버 시 약간 확대 */
	transform: scale(1.05);
}
</style>
</head>
<body>
	<div id="mainbox">
		<div id="logo">
			<img
				src="${pageContext.request.contextPath}/resources/img/GKBM_logo.png"
				alt="GKBM MES SYSTEM">
		</div>

		<form action="memberjoin" method="post">
			<input type="text" id="id" name="id" placeholder="아이디"> <input
				type="password" id="pw" name="pw" placeholder="비밀번호"> <input
				type="text" id="name" name="name" placeholder="이름"> <input
				type="text" id="email" name="email" placeholder="이메일"> <input
				type="text" id="phone" name="phone" placeholder="휴대폰 번호"> <input
				type="number" id="grade" name="grade" value="2" placeholder="등급"
				readonly="readonly"> <input type="submit" class="login"
				value="회원가입">

			<c:if test="${not empty error}">
				<p style="color: red;">${error}</p>
			</c:if>

		</form>
	</div>
</body>
</html>