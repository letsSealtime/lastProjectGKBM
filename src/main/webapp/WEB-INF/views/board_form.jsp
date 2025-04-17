<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out
		value="${boardDTO.board_id != null and boardDTO.board_id != 0 ? '게시글 수정' : '새 글 작성'}" /></title>
</head>
<body>

	<h2>
		<c:out
			value="${boardDTO.board_id != null and boardDTO.board_id != 0 ? '게시글 수정' : '새 글 작성'}" />
	</h2>

	<c:if test="${boardDTO.board_id != null and boardDTO.board_id != 0}">
		<input type="hidden" id="board_id" name="board_id"
			value="${boardDTO.board_id}">
		<input type="hidden" id="empno" name="empno" value="${boardDTO.empno}">
	</c:if>

	<table border="1">
		<c:if test="${boardDTO.board_id == null or boardDTO.board_id == 0}">
			<tr>
				<th>사원번호</th>
				<td><input type="text" id="empno" name="empno"></td>
			</tr>
		</c:if>
		<tr>
			<th>제목</th>
			<td><input type="text" id="title" name="title"
				value="${boardDTO.title}"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea id="board_content" name="board_content">${boardDTO.board_content}</textarea></td>
		</tr>
		<tr>
			<th>공지사항</th>
			<td><select id="notice" name="notice">
					<option value="0" ${boardDTO.notice == 0 ? 'selected' : ''}>일반</option>
					<option value="1" ${boardDTO.notice == 1 ? 'selected' : ''}>공지</option>
			</select></td>
		</tr>
		<tr>
			<th>파일첨부</th>
			<td><input type="file" id="files" multiple></td>
		</tr>
	</table>

	<br>
	<c:if test="${boardDTO.board_id != null and boardDTO.board_id != 0}">
		<input type="submit" id="update_btn" value="수정하기">
	</c:if>
	<c:if test="${boardDTO.board_id == null or boardDTO.board_id == 0}">
		<input type="submit" id="insert_btn" value="작성하기">
	</c:if>
	<a href="board">목록으로</a>

	<script>
	function checkParam(param) {
		if (param.title.trim().length === 0) {
			alert("제목 입력은 필수입니다");
			return false;
		}
		if (param.board_content.trim().length === 0) {
			alert("게시글 내용 입력은 필수입니다");
			return false;
		}
		return true;
	}
	
	const updateBtn = document.querySelector("#update_btn");
	const insertBtn = document.querySelector("#insert_btn");
	
	if (updateBtn) {
		updateBtn.addEventListener("click", function (event) {
			event.preventDefault();
	
			let param = {
				board_id: document.querySelector("#board_id").value,
				empno: document.querySelector("#empno").value,
				title: document.querySelector("#title").value,
				board_content: document.querySelector("#board_content").value,
				notice: document.querySelector("#notice").value
			};
	
			if (!checkParam(param)) return;
	
			fetch("board_update", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(param)
			})
				.then((resp) => resp.json())
				.then((data) => {
					if (data == 1) {
						location.href = "board";
					} else {
						alert("게시글 수정에 실패했습니다");
					}
				})
				.catch((err) => {
					console.error("ERROR board fetch", err);
				});
		});
	}
	
	if (insertBtn) {
		insertBtn.addEventListener("click", function (event) {
			event.preventDefault();
	
			let param = {
				empno: document.querySelector("#empno").value,
				title: document.querySelector("#title").value,
				board_content: document.querySelector("#board_content").value,
				notice: document.querySelector("#notice").value
			};
	
			if (!checkParam(param)) return;
	
			fetch("board_insert", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(param)
			})
				.then((resp) => resp.json())
				.then((data) => {
					if (data == 1) {
						location.href = "board";
					} else {
						alert("게시글 작성에 실패했습니다");
					}
				})
				.catch((err) => {
					console.error("ERROR board fetch", err);
				});
		});
	}
</script>


</body>
</html>
