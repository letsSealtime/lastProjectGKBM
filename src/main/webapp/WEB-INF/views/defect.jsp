<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="org.apache.commons.collections.bag.SynchronizedSortedBag"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Defect</title>
<style>
body {
	margin: 0;
	padding: 0;
}

.container {
	width: 95%;
	margin: auto;
	background: white;
	padding: 20px;
}

h1 {
	margin-bottom: 20px;
	border: 1px solid black;
}

.form {
	display: flex;
	gap: 15px;
}

.form-row {
	display: flex;
	flex-grow: 1;
	flex-wrap: wrap;
	align-items: center;
	gap: 10px;
	justify-content: space-between;
}

.form-column {
	flex: 1;
	min-width: 200px;
	box-sizing: border-box;
}

.form-row .buttons {
	margin-left: auto;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

label {
	min-width: 60px;
}

/* input {
	padding: 5px;
	border: 1px solid black;
	border-radius: 5px;
} */
.add_input {
	border: 1px solid black;
	padding: 8px;
	text-align: center;
}

button {
	padding: 10px 15px;
	background: #4a90e2;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background: #0056b3;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

table th, table td {
	border: 1px solid black;
	padding: 8px;
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
	border: 1px solid #ccc;
	border-radius: 5px;
	background: #4a90e2;
	cursor: pointer;
}

.pagination button:hover {
	background: #0056b3;
}

.none {
	display: none;
}

span {
	color: red
}

.select select, input[type='number'], input[type=text] {
	width: 70%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background: #fff;
	color: #333;
	font-size: 14px;
	appearance: none;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.select select, input[type='number'], input[type=text]:focus {
	outline: none;
	border-color: #4a90e2;
	box-shadow: 0 0 5px rgba(74, 144, 226, 0.5);
	background: #fff;
}

select option, input[type='number'], input[type=text] {
	padding: 8px;
	font-size: 14px;
	background-color: #fff;
	color: #333;
	transition: background-color 0.2s ease, color 0.2s ease;
}

select option, input[type='number'], input[type=text]:hover {
	background-color: #e0e0e0;
	color: #333;
}

.red {
	color: red;
	background-color: #f8d7da;
}
</style>

<script>
	window.addEventListener("load", init)

	function init() {

		const search = document.querySelector("#search");
		search.addEventListener("click", () => {
			hidden.value = "search";
		});

		let data = {
			c_d: document.getElementById("c_d").value,
			c_p: document.getElementById("c_p").value,
			c_j: document.getElementById("c_j").value,
			c_type: document.getElementById("c_type").value,
			c_m: document.getElementById("c_m").value
		};

			let xhr = new XMLHttpRequest();

			xhr.open("GET", "defect");
			xhr.setRequestHeader("Content-Type",
					"application/json");
			xhr.send(JSON.stringify(data));

			xhr.onload = function() {
				console.log("Response:", xhr.responseText);

				
				let id = document.querySelector("#c_d");
				let code = document.querySelector("#c_p");
				let name = document.querySelector("#c_j");
				let type = document.querySelector("#c_type");
				let vendor = document.querySelector("#c_m");
						
				json.forEach((value) => {
					let option_1 = document.createElement("option");
					let option_2 = document.createElement("option");
					let option_3 = document.createElement("option");
					let option_4 = document.createElement("option");
					let option_5 = document.createElement("option");
					
					option_1.setAttribute("value", value.c_d);
					option_1.innerText = value.id;
					id.append(option_1)
					option_2.setAttribute("value", value.c_p);
					option_2.innerText = value.code;
					code.append(option_2)
					option_3.setAttribute("value", value.c_j);
					option_3.innerText = value.name;
					name.append(option_3)
					option_4.setAttribute("value", value.c_type);
					option_4.innerText = value.type;
					type.append(option_4)
					option_5.setAttribute("value", value.c_m);
					option_5.innerText = value.covendorde;
					vendor.append(option_5)
					
				});
				

			});
		
	}
</script>

</head>

<body>
	<div class="container">
		<h1>◎ 불량</h1>

		<!-- 입력할곳 및 등록, 조회, 수정, 삭제버튼 -->
		<form id="form" method="get" action="defect">
			<div class="form">
				<div class="form-row">
					<div class="form-column select">
						<label for="c_d">부적합 번호</label> <select id="c_d">
							<option value="">선택</option>
						</select>
					</div>
					<div class="form-column select">
						<label for="c_p">제품코드</label> <select id="c_p">
							<option value="">선택</option>
						</select>
					</div>
					<div class="form-column select">
						<label for="c_j">제품명</label> <select id="c_j">
							<option value="">선택</option>
						</select>
					</div>
					<div class="form-column select">
						<label for="c_type">유형</label> <select id="c_type">
							<option value="">선택</option>
						</select>
					</div>
					<div class="form-column select">
						<label for="c_m">회사명</label> <select id="c_m">
							<option value="">선택</option>
						</select>
					</div>
				</div>
				<div class="form-row">
					<div class="buttons">
						<input type="hidden" id="hidden" name="hidden" value="search">
						<button id="search">조회</button>
					</div>
				</div>
			</div>
			<!-- 내가 체크한것들을 조회버튼을 누르면 추출 -->
			<div id="check"></div>

			<!-- 입력한것을 등록할때 뭐인지 보여줄 칸 -->
			<table>
				<thead>
					<tr>
						<th>부적합 번호</th>
						<th>제품코드</th>
						<th>제품명</th>
						<th>수량</th>
						<th>원자재/완제품</th>
					</tr>
				</thead>

				<!-- 데이터가 추가됩니다 -->
				<tbody id="table-body">
					<c:if test="${not empty select}">
						<c:forEach var="list" items="${ select }">

							<tr data=${ list.c_d }>
								<td>${ list.c_d }</td>
								<td>${ list.c_p }</td>
								<td>${ list.c_j }</td>
								<td>${ list.un }</td>
								<td>${ list.c_type }</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>

			</table>
		</form>
		<!-- 페이지 넘길때 쓸 버튼들 -->
		<div class="pagination">
			<!-- 전체 페이지 수, 이전/다음 페이지 계산 -->
			<c:set var="pageCount"
				value="${(line mod viewCount == 0) ? (line div viewCount) : (line div viewCount + 1)}" />
			<c:set var="prevPage" value="${page - 1}" />
			<c:set var="nextPage" value="${page + 1}" />
			<c:set var="lastPage" value="${pageCount}" />
			<c:set var="safeBegin" value="${begin lt 1 ? 1 : begin}" />
			<c:set var="safeEnd" value="${end gt pageCount ? pageCount : end}" />
			
			<% Integer Begin = (int) request.getAttribute("begin"); %>

<%-- 			<%= "Begin의 값은:" + Begin %> --%>

			<!-- << 첫 페이지 -->
			<c:url var="firstUrl" value="defect">
				<c:param name="page" value="1" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_p" value="${param.c_p}" />
				<c:param name="c_j" value="${param.c_j}" />
				<c:param name="c_type" value="${param.c_type}" />
				<c:param name="c_m" value="${param.c_m}" />
			</c:url>
			<a href="${firstUrl}"><button>&lt;&lt;</button></a>

			<!-- < 이전 페이지 -->
			<c:url var="prevUrl" value="defect">
				<c:param name="page" value="${prevPage}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_p" value="${param.c_p}" />
				<c:param name="c_j" value="${param.c_j}" />
				<c:param name="c_type" value="${param.c_type}" />
				<c:param name="c_m" value="${param.c_m}" />
			</c:url>
			<a href="${prevUrl}"><button>&lt;</button></a>

			<!-- 숫자 페이지 -->
			<c:choose>
				<c:when test="${page == pageCount}">
					<c:forEach var="i" begin="${page - (viewCount -1)}" end="${page}">
						<c:url var="numUrl" value="defect">
							<c:param name="page" value="${i}" />
							<c:param name="c_d" value="${param.c_d}" />
							<c:param name="c_p" value="${param.c_p}" />
							<c:param name="c_j" value="${param.c_j}" />
							<c:param name="c_type" value="${param.c_type}" />
							<c:param name="c_m" value="${param.c_m}" />
						</c:url>
						<c:choose>
							<c:when test="${i == page}">
								<strong><a style="color: red" href="${numUrl}"><button>${i}</button></a></strong>
							</c:when>
							<c:otherwise>
								<a href="${numUrl}"><button>${i}</button></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="i" begin="${safeBegin}" end="${safeEnd}">
						<c:url var="numUrl" value="defect">
							<c:param name="page" value="${i}" />
							<c:param name="c_d" value="${param.c_d}" />
							<c:param name="c_p" value="${param.c_p}" />
							<c:param name="c_j" value="${param.c_j}" />
							<c:param name="c_type" value="${param.c_type}" />
							<c:param name="c_m" value="${param.c_m}" />
						</c:url>
						<c:choose>
							<c:when test="${i == page}">
								<strong><a style="color: red" href="${numUrl}"><button>${i}</button></a></strong>
							</c:when>
							<c:otherwise>
								<a href="${numUrl}"><button>${i}</button></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>

			<!-- > 다음 페이지 -->
			<c:url var="nextUrl" value="defect">
				<c:param name="page" value="${nextPage}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_p" value="${param.c_p}" />
				<c:param name="c_j" value="${param.c_j}" />
				<c:param name="c_type" value="${param.c_type}" />
				<c:param name="c_m" value="${param.c_m}" />
			</c:url>
			<a href="${nextUrl}"><button>&gt;</button></a>

			<!-- >> 마지막 페이지 -->
			<c:url var="lastUrl" value="defect">
				<c:param name="page" value="${pageCount}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_p" value="${param.c_p}" />
				<c:param name="c_j" value="${param.c_j}" />
				<c:param name="c_type" value="${param.c_type}" />
				<c:param name="c_m" value="${param.c_m}" />
			</c:url>
			<a href="${lastUrl}"><button>&gt;&gt;</button></a>
		</div>
	</div>
</body>

</html>