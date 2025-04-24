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
			<td><input type="hidden" id="board_id" value="${board.board_id}" />
				${board.board_id}</td>
		</tr>
		<tr>
			<th>작성자(사원번호)</th>
			<td><input type="hidden" id="empno" value="${board.empno}" />
				${board.empno}</td>
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
			<input type="text" id="commentForm" />
			<button id="submitCommentBtn">입력</button>


			<!-- 덧글 리스트 -->
			<div id="commentList"></div>
		</div>

		<!-- 덧글 양식 -->
		<div id="commentTemplate">
			<div class="comment_item" data-comment-id="" data-comment-depth="">
				<div id="comment_body">
					<span class="writer_name"></span> <span class="comment_content"></span>
					<button class="reply_btn">답글</button>
					<button class="more_btn">더 보기</button>
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
		    template.querySelector('.comment_content').textContent = comment.is_deleted ? "이 댓글은 삭제되었습니다" : comment.content;
			
		    const indentUnit = 24; // px 단위 들여쓰기 간격
		    const marginLeft = comment.depth * indentUnit;

		    template.querySelector('#comment_body').style.marginLeft = `${marginLeft}px`;
		
		    // 더보기
		    template.querySelector('.more_btn').addEventListener('click', function () {
		      template.querySelector('.more_comment').style.display = 'block';
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
		      template.querySelector('.reply_form').style.display = 'block';
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
		          depth: comment.depth + 1
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
