<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>GKBM MES SYSTEM</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
}

#container {
	width: 100%;
	/* padding: 20px; */
}

#top_section {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
	border: 1px solid #ddd;
	padding: 10px;
	background-color: white;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

#logo {
	width: 100px;
	height: 80px;
	background-color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 4px;
	margin-left: 20px;
}

#logo img {
	width: 150%;
	height: 150%;
	object-fit: contain;
}

#logo img:hover {
	cursor: pointer;
}

.mm {
	width: 20px;
}

#main_menu {
	display: flex;
	gap: 10px;
}

.menu_item {
	padding: 15px 25px;
	cursor: pointer;
	border: 1px solid #ddd;
	background-color: white;
	transition: all 0.3s ease;
	border-radius: 4px;
}

.menu_item:hover {
	background-color: #f0f0f0;
}

.menu_item.active {
	background-color: #4a90e2;
	color: white;
	border-color: #4a90e2;
}

#content_section {
	display: flex;
	min-height: calc(100vh - 140px);
	position: relative;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

#sub_menu {
	width: 0;
	border: 1px solid #ddd;
	background-color: white;
	overflow: hidden;
	white-space: nowrap;
	transition: all 0.3s ease-in-out;
	border-radius: 4px;
	opacity: 0;
}

#sub_menu.visible {
	opacity: 1;
	width: 200px;
}

.sub_item {
	padding: 15px;
	border-bottom: 1px solid #ddd;
	cursor: pointer;
	transition: opacity 0.3s ease, transform 0.3s ease;
}

.sub_item:hover {
	background-color: #f0f0f0;
}

.sub_item.active {
	background-color: #4a90e2;
	color: white;
}

#main_content {
	flex: 1;
	border: 1px solid #ddd;
	background-color: white;
	border-radius: 4px;
	display: flex;
	flex-direction: column;
	min-height: 600px;
	overflow: hidden;
}

.graph_container {
	flex: 1;
	padding: 20px;
	height: 100%;
}

.graph_section {
	width: 100%;
	height: 100%;
	position: relative;
	/* background-color: #f9f9f9; */
}

#content-frame {
	width: 100%;
	height: 100%;
	border: none;
	position: absolute;
	top: 0;
	left: 0;
}

#side_panel {
	width: 200px;
	display: flex;
	flex-direction: column;
	gap: 20px;
}

#notice, #employee_board {
	border: 1px solid #ddd;
	height: calc(50% - 10px);
	background-color: white;
	border-radius: 4px;
}

h3 {
	padding: 15px;
	background-color: #4a90e2;
	color: white;
	font-size: 1em;
	border-top-left-radius: 4px;
	border-top-right-radius: 4px;
}

.panel_content {
	padding: 15px;
	height: calc(100% - 50px);
	overflow-y: auto;
}

.detail-menu {
	padding-left: 20px;
	border-left: 2px solid #4a90e2;
	margin-left: 10px;
}

.detail-item {
	padding: 10px 15px;
	cursor: pointer;
	background-color: #f8f9fa;
	transition: background-color 0.2s;
}

.detail-item:hover {
	background-color: #e9ecef;
}

.detail-item.active {
	background-color: #4a90e2;
	color: white;
}

#top_section {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 10px 20px;
	background-color: white;
}

#user_section {
	position: relative;
	display: flex;
	align-items: center;
	gap: 10px;
}

#user_section img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	cursor: pointer;
}

#user_section span {
	font-size: 16px;
	color: #333;
	font-weight: bold;
	margin-left: 10px;
}

/* 사용자 클릭시 뜨는 팝업 */
.user_popup {
	position: absolute;
	top: 50px;
	right: 0;
	width: 200px;
	background-color: white;
	border: 1px solid #ddd;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	display: none;
	z-index: 100;
}

.user_popup ul {
	list-style-type: none;
}

.user_popup li {
	padding: 10px;
	cursor: pointer;
}

.user_popup li:hover {
	background-color: #f0f0f0;
}

.chatbot {
	position: fixed;
	right: 10px;
	bottom: 20px;
	border-radius: 100%;
	border: 1px solid black;
	width: 60px;
	height: 60px;
	background-image: url('${pageContext.request.contextPath}/resources/img/chatbot.png');
	background-repeat: no-repeat;
	background-size: contain;
	cursor: pointer;
}

.user_container {
	/* 너비 조정 */
	width: 500px;
	height: 500px;
	margin: 0 auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	display: none;
	/* 경계선 색상 조정 */
	border: 1px solid #000;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 1000;
}

.header {
	align-items: center;
	margin-bottom: 20px;
}

.close-btn {
	/* 닫기 버튼 색상 */
	background-color: #e74c3c;
	color: white;
	border: none;
	border-radius: 4px;
	padding: 5px 10px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
	float: right;
}

.close-btn:hover {
	/* 닫기 버튼 호버 색상 */
	background-color: #c0392b;
}

.user_info {
	margin-bottom: 15px;
	display: flex;
	/* Flexbox 사용 */
	justify-content: space-between;
	/* 양쪽 정렬 */
}

.user_info label {
	font-weight: bold;
	color: #333;
	/* 텍스트 색상 */
}

.user_info span {
	color: #666;
	/* 텍스트 색상 */
}

/* ------------------------------------챗봇 css칸------------------------------------ */
.gemini-popup {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 1000; width : 90%;
	max-width: 550px;
	height: 90%;
	max-height: 700px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.5);
	overflow: hidden;
	display: none;
	z-index: 1002;
	flex-direction: column;
	border: 1px solid black;
	width: 90%;
}

.gemini-popup .header {
	background-color: #4a90e2;
	color: #fff;
	padding: 15px;
	text-align: center;
	font-size: 1.2em;
	border-bottom: 1px solid #ddd;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.gemini-popup .header h1 {
	margin: 0;
	font-size: 1.2em;
	font-weight: bold;
}

.gemini-popup .chat-wrap {
	flex-grow: 1;
	overflow-y: auto;
	padding: 15px;
	display: flex;
	flex-direction: column;
}

.gemini-popup .chat-wrap::-webkit-scrollbar {
	width: 5px;
}

.gemini-popup .chat-wrap::-webkit-scrollbar-thumb {
	background: #888;
	border-radius: 4px;
}

.gemini-popup .chat-wrap::-webkit-scrollbar-track {
	background: #f1f1f1;
}

.gemini-popup .chat-message-wrap {
	margin-bottom: 10px;
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

/* 받는 글씨 */
.gemini-popup .chat-message {
	background-color: #e5e5ea;
	color: #333;
	padding: 8px 12px;
	border-radius: 10px;
	max-width: 80%;
	word-break: break-word;
	font-size: 0.9em;
}

.gemini-popup .chat-message-wrap.mine {
	align-items: flex-end;
}

/* 보낸 글씨 */
.gemini-popup .chat-message.mine {
	background-color: #DCF8C6;
}

.gemini-popup .chat-input {
	box-sizing: border-box;
	background-color: #f0f0f0;
	padding: 15px;
	display: flex;
	align-items: center;
	border-top: 1px solid #ddd;
}

.gemini-popup .chat-input textarea {
	flex-grow: 1;
	height: 40px;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 0.9em;
	resize: none;
}

.gemini-popup .chat-input #send {
	width: 80px;
	height: 40px;
	margin-left: 10px;
	background-color: #4a90e2;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 0.9em;
	transition: background-color 0.3s;
}

.gemini-popup .chat-input #send:hover {
	background-color: #2f6baf;
}

.gemini-close-btn {
	background-color: #e74c3c;
	color: white;
	border: none;
	border-radius: 4px;
	padding: 5px 8px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
}

.gemini-close-btn:hover {
	background-color: #c0392b;
}

.overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100vw;
	height: 100vh;
	background-color: rgba(0, 0, 0, 0.5); /* 투명한 배경 */
	backdrop-filter: blur(4px);
	z-index: 900; /* 팝업보다 낮은 z-index */
}

/* 팝업창 */
.info-popup {
	position: absolute;
	user-select: none;
	top: 40px;
	left: 20px;
	z-index: 800;
	width: 400px;
	height: 500px;
	border: 1px solid #ccc;
	background-color: #fff;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
	border-radius: 8px;
	background-image: url("${pageContext.request.contextPath}/resources/img/동포초등학교 교가.png");
	background-repeat: no-repeat;
	background-size: contain;
	text-align: center;
	font-size: 20px;
	user-select: none;
}

.info-popup .info-popup-header {
	height: calc(100% - 60px); /* 전체 높이에서 하단 영역(60px)을 제외 */
	padding: 20px;
	overflow-y: auto; /* 내용이 넘칠 경우 스크롤 */
}

.info-popup2 {
	height: 60px; /* 하단 영역 높이 */
	display: flex;
	justify-content: space-between; /* 체크박스와 닫기 버튼을 양쪽에 배치 */
	align-items: center;
	padding: 0 20px; /* 좌우 여백 */
	border-top: 1px solid #ddd; /* 상단 경계선 */
}

.info-popup2 .checkbox-container {
	display: flex;
	align-items: center;
}

.info-popup2 .checkbox-container input[type="checkbox"] {
	margin-right: 8px; /* 체크박스와 텍스트 간 여백 */
}

.info-popup2 .close-btn {
	background-color: #e74c3c;
	color: white;
	border: none;
	border-radius: 4px;
	padding: 5px 10px;
	cursor: pointer;
}

.info-popup2 .close-btn:hover {
	background-color: #c0392b;
}

/* ------------------------------------챗봇 css칸------------------------------------ */

/* ============================= */
/* 모바일 버전 (768px) */
/* ============================= */
@media screen and (max-width: 768px) {
	#container {
		padding: 10px;
	}
	#top_section {
		display: flex;
		flex-direction: column;
		/* 세로 정렬 */
		align-items: center;
		/* 가운데 정렬 */
		gap: 10px;
		/* 요소 간 간격 */
	}
	#logo {
		margin: 0 auto;
		width: 120px;
		/* 로고 크기 조정 */
		height: auto;
	}
	#logo img {
		max-width: 100%;
		height: auto;
	}
	#user_section {
		display: flex;
		align-items: center;
		/* 세로 중앙 정렬 */
		justify-content: center;
		/* 가운데 정렬 */
		gap: 10px;
		/* 텍스트와 아이콘 간 간격 */
	}
	#user_section span {
		font-size: 14px;
		/* 텍스트 크기 조정 */
	}
	#user_section img {
		width: 40px;
		/* 사용자 아이콘 크기 */
		height: 40px;
	}
	#main_menu {
		display: flex;
		flex-wrap: wrap;
		/* 메뉴를 여러 줄로 나열 */
		justify-content: center;
		/* 가운데 정렬 */
		gap: 10px;
		/* 메뉴 간 간격 */
		font-size: 16px;
	}
	.menu_item {
		flex: 0 1 calc(50% - 10px);
		/* 두 개씩 배치 */
		padding: 10px;
		text-align: center;
		font-size: 14px;
	}
	#content_section {
		flex-direction: column;
		min-height: calc(100vh - 200px);
	}
	#sub_menu.visible {
		width: 100%;
		margin-bottom: 10px;
	}
	#main_content {
		width: 100% !important;
		min-height: 400px;
	}
	.graph_container {
		padding: 10px;
	}
	#side_panel {
		width: 100%;
	}
	#notice, #employee_board {
		height: 200px;
	}
	#content-frame {
		position: relative;
		min-height: 400px;
	}
	nav {
		padding: 5px;
	}
	nav a {
		display: block;
		margin-bottom: 5px;
	}
	iframe {
		height: calc(100% - 150px);
	}
}

@media screen and (max-width: 1455px) {
	.menu_item {
		width: 100px;
		height: 50px;
		padding: 0px;

		font-size: 13px;
		text-align: center;
		line-height: 50px;
	}
	#user_section > span{
		font-size: 13px;
	}
	#logo {
		width: 70px;
	}
}
</style>
</head>
<body>
	<div id="container">
		<div id="top_section">
			<div id="logo">
				<img src="${pageContext.request.contextPath}/resources/img/GKBM_logo.png"" alt="GKBM MES SYSTEM" id="logo-image">
			</div>
			<div class="mm"></div>
			<div id="main_menu">
				<div class="menu_item" data-menu="1">기준정보</div>
				<div class="menu_item" data-menu="2">SCM</div>
				<div class="menu_item" data-menu="3">생산관리</div>
				<div class="menu_item" data-menu="4">재고관리</div>
				<div class="menu_item" data-menu="5">설비관리</div>
				<div class="menu_item" data-menu="6">소모품관리</div>
				<div class="menu_item" data-menu="7">품질관리</div>
				<div class="menu_item" data-menu="8">커뮤니티</div>
			</div>

			<!-- 사용자 세션 -->
			<div id="user_section">
				<span> [<c:choose>
						<c:when test="${user.grade == 1}">관리자</c:when>
						<c:otherwise>작업자</c:otherwise>
					</c:choose>] ${user.emp_name}님 환영합니다.
				</span> <img src="${pageContext.request.contextPath}/resources/img/usericon.png" alt="usericon" id="user_icon">

				<!-- 사용자 정보 팝업 -->
				<div class="user_popup" id="user_popup">
					<ul>
						<li class="user_inf">사용자 정보</li>
						<li id="logout_button">로그아웃</li>
					</ul>
				</div>
			</div>
		</div>
	</div>


	</div>
	<div id="content_section">
		<div id="sub_menu"></div>
		<div id="main_content">
			<div class="graph_container">
				<div class="graph_section">
					<!-- 경영리포팅 그래프가 들어갈 공간 -->
					<iframe id="content-frame" src="main_dashboard.jsp" width="100%"
						height="100%" frameborder="0"></iframe>
				</div>
			</div>
		</div>
	</div>
	</div>

	<div id="overlay" class="overlay" style="display: none;"></div>

	<div class="chatbot"></div>

	<div class="user_container">
		<div class="header">
			<button class="close-btn" onclick="closeUserInfo()">✖</button>
			<h1>사용자 정보</h1>
		</div>
		<div class="user_info">
			<label>사원번호</label> <span id="userEmp">${sessionScope.user.empNo}</span>
		</div>
		<div class="user_info">
			<label>이름:</label> <span id="userName">${sessionScope.user.emp_name}</span>
		</div>
		<div class="user_info">
			<label>E-mail:</label> <span id="userEmail">${sessionScope.user.email}</span>
		</div>
		<div class="user_info">
			<label>연락처:</label> <span id="userPhone">${sessionScope.user.phone}</span>
		</div>
		<div class="user_info">
			<label>직책:</label> <span id="userGrade"> <c:choose>
					<c:when test="${user.grade == 1}">관리자</c:when>
					<c:when test="${user.grade == 2}">사원</c:when>
					<c:when test="${user.grade == 3}">사원</c:when>
				</c:choose>
			</span>
		</div>
	</div>

	<div class="gemini-popup" id="geminiPopup">
		<div class="header">
			<h1>GKBM 1:1 상담</h1>
			<button class="gemini-close-btn" onclick="closeGeminiPopup()">✖</button>
		</div>
		<div class="chat-wrap">
			<!-- 채팅 메시지 영역 -->
		</div>
		<div class="chat-input">
			<textarea id="prompt"></textarea>
			<button id="send">전송</button>
		</div>
	</div>

	<!-- 팝업창 -->
	<div class="info-popup" id="draggable-popup">
		<div class="info-popup-header">사내가</div>
		<div class="info-popup2">
			<div class="checkbox-container">
				<input type="checkbox" id="dont-show-again" /> <label
					for="dont-show-again"> 일주일간 보지 않기</label>
			</div>
			<button class="close-btn" onclick="closePopup()">✖</button>
		</div>
	</div>

	<script>
	// ===================================================
    // 팝업창 move 스크립트
    // ===================================================
	
	let isDragable = false;
		
		let offsetX = 0;
		let offsetY = 0;
		
		
		document.querySelector('.info-popup').addEventListener('mousedown',(event)=>{
			isDragable = true;
			
			offsetX = event.clientX
			offsetY = event.clientY
		})
		
		document.querySelector('.info-popup').addEventListener('mouseup',()=>{
			isDragable = false;
		})
		
		document.querySelector('.info-popup').addEventListener('mousemove',(event)=>{
			if(isDragable){
				let diff_X = event.clientX - offsetX
				let diff_Y = event.clientY - offsetY
				
				let popup = document.querySelector('.info-popup')

				popup.style.top = (popup.offsetTop + diff_Y) + 'px'
				popup.style.left = (popup.offsetLeft + diff_X) + 'px'
				
				offsetX = event.clientX
				offsetY = event.clientY
			}
		})
    	
	// ===================================================
    // 팝업창 쿠키 스크립트
    // ===================================================
	function closePopup() {
	    console.log("메인페이지 팝업창 쿠키확인");
	    const checkbox = document.getElementById("dont-show-again");
	    if (checkbox.checked) {
	        // 쿠키 만료일을 7일 후로 설정
	        const expirationDate = new Date();
	        expirationDate.setDate(expirationDate.getDate() + 7);
	        
	        // 쿠키 설정
	        document.cookie = "hidePopup=true; expires=" + expirationDate.toUTCString() + "; path=/";
	        console.log("쿠키가 설정되었습니다:", document.cookie);
	    }
	    document.querySelector(".info-popup").style.display = "none";
	}

	// 페이지 로드 시 쿠키 확인
	window.addEventListener("DOMContentLoaded", () => {
	    console.log("페이지 로드 시 쿠키 확인");
	    const cookies = document.cookie.split('; ');
	    let hidePopup = false;
	    for(let i = 0; i < cookies.length; i++) {
	        const parts = cookies[i].split('=');
	        if (parts[0] === 'hidePopup' && parts[1] === 'true') {
	            hidePopup = true;
	            break;
	        }
	    }
	    if (hidePopup) {
	        document.querySelector(".info-popup").style.display = "none";
	        console.log("쿠키로 인해 팝업이 표시되지 않습니다.");
	    } else {
	        document.querySelector(".info-popup").style.display = "block";
	        console.log("팝업이 표시됩니다.");
	    }
	});
	
	

	// ===================================================
    // 1. 메뉴 데이터 정의
    // ===================================================
    const subMenuData = {   // 메인 아이템 속성이 data-menu의 내용에 json으로 내용 할당
        '1': ['작업표준서', 'BOM관리', '상품정보관리'],
        '2': ['거래처 정보관리', '거래명세서'],
        '3': ['생산계획관리', '작업지시관리'],
        '4': ['원자재 입고관리', '원자재 출고관리', '원자재 현황', '완제품 입고관리', '완제품 출고관리'],
        '5': ['설비등록', '설비점검', '설비수리'],
        '6': ['소모품 관리', '소모품 수불관리', '소모품 폐기'],
        '7': ['부적합관리', '리퍼브/폐기'],
        '8': ['게시판']		
    };

    // 서브메뉴 상세 항목 정의
    const subMenuDetails = {
        '작업표준서': [],
        'BOM관리': [],
        '상품정보관리': [],
        '거래처 정보관리': [],
        '거래명세서': [],
        '생산계획관리': [],
        '작업지시관리': [],
        '원자재 입고관리': [],
        '원자재 출고관리': [],
        '원자재 현황': [],
        '완제품 입고관리': [],
        '완제품 출고관리': [],
        '설비관리': [],
        '설비점검': [],
        '설비수리': [],
        '소모품 관리': [],
        '소모품 폐기': [],
        '소모품 수불관리': [],
        '부적합관리': [],
        '리퍼브/폐기': [],
        '게시판': [],

    };

    // iframe 매핑 정보
    const subMenuFileMap = {
        // ----- 기준정보 -----
        '작업표준서': 'p_work_method.jsp',
        'BOM관리': 'p_bom.jsp',
        '상품정보관리': 'p_sku.jsp',

        // ----- SCM -----
        '거래처 정보관리': 'vendor.jsp',
        '거래명세서': 'bill.jsp',
        
        // ----- 생산관리 -----
        '생산계획관리': 'week.jsp',
        '작업지시관리': 'work.jsp',

        // ----- 재고관리 -----
        '원자재 입고관리': 'p_material_in_out.jsp',
        '원자재 출고관리': 'p_material_in_out1.jsp',
        '원자재 현황': 'p_material_in_out2.jsp',
        '완제품 입고관리': 'p_product_in_out.jsp',
        '완제품 출고관리': 'p_product_in_out1.jsp',

        // ----- 설비관리 -----
        '설비등록': 'p_equipreg.jsp',
        '설비점검':	'p_ins.jsp',
        '설비수리': 'p_repair.jsp',

        // ----- 소모품관리 -----
        '소모품 관리': 'p_CMB.jsp',
        '소모품 폐기': 'p_CPG.jsp',
        '소모품 수불관리': 'p_CSB.jsp',

        // ----- 품질관리 -----
        '부적합관리': 'defect.jsp',
        '리퍼브/폐기': 'disable.jsp',

        // ----- 커뮤니티 -----
        '게시판': 'board',
    };

    // ===================================================
    // 2. 메뉴 데이터 검증 및 초기화
    // ===================================================
    function validateAndInitializeMenuData() {
        try {
            // subMenuData의 모든 항목이 subMenuDetails에 존재하는지 확인
            Object.values(subMenuData).flat().forEach(item => {
                if (!subMenuDetails[item]) {
                    console.warn(`Warning: ${item} is missing in subMenuDetails. Initializing with empty array.`);
                    subMenuDetails[item] = [];
                }
            });

            // subMenuDetails의 모든 상세 항목이 subMenuFileMap에 존재하는지 확인
            Object.entries(subMenuDetails).forEach(([key, details]) => {
                details.forEach(detail => {
                    if (!subMenuFileMap[detail]) {
                        console.warn(`Warning: ${detail} is missing in subMenuFileMap. Initializing with default.html`);
                        subMenuFileMap[detail] = 'default.html';
                    }
                });
            });
        } catch (error) {
            console.error('Error during menu data validation:', error);
        }
    }

    // ===================================================
    // 3. 메인 이벤트 리스너 및 초기화
    // ===================================================
    document.addEventListener('DOMContentLoaded', function () {
        const logoImage = document.getElementById('logo-image');
        const mainMenuItems = document.querySelectorAll('.menu_item');

        logoImage.addEventListener('click', function () {
            // 모든 메뉴 항목의 활성 상태 제거
            mainMenuItems.forEach(menu => menu.classList.remove('active'));

            // 서브메뉴 닫기
            closeSubMenu();

            // iframe 초기화 (빈 페이지나 홈 페이지로 설정)
            const iframe = document.getElementById('content-frame');
            iframe.src = 'main_dashboard.jsp';  // 또는 빈 페이지: 'about:blank'

            // 활성 메뉴 아이템 초기화
            activeMenuItem = null;
            activeSubItem = null;
        });

        // 메뉴 데이터 검증 및 초기화 실행
        validateAndInitializeMenuData();

        // DOM 요소 참조
        const subMenu = document.getElementById('sub_menu');
        const mainContent = document.getElementById('main_content');
        let activeMenuItem = null;
        let activeSubItem = null;

        // 메인 메뉴 클릭 이벤트 설정
        mainMenuItems.forEach((item) => {
            item.addEventListener('click', function () {
                const menuId = this.getAttribute('data-menu');
                handleMainMenuClick(this, menuId);
            });
        });

        // ===================================================
        // 4. 메뉴 동작 관련 함수들
        // ===================================================

        // 메인 메뉴 클릭 처리
        function handleMainMenuClick(clickedItem, menuId) {
            try {
                if (activeMenuItem === clickedItem) {
                    closeSubMenu();
                    clickedItem.classList.remove('active');
                    activeMenuItem = null;
                } else {
                    mainMenuItems.forEach(menu => menu.classList.remove('active'));
                    clickedItem.classList.add('active');
                    activeMenuItem = clickedItem;
                    openSubMenu(menuId);

                    // 서브메뉴가 열린 후 첫 번째 항목 자동 선택
                    setTimeout(() => {
                        const firstSubItem = subMenu.querySelector('.sub_item');
                        if (firstSubItem) {
                            firstSubItem.click();
                        }
                    }, 100); // 서브메뉴가 열리는 시간을 고려하여 약간의 지연 추가
                }
            } catch (error) {
                console.error('Error in handleMainMenuClick:', error);
            }
        }


        // 서브메뉴 열기
        function openSubMenu(menuId) {
            try {
                if (!subMenuData[menuId]) {
                    console.error(`Invalid menuId: ${menuId}`);
                    return;
                }
                createSubMenu(menuId);
                requestAnimationFrame(() => {
                    subMenu.classList.add('visible');
                    mainContent.style.width = 'calc(100% - 440px)';
                });
            } catch (error) {
                console.error('Error in openSubMenu:', error);
            }
        }

        // 서브메뉴 닫기
        function closeSubMenu() {
            try {
                subMenu.classList.remove('visible');
                mainContent.style.width = 'calc(100% - 220px)';
                setTimeout(() => {
                    subMenu.innerHTML = '';
                }, 300);
            } catch (error) {
                console.error('Error in closeSubMenu:', error);
            }
        }

        // ===================================================
        // 5. 서브메뉴 생성 및 처리
        // ===================================================

        function createSubMenu(menuId) {
            try {
                const menuContent = document.createElement('div');
                const subItems = subMenuData[menuId];

                subItems.forEach(item => {
                    const subMenuItem = document.createElement('div');
                    subMenuItem.className = 'sub_item';
                    subMenuItem.textContent = item;

                    const detailContainer = document.createElement('div');
                    detailContainer.className = 'detail-menu';
                    detailContainer.style.display = 'none';

                    // 하위 메뉴 처리
                    if (!subMenuDetails[item] || subMenuDetails[item].length === 0) {
                        // 직접 iframe 로드하는 항목
                        subMenuItem.addEventListener('click', function (e) {
                            e.stopPropagation();
                            const fileName = subMenuFileMap[item] || 'default.html';
                            loadIframePage(fileName);
                        });
                    } else {
                        // 하위 메뉴 있는 항목 처리
                        createDetailMenu(item, detailContainer);
                    }

                    // 서브메뉴 클릭 이벤트 처리
                    attachSubMenuClickEvent(subMenuItem, detailContainer);

                    menuContent.appendChild(subMenuItem);
                    menuContent.appendChild(detailContainer);
                });

                subMenu.innerHTML = '';
                subMenu.appendChild(menuContent);
            } catch (error) {
                console.error('Error in createSubMenu:', error);
            }
        }

        // ===================================================
        // 6. 상세 메뉴 및 이벤트 처리
        // ===================================================

        // 상세 메뉴 생성
        // 상세 메뉴 생성
        function createDetailMenu(item, container) {
            try {
                if (typeof subMenuDetails[item] === 'object' && Array.isArray(subMenuDetails[item])) {
                    subMenuDetails[item].forEach(detailItem => {
                        const detailElement = document.createElement('div');
                        detailElement.className = 'detail-item';
                        detailElement.textContent = detailItem;
                        detailElement.addEventListener('click', function (e) {
                            e.stopPropagation();
                            // 모든 detail-item에서 'active' 클래스 제거
                            document.querySelectorAll('.detail-item').forEach(item => {
                                item.classList.remove('active');
                            });
                            // 클릭된 항목에 'active' 클래스 추가
                            this.classList.add('active');
                            const fileName = subMenuFileMap[detailItem] || 'default.html';
                            loadIframePage(fileName);
                        });
                        container.appendChild(detailElement);
                    });
                }
            } catch (error) {
                console.error('Error in createDetailMenu:', error);
            }
        }

        // 서브메뉴 클릭 이벤트 연결
        function attachSubMenuClickEvent(menuItem, container) {
            try {
                menuItem.addEventListener('click', function (e) {
                    e.stopPropagation();
                    document.querySelectorAll('.sub_item').forEach(si => {
                        si.classList.remove('active');
                        if (si.nextElementSibling && si.nextElementSibling.className === 'detail-menu') {
                            si.nextElementSibling.style.display = 'none';
                            si.nextElementSibling.querySelectorAll('.detail-item').forEach(item => {
                                item.classList.remove('active');
                            });
                        }
                    });
                    this.classList.add('active');
                    if (container.children.length > 0) {
                        container.style.display = 'block';
                    }
                    activeSubItem = this;
                });
            } catch (error) {
                console.error('Error in attachSubMenuClickEvent:', error);
            }
        }

        // ===================================================
        // 7. iframe 관련 기능
        // ===================================================

        // iframe 페이지 로드
        function loadIframePage(url) {
            try {
                const iframe = document.getElementById('content-frame');
                if (iframe) {
                    iframe.src = url;
                }
            } catch (error) {
                console.error('Error loading iframe page:', error);
            }
        }

        // iframe 크기 조정
        function adjustIframeSize() {
            try {
                const iframe = document.getElementById('content-frame');
                const container = document.querySelector('.graph_section');
                if (iframe && container) {
                    const height = Math.max(container.offsetHeight, 400);
                    iframe.style.height = `${height}px`;
                }
            } catch (error) {
                console.error('Error adjusting iframe size:', error);
            }
        }

        // 이벤트 리스너 추가
        window.addEventListener('load', adjustIframeSize);
        window.addEventListener('resize', adjustIframeSize);
    });

    // ===================================================
    // 8. 사용자 아이콘 관련 기능
    // ===================================================

    // 사용자 아이콘 클릭 이벤트 처리
    const userIcon = document.getElementById('user_icon');
    const userPopup = document.getElementById('user_popup');

    userIcon.addEventListener('click', () => {
        // 팝업의 표시/숨김 상태 토글
        if (userPopup.style.display === 'none' || userPopup.style.display === '') {
            userPopup.style.display = 'block';
        } else {
            userPopup.style.display = 'none';
        }
    });

    // 화면의 다른 곳을 클릭했을 때 팝업 닫기
    document.addEventListener('click', (event) => {
        if (!userIcon.contains(event.target) && !userPopup.contains(event.target)) {
            userPopup.style.display = 'none';
        }
    });
	// ------------------------- 사용자정보 -------------------------
    document.querySelector(".user_inf").addEventListener("click", function () {
            const userData = JSON.parse(sessionStorage.getItem('user'));
            const overlay = document.getElementById('overlay');
            
            document.querySelector(".user_container").style.display = "block";
            document.getElementById('user_popup').style.display = 'none'; // user_popup 닫기
            overlay.style.display = 'flex'; // overlay 활성화
    });
	
	// 사용자 정보창을 표시하는 함수
    function showUserInfo() {
        document.querySelector('.user_container').style.display = 'block';
    }

    // 사용자 정보창을 숨기는 함수
    function closeUserInfo() {
    	const overlay = document.getElementById('overlay');
        document.querySelector('.user_container').style.display = 'none';
        overlay.style.display = 'none'; // overlay 비활성화
    }
    
	// ------------------------- 로그아웃 -------------------------
    document.querySelector("#logout_button").addEventListener("click", function () {
    window.location.href = "logout"; // LogoutServlet으로 요청 보내기
	});

	
	// ------------------------- chatbot -------------------------
    // Gemini 팝업 열기 함수
    function openGeminiPopup() {
        document.getElementById('geminiPopup').style.display = 'flex';
    }

    // Gemini 팝업 닫기 함수
    function closeGeminiPopup() {
    	const overlay = document.getElementById('overlay');
        document.getElementById('geminiPopup').style.display = 'none';
        overlay.style.display = 'none'; // overlay 비활성화
    }

    // 챗봇 클릭 이벤트 핸들러 수정
    document.querySelector(".chatbot").addEventListener("click", function () {
        const geminiPopup = document.getElementById('geminiPopup');
        const overlay = document.getElementById('overlay');
        if (geminiPopup.style.display === 'none' || geminiPopup.style.display === '') {
            geminiPopup.style.display = 'flex'; // Gemini 팝업 열기
            overlay.style.display = 'flex'; // overlay 활성화
        } else {
            geminiPopup.style.display = 'none'; // Gemini 팝업 닫기
            
        }
        console.log("Gemini 팝업 클릭");
           
    });



    const _API_KEY = 'AIzaSyAdqPWR0AhkyAz4b4ksj5sdkT9Gjeen-7s'
    let _contents = []

    window.addEventListener('load', function () {
        initContents()
        bind()
    })
    function bind() {
        document.querySelector("#send").addEventListener('click', ask)
//         document.querySelector("#init").addEventListener('click', initContents)
    }

    function initContents() {
        // 대화 내용 초기화
        _contents = [{
            // role: 'system',
            role: 'user',
            parts: [{
                text: ` 
                    당신은 친절한 GKBM MES 시스템 담당자입니다. 
                    항상 공손하고 세밀하며 친근하고 구체적이지만 누구나 알기 쉬운 내용으로 응답해주세요
                `
            }]
        }]
    }
    function ask() {
        let prompt = document.querySelector("#prompt").value;
        if (prompt.trim().length > 0) {
            document.querySelector("#prompt").value = "";

            // 질문 출력
            makeMsg(prompt, true);

            // AI에게 물어보기
            gemini(prompt);
        }
    }


    function gemini(prompt) {

        makeLoading();

        const url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=' + _API_KEY

        // 대화 내용 저장
        _contents.push({
            role: 'user',
            parts: [{
                text: prompt
            }]
        })
        const data = {
            contents: _contents
        }

        const xhr = new XMLHttpRequest()
        xhr.open('post', url)
        xhr.setRequestHeader('Content-Type', 'application/json')
        xhr.send(JSON.stringify(data))
        xhr.onload = function () {
            document.querySelector(".loading").remove();

            // console.log(xhr.responseText)
            const response = JSON.parse(xhr.responseText)
            const answer = response.candidates[0].content.parts[0].text

            // 응답 내용 저장
            _contents.push({
                role: 'model',
                parts: [{
                    text: answer
                }]
            })

            // 응답 출력
            makeMsg(answer);
        }
    }

    function makeMsg(prompt, isMine, isLoading) {
        let div_wrap = document.createElement("div");
        div_wrap.classList.add("chat-message-wrap");

        let div = document.createElement("div");
        div.classList.add("chat-message");

        if (isMine) {
            div_wrap.classList.add("mine");
            div.classList.add("mine");
        }

        if (isLoading) {
            div_wrap.classList.add("loading");
            div.innerHTML = prompt;
        } else {
            div.innerText = prompt;
        }

        div_wrap.appendChild(div);
        document.querySelector(".chat-wrap").appendChild(div_wrap);

        // 스크롤 아래로
        // const element = document.getElementById(id);
        document.querySelector(".chat-wrap").scrollTop = document.querySelector(".chat-wrap").scrollHeight;
    }

    function makeLoading() {
        let html = '';
        html += '<div class="typing">';
        html += '   <div class="bubble">';
        html += '       <div class="ellipsis one"></div>';
        html += '       <div class="ellipsis two"></div>';
        html += '       <div class="ellipsis three"></div>';
        html += '   </div>';
        html += '</div>';

        makeMsg(html, false, true);
    }

    // 전체 문서에 대한 키 이벤트 리스너 추가
    document.addEventListener("keydown", function (event) {
        // 엔터 키의 keyCode는 13입니다
        if (event.keyCode === 13 || event.key === "Enter") {

            document.getElementById("send").click();

            // 기본 동작 방지 (필요한 경우)
            event.preventDefault();
        }
    });
	</script>

</body>
</html>
