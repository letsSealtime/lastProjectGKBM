<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 필요한 원자재</title>
<style>
.content-div {
	margin-top: 20px;
	padding: 15px;
	border: 1px solid #ddd;
}
</style>
</head>
<body>
	<h2>
		완제품 필요한 원자재 상세보기:
		<%=request.getParameter("type")%></h2>
	<%
	String contentType = request.getParameter("type");
	%>
	<%
	if (contentType != null && contentType.contains("칫솔")) {
	%>
	<div class="content-div" id="bristle-content">
		<h3>칫솔 완제품 필요한 원자재</h3>
		<!-- 칫솔 내용 -->
		<div class="content-div" id="bristle-content">
    	[원자재] 칫솔모 : ${bristle}개 칫솔대 : ${handle}개 고무 : ${rubber}개
</div>
		

	</div>

	<%
	} else {
	%>
	<div class="content-div" id="default-content">
		<p>작업 유형을 선택하세요.</p>
	</div>
	<%
	}
	%>
	<button type="button" onclick="history.back()">이전으로</button>
</body>
</html>
