<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.or.GKBM.board.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<style>
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
		font-family: Arial, sans-serif;
	}

	body {
		background-color: #f5f5f5;
	}

	.main-content {
		flex: 1;
		width: 95%;
		margin: auto;
		background: white;
		padding: 20px;
	}

	form, table, .pagination, a {
		margin-top: 20px;
	}

	table {
		width: 100%;
		border-collapse: collapse;
		margin-top: 10px;
	}

	th, td {
		padding: 10px;
		border: 1px solid #ccc;
		text-align: center;
	}

	th {
		background-color: #f0f0f0;
	}

	a.bold {
		font-weight: bold;
		text-decoration: underline;
		color: black;
	}
</style>
</head>
<body>
<div class="main-content">

	<form method="get" action="board">
		<select name="type">
			<option value="empno">작성자</option>
			<option value="title">제목</option>
			<option value="board_content">글 내용</option>
		</select> 
		<input type="text" id="search" name="keyword" value="${dto.keyword }">
		<button type="submit">검색</button>
	</form>

	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>사원번호</th>
				<th>제목</th>
				<th>공지</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>댓글</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${map.list}">
				<tr>
					<td>${dto.board_id}</td>
					<td>${dto.empno}</td>
					<td><a href="board_detail?board_id=${dto.board_id}">${dto.title}</a></td>
					<td>${dto.notice == 1 ? "공지" : "-"}</td>
					<td>${dto.create_date}</td>
					<td>${dto.views}</td>
					<td></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="pagination">
		<%
			Map map = (Map)request.getAttribute("map");
			BoardDTO boardDTO = (BoardDTO)request.getAttribute("dto");

			int total = (Integer)map.get("total");
			int pageNo = boardDTO.getPage();
			int viewCount = boardDTO.getViewCount();
			int lastPage = (int)Math.ceil((double)total / viewCount);

			int groupCount = 5;
			int groupPosition = (int)Math.ceil((double)pageNo / groupCount);
			int begin = ((groupPosition-1) * groupCount)+1;
			int end = groupPosition * groupCount;
			if(end > lastPage) end = lastPage;
		%>

		<c:if test="<%= begin == 1 %>">
			[이전]
		</c:if>
		<c:if test="<%= begin != 1 %>">
			<a href="board?page=<%= begin-1 %>">[이전]</a>
		</c:if>

		<c:forEach var="i" begin="<%= begin %>" end="<%= end %>">
			<c:choose>
				<c:when test="${i == dto.page}">
					<a href="board?page=${i}" class="bold">${i}</a>
				</c:when>
				<c:otherwise>
					<a href="board?page=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<c:if test="<%= end == lastPage %>">
			[다음]
		</c:if>
		<c:if test="<%= end != lastPage %>">
			<a href="board?page=<%= end+1 %>">[다음]</a>
		</c:if>
	</div>

	<a href="board_form">새 글 작성</a>

</div>
</body>
</html>
