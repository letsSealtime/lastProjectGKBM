<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>설비점검관리</title>
<style>
body {
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
	font-family: Arial, sans-serif;
}

.container {
	width: 95%;
	margin: auto;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

h1 {
	margin-bottom: 20px;
	border: 1px solid black;
	padding: 10px;
}

.form {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	margin-bottom: 20px;
}

.form-fields {
	flex: 1;
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.form-row {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 10px;
}

label {
	min-width: 80px;
}

input {
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 5px;
	flex: 1;
}

.buttons {
	display: flex;
	flex-direction: column;
	gap: 10px;
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

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

table th, table td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: center;
}

.pagination {
	margin-top: 20px;
	display: flex;
	justify-content: center;
	gap: 5px;
}

.pagination button {
	padding: 5px 10px;
	border-radius: 5px;
}

@media screen and (max-width: 800px) {
	.form-row {
		flex-direction: column;
		align-items: stretch;
		gap: 5px !important;
		/* 모바일에서 간격 조정 */
		width: auto .buttons{
                    flex-direction: row;
		justify-content: center;
		margin-top: 10px;
	}
	button {
		width: auto;
	}
}

.edit-buttons {
	margin-top: 10px;
}

.active {
	background-color: #0056b3;
}

h1 {
	width: 90%;
}

}
.active {
	background-color: #0056b3;
}

.hide {
	display: none;
}

.별 {
	color: red;
}
</style>
</head>
<body>
	<div class="container">
		<h1>◎ 설비점검관리</h1>
		<span class="별">* 모두기입</span>

		<!-- 검색 폼 -->
		<form method="post" action="p_re" class="form" id="mainForm">
			<span>설비코드 or 설비명</span> <input type="text" name="searchKeyword"
				placeholder="검색어를 입력하세요">
			<button type="submit">검색</button>
		</form>

		<div class="form">
			<div class="form-fields">
				<!-- 입력 필드들 -->
				<div class="form-row">
					<label for="설비코드">설비코드<span class="별"> *</span></label> <input
						type="text" id="설비코드"> <label for="점검항목">점검항목<span
						class="별"> *</span></label> <select id="점검항목" style="width: 38%;">
						<option>목록1</option>
						<option>목록2</option>
						<option>목록3</option>
						<option>목록4</option>
						<option>목록5</option>
					</select>
				</div>

				<div class="form-row">
					<label for="점검자">점검자<span class="별"> *</span></label> <input
						type="text" id="점검자"> <label for="설비명">설비명<span
						class="별"> *</span></label> <input type="text" id="설비명">
				</div>

				<div class="form-row">
					<label for="설비점검일">설비점검일<span class="별"> *</span></label> <input
						type="date" id="설비점검일"> <label for="점검내용">점검내용<span
						class="별"> *</span></label> <input type="text" id="점검내용">
				</div>
				<div class="form-row">
					<label for="비고사항">비고사항</label> <input type="text" id="비고사항">
				</div>
			</div>

			<!-- 버튼 영역 -->
			<div class="buttons">
				<c:if test="${user.grade == 2}">
					<button type="button" class="buttons search1">조회</button>
				</c:if>
				<c:if test="${user.grade == 1}">
					<button type="submit" value="insert" class="buttons insert1"
						name="action">등록</button>
					<button type="button" class="buttons search1">조회</button>
					<button type="submit" value="update" class="buttons update1"
						name="action">수정</button>
					<button type="submit" value="delete" class="buttons delete1"
						name="action">삭제</button>
				</c:if>
			</div>
		</div>

		<div id="check"></div>

		<!-- 테이블 -->
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="체크박스"></th>
					<th>설비코드</th>
					<th>설비명</th>
					<th>점검자</th>
					<th>점검항목</th>
					<th>점검내용</th>
					<th>설비점검일</th>
					<th>비고사항</th>
				</tr>
				<tr>
					<td><input type="checkbox" id="체크박스"></td>
					<td>G10071</td>
					<td>G-100</td>
					<td>박천안</td>
					<td>1번벨트</td>
					<td>이상무</td>
					<td>2025-02-06</td>
					<td>-</td>
				</tr>
			</thead>
			<tbody id="table-body"></tbody>
		</table>

		<!-- 페이지 넘길때 쓸 버튼들 -->
		<div class="pagination">
			<button>&lt;</button>
			<button>1</button>
			<button>2</button>
			<button>3</button>
			<button>4</button>
			<button>5</button>
			<button>6</button>
			<button>7</button>
			<button>8</button>
			<button>9</button>
			<button>10</button>
			<button>&gt;</button>
		</div>
	</div>

	<script>
		
	</script>
</body>