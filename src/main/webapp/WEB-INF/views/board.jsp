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

button {
	padding: 10px 15px;
	background-color: #4a90e2;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #0056b3;
	}
	
	
.pagination {
	margin-top: 20px;
	display: flex;
	justify-content: center;
	gap: 5px;
}

.pagination button {
	padding: 5px 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background: #4a90e2;
	cursor: pointer;
}

.pagination button:hover {
	background: #0056b3;
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
		int pageNo = boardDTO.getPage(); // 현재 페이지
		int viewCount = boardDTO.getViewCount(); // 페이지당 게시글 수
		int lastPage = (int)Math.ceil((double)total / viewCount); // 전체 페이지 수

		int groupCount = 5; // 한번에 보여줄 페이지 버튼 수
		int groupPosition = (int)Math.ceil((double)pageNo / groupCount); // 현재 그룹
		int begin = ((groupPosition - 1) * groupCount) + 1;
		int end = groupPosition * groupCount;
		if (end > lastPage) end = lastPage;

		int prevPage = begin - 1;
		int nextPage = end + 1;
	%>

	<a href="board?page=1"><button>&lt;&lt;</button></a>
	<a href="board?page=<%= (prevPage < 1 ? 1 : prevPage) %>"><button>&lt;</button></a>

	<c:forEach var="i" begin="<%= begin %>" end="<%= end %>">
		<c:choose>
			<c:when test="${i == dto.page}">
				<a href="board?page=${i}"><button>${i}</button></a>
			</c:when>
			<c:otherwise>
				<a href="board?page=${i}"><button>${i}</button></a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<a href="board?page=<%= (nextPage > lastPage ? lastPage : nextPage) %>"><button>&gt;</button></a>
	<a href="board?page=<%= lastPage %>"><button>&gt;&gt;</button></a>
</div>


	<a href="board_form"><button style="color:white">새 글 작성</button></a>

</div>
</body>
</html>
