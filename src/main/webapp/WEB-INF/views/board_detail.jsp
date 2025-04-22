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
		<div id="newComment">
			<textarea id="commentForm" placeholder="내용을 입력해 주세요."></textarea>
			<button id="submitCommentBtn">입력</button>


			<!-- 덧글 리스트 -->
			<div id="commentList"></div>
		</div>

		<!-- 덧글 양식 -->
		<div id="commentTemplate">
			<div class="comment_item" data-comment-id="" data-comment-depth="">
				<div id="comment_body">
					<span class="writer_name"></span> <span class="comment_content"></span>
					<button id="reply_btn">답글</button>
					<button id="more_btn">더 보기</button>
				</div>


				<!-- 더보기 메뉴 -->
				<div class="more_comment" style="display: none">
					<button class="edit_btn">수정</button>
					<button id="delete_btn">삭제</button>
				</div>

				<!-- 수정창 -->
				<div class="edit_form" style="display: none">
					<input type="text" class="edit_text" />
					<button class="edit_submit">수정완료</button>
				</div>

				<!-- 답글 입력창 -->
				<div class="reply_form" style="display: none">
					<input type="text" id="reply_text" placeholder="답글을 입력하세요." />
					<button class="reply_submit">등록</button>
				</div>

			</div>
		</div>
	</div>

	<a href="board_modify?board_id=${board.board_id}">수정</a>
	<a href="board_delete?board_id=${board.board_id}">삭제</a>

	<a href="board">목록으로</a>

	<script>
	document.addEventListener.('DOMContentLoaded', function(){
		const commentForm = document.querySelector("#commentForm");
		const submitComment = document.querySelector("#submitCommentBtn");
		const commentList = document.querySelector("#commentList");
		
		submitComment.addEventListener("click", function(event){
			cost content = commentForm.value.trim();
			if(!content) return alert ('내용을 입력하세요.');
			
			let param = {
					board_id : document.querySelector("#board_id").value,
					empno : document.querySelector("#empno").value,
					content : document.querySelector("#content").value,
					depth : document.querySelector("#depth").value
			};
			
			fetch("comment_insert"){
				method : "POST",
				headers : {
					"Content-Type" : "application/json"
				},
				body : JSON.stringify(param)
			}.then((resp) => resp.json())
			.then((data) => {
				if (data == 1) {
					commentForm ="";
					loadComments();
				} else {
					alert("댓글 입력에 실패했습니다.");
				}.catch((err) => {
					console.error("ERROR comment fetch", err);
				});
			});
		});
		
		
	})
		function loadComments() {
			   fetch("/comment/list")
			   .then(res => res.json())
			   .then(data => {
			   commentList.innerHTML = "";
			   data.forEach(drawComment);
			});
  		}
	
		function drawComments(comment){
			const template = document.querySelector('#commentTemplate .comment_item"').cloneNode(true);
			template.dataset.comment-id = comment.commentId;
			template.dataset.comment-depth= comment.depth;
			template.querySelector('.writer_name').textContent = comment.writerName;
		    template.querySelector('.comment_content').textContent = comment.isDeleted ? "이 댓글은 삭제되었습니다" : comment.content;
		
		    template.querySelector('.more-btn').addEventListener('click', function () {
		        template.querySelector('.more-menu').style.display = 'block';
		      });

		      template.querySelector('.edit-btn').addEventListener('click', function () {
		        template.querySelector('.edit-form').style.display = 'block';
		        template.querySelector('.edit-input').value = comment.content;
		      });

		      template.querySelector('.edit-submit').addEventListener('click', function () {
		        const newContent = template.querySelector('.edit-input').value;
		        fetch("/comment/edit", {
		          method: "POST",
		          headers: { "Content-Type": "application/json" },
		          body: JSON.stringify({ commentId: comment.commentId, content: newContent })
		        }).then(() => loadComments());
		      });

		      template.querySelector('.delete-btn').addEventListener('click', function () {
		        fetch("/comment/delete", {
		          method: "POST",
		          headers: { "Content-Type": "application/json" },
		          body: JSON.stringify({ commentId: comment.commentId })
		        }).then(() => loadComments());
		      });

		      template.querySelector('.reply-btn').addEventListener('click', function () {
		        template.querySelector('.reply-form').style.display = 'block';
		      });

		      template.querySelector('.reply-submit').addEventListener('click', function () {
		        const replyContent = template.querySelector('.reply-input').value;
		        fetch("/comment", {
		          method: "POST",
		          headers: { "Content-Type": "application/json" },
		          body: JSON.stringify({
		            boardId: 1,
		            content: replyContent,
		            parentId: comment.commentId,
		            depth: comment.depth + 1
		          })
		        }).then(() => loadComments());
		      });

		      commentList.appendChild(template);
		    }
		    loadComments();
		  });
		}
	
	
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
		body : JSON.stringify({ 
			command : 'delete', 
			board_id : board_id })
	}).then(resp => json())
	.then(data => {
		console.log(data)
	}).catch((err)=>{
		console.error.('ERROR board fetch', err)
	})
	
	}
	}
	
	const commentUpdateBtn
	const commentDeleteBtn
	const commentInsertBtn
	
		

	</script>

</body>
</html>
