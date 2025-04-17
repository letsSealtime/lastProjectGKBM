<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
</head>
<body>

	<h2>게시글 상세보기</h2>
	<hr>

	<table border="1">
		<tr>
			<th>번호</th>
			<td>${board.board_id}</td>
		</tr>
		<tr>
			<th>작성자(사원번호)</th>
			<td>${board.empno}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${board.title}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${board.board_content}</td>
		</tr>
		<tr>
			<th>공지사항 여부</th>
			<td>${board.notice == 1 ? "공지" : "-"}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${board.create_date}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${board.views}</td>
		</tr>
	</table>

	<br>

	<!-- 	<form action="comment" method="post"> -->
	<!-- 		<input type="hidden" name="command" value="insert"> <input -->
	<%-- 			type="hidden" name="boardId" value="${board.boardId}"> --%>
	<!-- 		<textarea name="content"></textarea> -->
	<!-- 		<input type="submit" name="comment" value="덧글등록"> -->
	<!-- 	</form> -->

	<!-- 	<table border="1"> -->
	<%-- 		<c:forEach var="comment" items="${resultList}"> --%>
	<!-- 			<tr> -->

	<!-- 				 ID -->
	<%-- 				<td>${comment.writerName}</td> --%>

	<!-- 				덧글 내용 -->
	<%-- 				<td>${comment.content}</td> --%>

	<!-- 				작성일 -->
	<%-- 				<td>${comment.createDate}</td> --%>

	<!-- 				수정버튼 -->
	<!-- 				<td> -->
	<!-- 					<form action="comment" method="post"> -->
	<!-- 						<input type="hidden" name="command" value="update"> <input -->
	<%-- 							type="hidden" name="commentId" value="${comment.commentId}"> --%>
	<%-- 						<input type="hidden" name="boardId" value="${board.boardId}"> --%>
	<%-- 						<input type="text" name="content" value="${comment.content}"> --%>
	<!-- 						<input type="submit" value="수정"> -->
	<!-- 					</form> -->
	<!-- 				</td> -->

	<!-- 				<td> -->
	<!-- 					<form action="comment" method="post"> -->
	<!-- 						<input type="hidden" name="command" value="delete"> <input -->
	<%-- 							type="hidden" name="boardId" value="${board.boardId}"> <input --%>
	<%-- 							type="hidden" name="commentId" value="${comment.commentId}"> --%>
	<!-- 						<input type="submit" value="삭제"> -->
	<!-- 					</form> -->
	<!-- 				</td> -->
	<!-- 			</tr> -->
	<%-- 		</c:forEach> --%>
	<!-- 		<tr> -->
	<!-- 			<th>첨부파일</th> -->
	<%-- 			<td><c:forEach var="file" items="${fileList}"> --%>
	<%-- 					<a href="file?action=download&fileName=${file.fileName}">${file.fileName}</a> --%>
	<%-- 				</c:forEach></td> --%>
	<!-- 		</tr> -->
	<!-- 	</table> -->

	<a href="board_modify?board_id=${board.board_id}">수정</a>
	<a href="board_delete?board_id=${board.board_id}">삭제</a>

	<a href="board">목록으로</a>

	<script>
	
	document.querySelector("#delete").addEventListener("click", function(event){
		event.preventDefault();
		
		const board_id = this.value;
		console.log("삭제할 게시글 ID", board_id);

	function deleteBoard(){
	fetch('board', {
		method : 'POST',
		header : {
			'Content-Type': 'application/json'
		},
		body : JSON.stringify({ command : 'delete', board_id})
	}).then(resp => json())
	.then(data => {
		console.log(data)
	}).catch((err)=>{
		console.error.('ERROR board fetch', err)
	})
	
	}
	}
		
		

	</script>

</body>
</html>
