<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<br>
	<a href="board_form">새 글 작성</a>


</body>
</html>