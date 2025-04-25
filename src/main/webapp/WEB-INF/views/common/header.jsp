<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="container">
	<div id="top_section">
		<div id="logo">
			<img
				src="${pageContext.request.contextPath}/resources/img/GKBM_logo.png"
				alt="GKBM MES SYSTEM" id="logo-image">
		</div>

		<div id="main_menu">
			<div class="menu_item" data-menu="1">기준정보</div>
			<div class="menu_item" data-menu="2">SCM</div>
			<div class="menu_item" data-menu="3">생산관리</div>
			<div class="menu_item" data-menu="4">재고관리</div>
			<div class="menu_item" data-menu="5">설비관리</div>
			<c:if test="${user.grade == 1}">
				<div class="menu_item" data-menu="6">소모품관리</div>
			</c:if>
			<div class="menu_item" data-menu="7">품질관리</div>
			<div class="menu_item" data-menu="8">커뮤니티</div>
		</div>

		<!-- 사용자 세션 -->
		<div id="user_section">
			<span> [<c:choose>
					<c:when test="${user.grade == 1}">관리자</c:when>
					<c:otherwise>작업자</c:otherwise>
				</c:choose>] ${user.emp_name}님 환영합니다.
			</span> <img
				src="${pageContext.request.contextPath}/resources/img/usericon.png"
				alt="usericon" id="user_icon">

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