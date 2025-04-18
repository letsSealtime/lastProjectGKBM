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
</head>
<body>

	<form method="get" action="board">
		<select name="type">
			<option value="empno">작성자</option>
			<option value="title">제목</option>
			<option value="board_content">글 내용</option>
		</select> <input type="text" id="search" name="keyword" value="${dto.keyword }">
		<button type="submit">검색</button>
	</form>
	<br>
	
	<table border="1">
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
					<!-- 게시글 번호 -->
					<td>${dto.board_id}</td>

					<!-- 사원번호 -->
					<td>${dto.empno}</td>

					<!-- 게시글 제목 (클릭 시 상세보기) -->
					<td><a href="board_detail?board_id=${dto.board_id}">
							${dto.title}</a></td>

					<!-- 공지사항 여부 -->
					<td>${dto.notice == 1 ? "공지" : "-"}</td>

					<!-- 작성일 -->
					<td>${dto.create_date}</td>

					<!-- 조회수 -->
					<td>${dto.views}</td>

					<!-- 댓글 개수 -->
					<td></td>

				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div>
		<%
				Map map = (Map)request.getAttribute("map");
				BoardDTO boardDTO = (BoardDTO)request.getAttribute("dto");
		
				int total = (Integer)map.get("total");
				int pageNo = boardDTO.getPage(); // 현재 보는 페이지
				int viewCount = boardDTO.getViewCount();
				 	
				 // 1401 / 10 = 140.1 올림해서 141 ceil			 	
				 int lastPage = (int)Math.ceil((double)total / viewCount);
				 				// 	13 % 10 = 2 목록 개수
				 
				 int groupCount = 5; // 한 번에 보여줄 페이지 개수
				 int groupPosition = (int)Math.ceil((double)pageNo / groupCount);
				 					// 1 % 5 = 1 현재 페이지는 몇 그룹?
				 int begin = ((groupPosition-1) * groupCount)+1; // (1-1) * 5 +1 = 1 시작
				 int end = groupPosition * groupCount; // 1 * 5 = 5
				 if(end > lastPage) end = lastPage; // 5 > 2 : end = 2
				 	
				 	
				%>

		<c:if test="<%= begin == 1 %>">
				[이전]
			</c:if>
		<c:if test="<%= begin != 1 %>">
			<a href="board?page=<%= begin-1 %>">[이전]</a>
		</c:if>

		<c:forEach var="i" begin="<%= begin %>" end="<%= end %>">
			<c:if test="${i == dto.page }">
				<c:set var="clazz" value="bold" />
			</c:if>
			<c:if test="${ not (i == dto.page) }">
				<c:set var="clazz" value="" />
			</c:if>

			<a href="board?page=${ i }" class="${clazz }">${ i }</a>
		</c:forEach>

		<c:if test="<%= end == lastPage %>">
				[다음]
			</c:if>
		<c:if test="<%= end != lastPage %>">
			<a href="board?page=<%= end+1 %>">[다음]</a>
		</c:if>

	</div>
	<br>
	<a href="board_form">새 글 작성</a>


</body>
</html>