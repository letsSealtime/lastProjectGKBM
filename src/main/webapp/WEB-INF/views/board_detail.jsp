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
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.board-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
}

th, td {
	padding: 10px;
	border: 1px solid #ccc;
	text-align: left;
}

th {
	background-color: #f0f0f0;
	width: 20%;
}

a {
	display: inline-block;
	margin-right: 10px;
	margin-top: 20px;
	text-decoration: none;
	color: #007BFF;
}

a:hover {
	text-decoration: underline;
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

.button-group {
	margin-top: 30px;
	display: flex;
	justify-content: center;
	gap: 10px;
}

.button-group .action-btn {
	padding: 8px 16px;
	background-color: #4a90e2;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
}

.button-group .action-btn:hover {
	background-color: #0056b3;
}

.comment-input-group {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-top: 20px;
}

.comment-input-group input[type="text"] {
	flex: 1;
	padding: 6px 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.comment-input-group button {
	padding: 6px 12px;
	background-color: #4a90e2;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.comment-input-group button:hover {
	background-color: #0056b3;
}

.comment-body {
	display: flex;
	flex-direction: column;
	gap: 6px;
	margin-top: 10px;
}

.comment-buttons {
	display: flex;
	gap: 6px;
}

input[type="text"] {
	width: 100%;
	padding: 6px;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

<!-- 덧글 CSS -->
.comment_item {
	background: #eef5ff;
	border: 1px solid #c9e0ff;
	border-radius: 8px;
	padding: 12px;
	margin-top: 10px;
	box-shadow: 0 2px 6px rgba(74, 144, 226, 0.2);
	position: relative;
	transition: background 0.3s ease;
}

.comment_item:hover {
	background: #d9eaff;
}

.comment-body {
	display: flex;
	flex-direction: column;
	gap: 4px;
}

.writer_name {
	font-weight: 700;
	color: #004a99;
	font-size: 14px;
}

.comment_content {
	font-size: 14px;
	color: #333;
	word-break: break-word;
}

.comment-buttons {
	display: flex;
	gap: 8px;
	margin-top: 8px;
}

.comment-buttons button {
	padding: 4px 8px;
	background-color: #4a90e2;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 12px;
	color: #fff;
}

.comment-buttons button:hover {
	background-color: #0056b3;
}

.more_comment {
	display: none;
	margin-top: 6px;
}

.more_comment.active {
	display: flex;
	gap: 6px;
	padding-top: 5px;
}

.more_comment button {
	padding: 4px 8px;
	background-color: #4a90e2;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 12px;
}

.more_comment button:hover {
	background-color: #0056b3;
}

.edit_form, .reply_form {
	display: flex;
	align-items: center;
	gap: 6px;
	margin-top: 8px;
}

.edit_text, #reply_text {
	flex: 1;
	padding: 6px 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 13px;
}

.edit_submit, .reply_submit {
	padding: 6px 10px;
	background-color: #4a90e2;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 13px;
}

.edit_submit:hover, .reply_submit:hover {
	background-color: #0056b3;
}


<!-- 토글 CSS -->

.more_comment {
	display: none;
}
.more_comment.active {
	display: flex;
	padding-top: 5px;
}

.reply_form {
	display: none;
}
.reply_form.active {
	display: flex;
	padding-top: 5px;
}

.edit_form {
	display: none;
}
.edit_form.active {
	display: flex;
	padding-top: 5px;
}

</style>
</head>
<body>

	<h2>게시글 상세보기</h2>
	<hr>

	<table border="1">
		<tr>
			<th>번호</th>
			<td><input type="hidden" id="board_id" value="${board.board_id}" />
				${board.board_id}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="hidden" id="empno" value="${board.empno}" />
				${board.writer}</td>
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
		<tr>
			<th>첨부파일</th>
			<td><c:forEach var="file" items="${fileList}">
					<a href="fileDownload?file_name=${file.file_name}">
						${file.file_name}</a>
				</c:forEach></td>
		</tr>
	</table>

	<br>

	<!-- 덧글 영역 -->
	<div id="commentArea">
		<div id="newComment" class="comment-input-group">
			<input type="text" id="commentForm" placeholder="댓글을 입력하세요">
			<button id="submitCommentBtn">입력</button>
		</div>


		<!-- 덧글 리스트 -->
		<div id="commentList"></div>
	</div>

	<!-- 덧글 양식 -->
	<div id="commentTemplate" style="display:none">
		<div class="comment_item" data-comment-id="" data-comment-depth="">
			<div id="comment_body" class="comment-body">
				<span class="writer_name"></span> <span class="comment_content"></span>
				<div class="comment-buttons">
					<button class="reply_btn">답글</button>
					<button class="more_btn">더 보기</button>
				</div>
			</div>


			<!-- 더보기 메뉴 -->
			<div class="more_comment">
				<button class="edit_btn">수정</button>
				<button id="delete_btn">삭제</button>
			</div>

			<!-- 수정창 -->
			<div class="edit_form">
				<input type="text" class="edit_text" />
				<button class="edit_submit">수정완료</button>
			</div>

			<!-- 답글 입력창 -->
			<div class="reply_form">
				<input type="text" id="reply_text" placeholder="답글을 입력하세요." />
				<button class="reply_submit">등록</button>
			</div>

		</div>
	</div>

	<div class="button-group">
		<a href="board_modify?board_id=${board.board_id}"><button
				class="action-btn">수정</button></a> <a
			href="board_delete?board_id=${board.board_id}"><button
				class="action-btn">삭제</button></a> <a href="board"><button
				class="action-btn">목록으로</button></a>
	</div>

	<script>
		document.addEventListener('DOMContentLoaded', function () {
		  const commentSubmitBtn = document.querySelector('#submitCommentBtn');
		  const commentContent = document.querySelector('#commentForm');
		  const commentList = document.querySelector('#commentList');
		  const contextPath = "${pageContext.request.contextPath}";
		  const boardId = document.querySelector("#board_id")?.value || 1;
		  const empno = document.querySelector("#empno")?.value || 0;
		
		  // 댓글 등록
		  commentSubmitBtn?.addEventListener('click', function () {
		    const content = commentContent.value.trim();
		    if (!content) return alert("내용을 입력하세요");
		
		    fetch(contextPath + "/comment_insert", {
		      method: "POST",
		      headers: { "Content-Type": "application/json" },
		      body: JSON.stringify({
		        board_id: boardId,
		        empno: empno,
		        content: content,
		        parent_id: null,
		        depth: 0
		      })
		    })
		    .then(() => {
		      commentContent.value = "";
		      loadComments();
		    });
		  });
		
		  // 댓글 불러오기
	function loadComments() {
  const currentBoardId = document.querySelector("#board_id").value;
  fetch(contextPath + `/comment_list?board_id=${board.board_id}`)
    .then(res => {
      if (!res.ok) throw new Error("안됨");
      return res.json();
    })
    .then(data => {
      commentList.innerHTML = "";
      data.forEach(drawComment);
    })
    .catch(err => {
      console.error("안돼 이것아:", err);
    });
}
		
		  // 댓글 그리기
		  function drawComment(comment) {
		    const template = document.querySelector('#commentTemplate .comment_item').cloneNode(true);
		    template.dataset.commentId = comment.comment_id;
		    template.dataset.depth = comment.depth;
		    template.querySelector('.writer_name').textContent = comment.writer_name;
		    
		    const isDeleted = comment.is_deleted == 1 || comment.is_deleted === "1";
		    template.querySelector('.comment_content').textContent = isDeleted ? "이 댓글은 삭제되었습니다" : comment.content;
			
		    const indentUnit = 40; // px 단위 들여쓰기 간격
		    const marginLeft = comment.depth * indentUnit;

		    template.querySelector('#comment_body').style.marginLeft = `\${marginLeft}px`;
		
		    // 더보기
		    template.querySelector('.more_btn').addEventListener('click', function () {
		      	const more = template.querySelector('.more_comment');
		      	more.classList.toggle("active");
		    });
		
		    // 수정 버튼
		    template.querySelector('.edit_btn').addEventListener('click', function () {
		      template.querySelector('.edit_form').style.display = 'block';
		      template.querySelector('.edit_text').value = comment.content;
		    });
		
		    // 수정 완료
		    template.querySelector('.edit_submit').addEventListener('click', function () {
		      const newContent = template.querySelector('.edit_text').value;
		      fetch(contextPath + "/comment_update", {
		        method: "POST",
		        headers: { "Content-Type": "application/json" },
		        body: JSON.stringify({ comment_id: comment.comment_id, content: newContent })
		      }).then(() => loadComments());
		    });
		
		    // 삭제
		    template.querySelector('#delete_btn').addEventListener('click', function () {
		      fetch(contextPath + "/comment_delete", {
		        method: "POST",
		        headers: { "Content-Type": "application/json" },
		        body: JSON.stringify({ comment_id: comment.comment_id })
		      }).then(() => loadComments());
		    });
		
		    // 답글 폼 열기
		    template.querySelector('.reply_btn').addEventListener('click', function () {
		    	const reply = template.querySelector('.reply_form');
		      	reply.classList.toggle("active");
		      	
		    });
		
		    // 답글 등록
		    template.querySelector('.reply_submit').addEventListener('click', function () {
		      const replyContent = template.querySelector('#reply_text').value;
		      fetch(contextPath + "/comment_insert", {
		        method: "POST",
		        headers: { "Content-Type": "application/json" },
		        body: JSON.stringify({
		          board_id: boardId,
		          empno: empno,
		          content: replyContent,
		          parent_id: comment.comment_id,
		          depth: 1
		        })
		      }).then(() => loadComments());
		    });
		
		    commentList.appendChild(template);
		  }
		
		  // 초기 로딩
		  loadComments();
		});
	
	
	const deleteBtn = document.querySelector("#delete_btn");
	if (deleteBtn) {
	  deleteBtn.addEventListener("click", function (event) {
	    event.preventDefault();

	    const board_id = document.querySelector("#board_id")?.value;
	    console.log("삭제할 게시글 ID", board_id);

	    fetch('/board_delete', {
	      method: 'POST',
	      headers: {
	        'Content-Type': 'application/json'
	      },
	      body: JSON.stringify({
	        board_id: board_id
	      })
	    })
	      .then(resp => resp.json())
	      .then(data => {
	        console.log("삭제 결과", data);
	        // 성공 시 목록으로 이동
	        location.href = "board";
	      })
	      .catch((err) => {
	        console.error("ERROR board fetch", err);
	      });
	  });
	}

	</script>

</body>
</html>
