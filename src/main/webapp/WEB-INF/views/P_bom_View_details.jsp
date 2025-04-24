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
		[원자재] 칫솔모 : 1개 칫솔대 : 1개 고무 : 2개
		<form method="get" action="P_bom_View_details1">
			<table border="1">
				<c:forEach var="bDTO" items="${list00}">
					<tr>
						<td>${bDTO.sku_name}</td>
					</tr>
				</c:forEach>
			</table>
		</form>

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
</body>
</html>
