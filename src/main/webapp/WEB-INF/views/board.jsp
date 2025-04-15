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
				<th>삭제</th>
			</tr>
		</thead>

		<tbody>

			<c:forEach var="dto" items="${resultList}">
				<tr>
					<!-- 게시글 번호 -->
					<td>${dto.boardId}</td>

					<!-- 사원번호 -->
					<td>${dto.empno}</td>

					<!-- 게시글 제목 (클릭 시 상세보기) -->
					<td><a href="board?action=detail&boardId=${dto.boardId}">
							${dto.title}</a></td>

					<!-- 공지사항 여부 -->
					<td>${dto.notice == 1 ? "공지" : "-"}</td>

					<!-- 작성일 -->
					<td>${dto.createDate}</td>

					<!-- 조회수 -->
					<td>${dto.views}</td>


					<td></td>

					<!-- 삭제 버튼 -->
					<td>
						<button class="delete" value="${dto.boardId}"
							style="border-radius: 4px; background-color: #dc3545; color: white; border: none">
							삭제
						</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<br>
	<a href="board?action=form">새 글 작성</a>


	<script>
	
	document.querySelector("#delete").addEventListener("click", function(event){
		event.preventDefault();
	
	
	fetch('board', {
		method : 'POST',
		headers : {
			'Content-Type' : 'appication/json'
		},
		body : JSON.stringify(param)
	}).then(function(resp){
		return. resp.json()
	}).then((data => ){
		console.log(data)
	}).catch((err)=>{
		console.error('ERROR board fetch', err)
	})
	
	</script>


</body>
</html>