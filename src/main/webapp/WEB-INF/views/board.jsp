<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.or.GKBM.board.*" %>
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

			<c:forEach var="dto" items="${resultList}">
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
		// model은 리퀘스트와 동급 (페이지, 리퀘스트, 세션 복습)
		// model에 담은 것은 request에서 꺼낼 수 있다.
				Map map = (Map)request.getAttribute("map");
				int total = (Integer)map.get("total");
				EmpDTO empDTO = (EmpDTO)request.getAttribute("dto");
				int pageNo = empDTO.getPage();
				 int viewCount = empDTO.getViewCount();
				 	
				 // 1401 / 10 = 140.1 올림해서 141 ceil			 	
				 double lastPage = Math.ceil((double)total / viewCount);
				 	
				 int groupCount = 5; // 한 번에 보여줄 페이지 개수
				 int groupPosition = (int)Math.ceil((double)pageNo / groupCount);
				 int begin = ((groupPosition-1) * groupCount)+1;
				 int end = groupPosition * groupCount;
				 	
				 	
				%>
				
				<c:forEach var="i" begin="<%= begin %>" end="<%= end %>">
				<c:if test="${i == dto.page}">
					<c:set var="clazz" value="bold" />
				</c:if>
				<c:if test="${not (i == dto.page)}">
					<c:set var="clazz" value="" />
				</c:if>
				
				<c:if test="<%= begin == 1 %>">
					[이전]
				</c:if>
				<c:if test="<%= begin != 1 %>">
				<a href="emp?page=<%= begin -1 %>">[이전]</a>
				</c:if>
				
				
				<a href="emp?page=${ i }" class="${clazz}">${ i }</a>
				
				</c:forEach>
	</div>
	<br>
	<a href="board_form">새 글 작성</a>


</body>
</html>