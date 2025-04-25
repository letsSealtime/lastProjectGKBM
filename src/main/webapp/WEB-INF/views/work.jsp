<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<style>
body {
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
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
	appearance: auto;
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
	window.addEventListener("DOMContentLoaded", init)

	function init() {

		let name = document.getElementById("c_n");
		let year = document.getElementById("c_y");
		let week = document.getElementById("c_w");

		let year_selected = false;
		let week_selected = false;

		year.addEventListener("change", (event) => {
			name.innerHTML = "<option value=''></option>";
			year_selected = true;

			if (year_selected && week_selected) {
				let data = {
					c_y: year.value,
					c_w: week.value
				};

				let xhr = new XMLHttpRequest();
				xhr.open("POST", "work");
				xhr.setRequestHeader("Content-Type", "application/json");
				xhr.send(JSON.stringify(data));

				xhr.onload = function () {
					console.log("Response:", xhr.responseText);
					let json = JSON.parse(xhr.responseText);
					console.log(json);

					name.innerHTML = "<option value=''></option>"; // 초기화

					json.forEach((value) => {
						let option = document.createElement("option");
						option.setAttribute("value", value.c_n);
						option.innerText = value.c_n;
						name.append(option);
					});
				};
			}
		}); // year change 끝

		week.addEventListener("change", (event) => {
			name.innerHTML = "<option value=''></option>";
			week_selected = true;

			if (year_selected && week_selected) {
				let data = {
					c_y: year.value,
					c_w: week.value
				};

				let xhr = new XMLHttpRequest();
				xhr.open("POST", "work");
				xhr.setRequestHeader("Content-Type", "application/json");
				xhr.send(JSON.stringify(data));

				xhr.onload = function () {
					console.log("Response:", xhr.responseText);
					let json = JSON.parse(xhr.responseText);
					console.log(json);

					name.innerHTML = "<option value=''></option>"; // 초기화

					json.forEach((value) => {
						let option = document.createElement("option");
						option.setAttribute("value", value.c_n);
						option.innerText = value.c_n;
						name.append(option);
					});
				};
			}
		}); // week change 끝

		// 상품 선택 시
		name.addEventListener("change", (event) => {
			
			let id = document.querySelector("#c_pn");
			
			id.innerHTML = "<option value=''></option>";

			let data = {
					c_y: year.value,
					c_w: week.value,
					c_n: name.value
			};

			let xhr = new XMLHttpRequest();
			xhr.open("POST", "work");
			xhr.setRequestHeader("Content-Type", "application/json");
			xhr.send(JSON.stringify(data));

			xhr.onload = function () {
				console.log("Response:", xhr.responseText);
				let json = JSON.parse(xhr.responseText);
				console.log(json);

				let number = document.querySelector("#c_pn");
				json.forEach((value) => {
					let option = document.createElement("option");
					option.setAttribute("value", value.c_pn);
					option.innerText = value.c_pn;
					number.append(option);
				});
			};
		});

		// 생산계획번호 선택 시
		let id = document.getElementById("c_pn");
		id.addEventListener("change", (event) => {
			let plan_id = document.querySelector("#c_p");
			let bom_id = document.querySelector("#c_b");
			let sku_code = document.querySelector("#c_c");
			let sku_name = document.querySelector("#c_m");
			let plan_count = document.querySelector("#c_cc");
			let plan_sum = document.querySelector("#c_s");
			let self = document.querySelector("#c_d");
			let remain = document.querySelector("#c_r");

			plan_id.value = "";
			bom_id.value = "";
			sku_code.value = "";
			sku_name.value = "";
			plan_count.value = "";
			plan_sum.value = "";
			remain.value = "";

			let data = {
					c_y: year.value,
					c_w: week.value,
					c_n: name.value,
					c_pn: id.value
			};

			let xhr = new XMLHttpRequest();
			xhr.open("POST", "work");
			xhr.setRequestHeader("Content-Type", "application/json");
			xhr.send(JSON.stringify(data));

			xhr.onload = function () {
				console.log("Response:", xhr.responseText);
				let json = JSON.parse(xhr.responseText);
				console.log(json);

				json.forEach((value) => {
					plan_id.value = value.c_p;
					bom_id.value = value.c_b;
					sku_code.value = value.c_c;
					sku_name.value = value.c_n;
					plan_count.value = value.c_cc;
					plan_sum.value = value.c_s;

					self.addEventListener("change", (event) => {
						const insert = document.querySelector("#insert");
						let count = value.c_cc - self.value;

						 if (self.value > 0 && self.value <= value.c_cc) {
						 	remain.value = count;
						 	insert.classList.remove("none"); // 버튼 보이게
						 } else {
						 	remain.value = count;
						 	insert.classList.add("none"); // 버튼 숨기기
						  }
					});
				});
			};
		});

		const hidden = document.querySelector("#hidden");
		const insert = document.querySelector("#insert");

		insert.addEventListener("click", function (event) {
			event.preventDefault();
			hidden.value = "insert";

			let data = {
					c_pn: document.querySelector("#c_pn").value,
					c_b: document.querySelector("#c_b").value,
					c_d: document.querySelector("#c_d").value
			};

			let xhr = new XMLHttpRequest();
			xhr.open("PUT", "work");
			xhr.setRequestHeader("Content-Type", "application/json");
			xhr.send(JSON.stringify(data));

			xhr.onreadystatechange = () => {
				if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
					try {
						let json = JSON.parse(xhr.responseText);
						document.getElementById('check').innerText = json.error;
					} catch (e) {
						document.querySelector("#search").click();
					}
				}
			};
		});

		document.querySelector("#search").addEventListener("click", () => {
			hidden.value = "search";
		});

		const all_check = document.querySelector("#checkbox");
		let check = document.querySelectorAll("#table-body input[type='checkbox']");

		all_check.addEventListener("click", () => {
			check.forEach(c => c.checked = all_check.checked);
		});

		check.forEach(c => {
			c.addEventListener("click", () => {
				if (!c.checked) {
					all_check.checked = false;
				}

				let flag = true;
				check.forEach(value => {
					if (!value.checked) {
						flag = false;
					}
				});

				all_check.checked = flag;
			});
		});

		const btn = document.querySelectorAll(".btn");
		btn.forEach(btn_ => {
			btn_.addEventListener("click", function (event) {
				event.preventDefault();
				let value = btn_.closest("tr").querySelector(".un").value;
				let id = btn_.closest("tr").querySelector("#wi").value;

				let data = {
						un: document.querySelector(".un").value,
						wi: document.querySelector("#wi").value
				};

				let xhr = new XMLHttpRequest();
				xhr.open("PUT", "defect");
				xhr.setRequestHeader("Content-Type", "application/json");
				xhr.send(JSON.stringify(data));

				xhr.onreadystatechange = () => {
					if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
						try {
							let json = JSON.parse(xhr.responseText);
							document.getElementById('check').innerText = json.error;
						} catch (e) {
							document.querySelector("#search").click();
						}
					}
				};
			});
		});
	}
</script>

</head>

<body>
	<div class="container">
		<h1>◎ 작업 지시 관리</h1>

		<!-- 입력할곳 및 등록, 조회, 수정, 삭제버튼 -->
		<span>* 모두 기입</span>
		<form id="form" method="get" action="work">
			<div class="form">
				<div class="form-row">
					<div class="form-column select">
						년도<span>*</span> <select id="c_y" name="c_y">
							<option></option>
							<c:if test="${not empty select}">
								<c:forEach var="list" items="${ select }">

									<option data=${ list.c_y } value=${ list.c_y }>${ list.c_y }</option>

								</c:forEach>
							</c:if>
						</select>
					</div>
					<div class="form-column select">
						주차<span>*</span> <select id="c_w" name="c_w">
							<option></option>
							<c:if test="${not empty select}">
								<c:forEach var="list" items="${ select }">

									<option data=${ list.c_w } value=${ list.c_w }>${ list.c_w }</option>

								</c:forEach>
							</c:if>
						</select>
					</div>
					<div class="form-column select">
						상품<span>*</span><select id="c_n" name="c_n">
							<option value=""></option>
						</select>
					</div>
					<div class="form-column select">
						번호<span>*</span><select id="c_pn" name="c_pn">
							<option value=""></option>
						</select>
					</div>
					<hr>
					<div class="form-row">
						<div class="form-column">
							<input type="text" id="c_p" name="c_p" value=""
								placeholder="생산계획번호" readonly="readonly">
						</div>
						<div class="form-column">
							<input type="text" id="c_b" name="c_b" value=""
								placeholder="BOM_ID" readonly="readonly">
						</div>
						<div class="form-column">
							<input type="text" id="c_c" name="c_c" value=""
								placeholder="상품코드" readonly="readonly">
						</div>
						<div class="form-column">
							<input type="text" id="c_m" name="c_m" value="" placeholder="상품명"
								readonly="readonly">
						</div>
						<div class="form-column">
							<input type="text" id="c_cc" name="c_cc" value=""
								placeholder="주차생산계획수량" readonly="readonly">
						</div>
						<div class="form-column">
							<input type="text" id="c_s" name="c_s" value=""
								placeholder="주차잔여수량" readonly="readonly">
						</div>
						<div class="form-column">
							<input type="text" id="c_d" name="c_d" value=""
								placeholder="일일지시수량*(기입필)">
						</div>
						<div class="form-column">
							<input type="text" id="c_r" name="c_r" value=""
								placeholder="주차잔여수량" readonly="readonly">
						</div>
						<div class="buttons">
							<button class="none" type="button" id="insert">확정</button>
						</div>
					</div>
				</div>
				<div class="form-row second">
					<div class="buttons">
						<input type="hidden" id="hidden" name="hidden" value="search">
						<button type="submit" id="search">조회</button>
						<c:if test="${ lu eq 2 }">
							<input type="hidden" id="hidden" name="hidden" value="search">
							<button type="submit" id="search">조회</button>
						</c:if>
						<c:if test="${ lu eq 1 }">
							<input type="hidden" id="hidden" name="hidden" value="search">
							<button type="submit" id="search">조회</button>
						</c:if>
					</div>
				</div>
			</div>
			<!-- 내가 체크한것들을 조회버튼을 누르면 추출 -->
			<div id="check"></div>

			<!-- 입력한것을 등록할때 뭐인지 보여줄 칸 -->
			<table>
				<thead>
					<tr>
						<th><input class="check" type="checkbox" id="checkbox"></th>
						<th>등록날짜</th>
						<th>생성계획번호</th>
						<th>상품명</th>
						<th>상품코드</th>
						<th>주차 생산수량</th>
						<th>일일 지시수량</th>
						<th>불량수량</th>
						<th>불량버튼</th>
						<th>완료여부</th>
					</tr>
				</thead>

				<!-- 데이터가 추가됩니다 -->
				<tbody id="table-body">
					<c:if test="${not empty select_1}">
						<c:forEach var="list" items="${ select_1 }">

							<tr data=${ list.wi }>
								<td><input type="checkbox" id="wi" name="box"
									value=${ list.wi }></td>
								<td>${ list.modify_date }</td>
								<td>${ list.wi }</td>
								<td><a
									href="P_work_method_View_details1?type=${ list.c_n }">${ list.c_n }</a></td>
								<td>${ list.c_c }</td>
								<td>${ list.c_cc }</td>
								<td>${ list.q }</td>
								<td><input type="number" class="un" name="un" value=""></td>
								<c:choose>
									<c:when test="${list.coml eq 'Y'}">
										<td>완료</td>
									</c:when>
									<c:otherwise>
										<td><button type="button" class="btn" name="btn"
												value="${ list.wi }">기입</button></td>
									</c:otherwise>
								</c:choose>
								<td>${ list.coml }</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>

			</table>
		</form>
		<!-- 페이지 넘길때 쓸 버튼들 -->
		<div class="pagination">
			<!-- 페이지 카운트 및 이전/다음 페이지 설정 -->
			<c:set var="pageCount"
				value="${(line mod viewCount == 0) ? (line div viewCount) : (line div viewCount + 1)}" />
			<c:set var="prevPage" value="${page - viewCount}" />
			<c:set var="nextPage" value="${page + viewCount}" />

			<!-- << 버튼 (첫 페이지로 이동) -->
			<c:url var="firstPageUrl" value="vendor">
				<c:param name="page" value="1" />
				<c:param name="c_y" value="${param.c_y}" />
				<c:param name="c_w" value="${param.c_w}" />
				<c:param name="c_n" value="${param.c_n}" />
				<c:param name="c_pn" value="${param.c_pn}" />
				<c:param name="c_p" value="${param.c_p}" />
				<c:param name="wi" value="${param.wi}" />
				<c:param name="c_b" value="${param.c_b}" />
				<c:param name="c_c" value="${param.c_c}" />
				<c:param name="c_m" value="${param.c_m}" />
				<c:param name="c_cc" value="${param.c_cc}" />
				<c:param name="c_s" value="${param.c_s}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_r" value="${param.c_r}" />
				<c:param name="q" value="${param.q}" />
				<c:param name="coml" value="${param.coml}" />
				<c:param name="modify_date" value="${param.modify_date}" />
			</c:url>
			<a href="${firstPageUrl}"><button>&lt;&lt;</button></a>

			<!-- < 버튼 (이전 페이지로 이동) -->
			<c:url var="prevPageUrl" value="vendor">
				<c:param name="page" value="${prevPage}" />
				<c:param name="c_y" value="${param.c_y}" />
				<c:param name="c_w" value="${param.c_w}" />
				<c:param name="c_n" value="${param.c_n}" />
				<c:param name="c_pn" value="${param.c_pn}" />
				<c:param name="c_p" value="${param.c_p}" />
				<c:param name="wi" value="${param.wi}" />
				<c:param name="c_b" value="${param.c_b}" />
				<c:param name="c_c" value="${param.c_c}" />
				<c:param name="c_m" value="${param.c_m}" />
				<c:param name="c_cc" value="${param.c_cc}" />
				<c:param name="c_s" value="${param.c_s}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_r" value="${param.c_r}" />
				<c:param name="q" value="${param.q}" />
				<c:param name="coml" value="${param.coml}" />
				<c:param name="modify_date" value="${param.modify_date}" />
			</c:url>
			<a href="${prevPageUrl}"><button>&lt;</button></a>

			<!-- 페이지 번호 선택 -->
			<c:choose>
				<c:when test="${ page == pageCount }">
					<c:forEach var="i" begin="${ page - (viewCount - 1) }"
						end="${ page }">
						<c:choose>
							<c:when test="${ i == page }">
								<strong> <c:url var="currentPageUrl" value="vendor">
										<c:param name="page" value="${i}" />
										<c:param name="c_y" value="${param.c_y}" />
										<c:param name="c_w" value="${param.c_w}" />
										<c:param name="c_n" value="${param.c_n}" />
										<c:param name="c_pn" value="${param.c_pn}" />
										<c:param name="c_p" value="${param.c_p}" />
										<c:param name="wi" value="${param.wi}" />
										<c:param name="c_b" value="${param.c_b}" />
										<c:param name="c_c" value="${param.c_c}" />
										<c:param name="c_m" value="${param.c_m}" />
										<c:param name="c_cc" value="${param.c_cc}" />
										<c:param name="c_s" value="${param.c_s}" />
										<c:param name="c_d" value="${param.c_d}" />
										<c:param name="c_r" value="${param.c_r}" />
										<c:param name="q" value="${param.q}" />
										<c:param name="coml" value="${param.coml}" />
										<c:param name="modify_date" value="${param.modify_date}" />
									</c:url> <a style="color: red;" href="${currentPageUrl}"><button>${i}</button></a>
								</strong>
							</c:when>
							<c:otherwise>
								<c:url var="pageUrl" value="vendor">
									<c:param name="page" value="${i}" />
									<c:param name="c_y" value="${param.c_y}" />
									<c:param name="c_w" value="${param.c_w}" />
									<c:param name="c_n" value="${param.c_n}" />
									<c:param name="c_pn" value="${param.c_pn}" />
									<c:param name="c_p" value="${param.c_p}" />
									<c:param name="wi" value="${param.wi}" />
									<c:param name="c_b" value="${param.c_b}" />
									<c:param name="c_c" value="${param.c_c}" />
									<c:param name="c_m" value="${param.c_m}" />
									<c:param name="c_cc" value="${param.c_cc}" />
									<c:param name="c_s" value="${param.c_s}" />
									<c:param name="c_d" value="${param.c_d}" />
									<c:param name="c_r" value="${param.c_r}" />
									<c:param name="q" value="${param.q}" />
									<c:param name="coml" value="${param.coml}" />
									<c:param name="modify_date" value="${param.modify_date}" />
								</c:url>
								<a href="${pageUrl}"><button>${i}</button></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="i" begin="${ begin }" end="${ end }">
						<c:choose>
							<c:when test="${ i == page }">
								<strong> <c:url var="currentPageUrl" value="vendor">
										<c:param name="page" value="${i}" />
										<c:param name="c_y" value="${param.c_y}" />
										<c:param name="c_w" value="${param.c_w}" />
										<c:param name="c_n" value="${param.c_n}" />
										<c:param name="c_pn" value="${param.c_pn}" />
										<c:param name="c_p" value="${param.c_p}" />
										<c:param name="wi" value="${param.wi}" />
										<c:param name="c_b" value="${param.c_b}" />
										<c:param name="c_c" value="${param.c_c}" />
										<c:param name="c_m" value="${param.c_m}" />
										<c:param name="c_cc" value="${param.c_cc}" />
										<c:param name="c_s" value="${param.c_s}" />
										<c:param name="c_d" value="${param.c_d}" />
										<c:param name="c_r" value="${param.c_r}" />
										<c:param name="q" value="${param.q}" />
										<c:param name="coml" value="${param.coml}" />
										<c:param name="modify_date" value="${param.modify_date}" />
									</c:url> <a style="color: red;" href="${currentPageUrl}"><button>${i}</button></a>
								</strong>
							</c:when>
							<c:otherwise>
								<c:url var="pageUrl" value="vendor">
									<c:param name="page" value="${i}" />
									<c:param name="c_y" value="${param.c_y}" />
									<c:param name="c_w" value="${param.c.c}" />
									<c:param name="c_n" value="${param.c_n}" />
									<c:param name="c_pn" value="${param.c_pn}" />
									<c:param name="c_p" value="${param.c_p}" />
									<c:param name="wi" value="${param.wi}" />
									<c:param name="c_b" value="${param.c_b}" />
									<c:param name="c_c" value="${param.c_c}" />
									<c:param name="c_m" value="${param.c_m}" />
									<c:param name="c_cc" value="${param.c_cc}" />
									<c:param name="c_s" value="${param.c_s}" />
									<c:param name="c_d" value="${param.c_d}" />
									<c:param name="c_r" value="${param.c_r}" />
									<c:param name="q" value="${param.q}" />
									<c:param name="coml" value="${param.coml}" />
									<c:param name="modify_date" value="${param.modify_date}" />
								</c:url>
								<a href="${pageUrl}"><button>${i}</button></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>

			<!-- > 버튼 (다음 페이지로 이동) -->
			<c:url var="nextPageUrl" value="vendor">
				<c:param name="page" value="${nextPage}" />
				<c:param name="c_y" value="${param.c_y}" />
				<c:param name="c_w" value="${param.c_w}" />
				<c:param name="c_n" value="${param.c_n}" />
				<c:param name="c_pn" value="${param.c_pn}" />
				<c:param name="c_p" value="${param.c_p}" />
				<c:param name="wi" value="${param.wi}" />
				<c:param name="c_b" value="${param.c_b}" />
				<c:param name="c_c" value="${param.c_c}" />
				<c:param name="c_m" value="${param.c_m}" />
				<c:param name="c_cc" value="${param.c_cc}" />
				<c:param name="c_s" value="${param.c_s}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_r" value="${param.c_r}" />
				<c:param name="q" value="${param.q}" />
				<c:param name="coml" value="${param.coml}" />
				<c:param name="modify_date" value="${param.modify_date}" />
			</c:url>
			<a href="${nextPageUrl}"><button>&gt;</button></a>

			<!-- >> 버튼 (마지막 페이지로 이동) -->
			<c:url var="lastPageUrl" value="vendor">
				<c:param name="page" value="${lastPage}" />
				<c:param name="c_y" value="${param.c_y}" />
				<c:param name="c_w" value="${param.c_w}" />
				<c:param name="c_n" value="${param.c_n}" />
				<c:param name="c_pn" value="${param.c_pn}" />
				<c:param name="c_p" value="${param.c_p}" />
				<c:param name="wi" value="${param.wi}" />
				<c:param name="c_b" value="${param.c_b}" />
				<c:param name="c_c" value="${param.c_c}" />
				<c:param name="c_m" value="${param.c_m}" />
				<c:param name="c_cc" value="${param.c_cc}" />
				<c:param name="c_s" value="${param.c_s}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_r" value="${param.c_r}" />
				<c:param name="q" value="${param.q}" />
				<c:param name="coml" value="${param.coml}" />
				<c:param name="modify_date" value="${param.modify_date}" />
			</c:url>
			<a href="${lastPageUrl}"><button>&gt;&gt;</button></a>
		</div>
</body>

</html>