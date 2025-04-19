<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>소모품관리</title>
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

input[type="text"] {
	width: 40%;
}

.소모품명 {
	width: 40%;
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
		<h1>◎ 소모품 관리</h1>

		<span class="별">* 모두기입</span>
		<div class="form">
			<div class="form-fields">
				<div class="form-row">
					<label for="소모품코드">소모품코드<span class="별"> *</span></label> <input
						type="text" id="소모품코드"> <span>소모품명</span><span class="별">
						*</span> <select class="소모품명">
						<option>라텍스장갑</option>
						<option>보안경</option>
						<option>마스크</option>
						<option>헤어넷</option>
						<option>작업복</option>
						<option>안전화</option>
						<option>소독제</option>
						<option>종이타월</option>
						<option>청소용 천</option>
						<option>걸레</option>
						<option>브러시</option>
						<option>진공 청소기 필터</option>
						<option>윤활유</option>
						<option>구리스</option>
						<option>세척제</option>
						<option>부품 세정액</option>
						<option>방청제</option>
						<option>테이프</option>
						<option>완충재</option>
						<option>라벨 스티커</option>
						<option>포장용 끈</option>
						<option>칼</option>
						<option>가위</option>
						<option>마킹 펜</option>
						<option>접착제</option>
						<option>검사용 돋보기</option>
						<option>pH테스트 스트립</option>
						<option>샘플링 백</option>
						<option>품질 검사 스티커</option>
						<option>프린터 잉크 카트리지</option>
						<option>복사용지</option>
						<option>문서파일</option>
						<option>바인터클립</option>
						<option>보드마커</option>
					</select>
				</div>

				<div class="form-row">
					<label for="등록일">등록일<span class="별"> *</span></label> <input
						type="date" id="등록일"> <label for="수량">수량<span
						class="별"> *</span></label> <input type="text" id="수량">
				</div>

				<div class="form-row">
					<label for="관리자">관리자<span class="별"> *</span></label> <input
						type="text" id="관리자"> <label for="비고사항">비고사항</label> <input
						type="text" id="비고사항">
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
	</div>

	<div id="check"></div>

	<table>
		<thead>
			<tr>
				<th><input type="checkbox" id="체크박스"></th>
				<th>소모품코드</th>
				<th>소모품명</th>
				<th>관리자</th>
				<th>수량</th>
				<th>등록일</th>
				<th>비고사항</th>
			</tr>

			<tr>
				<td><input type="checkbox" id="체크박스"></td>
				<td>NT-100</td>
				<td>니트릴장갑</td>
				<td>김천안</td>
				<td>200</td>
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

</html>