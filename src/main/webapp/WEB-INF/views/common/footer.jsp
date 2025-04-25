<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


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