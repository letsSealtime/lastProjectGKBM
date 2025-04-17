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
	window.addEventListener("DOMContentLoaded", init)

	function init() {

		let data = {

			load : "load"

		}

		let load = new URLSearchParams(data).toString();

		let xhr = new XMLHttpRequest();

		xhr.open("POST", "work", true);
		xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhr.send(load);

		xhr.onload = function() {
			console.log("Response:", xhr.responseText);

			let json = JSON.parse(xhr.responseText);
			
			console.log(json);
			
			let year = document.querySelector("#c_y");
			let week = document.querySelector("#c_w");
					
			json.forEach((value) => {
				let option_1 = document.createElement("option");
				let option_2 = document.createElement("option");
				
				option_1.setAttribute("value", value.year);
				option_1.innerText = value.year;
				year.append(option_1)
				option_2.setAttribute("value", value.week);
				option_2.innerText = value.week;
				week.append(option_2)
				
			});
			

		};

		let year = document.querySelector("#c_y");
		let week = document.querySelector("#c_w");

		let year_selected = false;
		let week_selected = false;
		
		year.addEventListener("change", (event) => {
			
			let name = document.querySelector("#c_n");
			
			name.innerHTML = "<option value=''></option>"
			
			year_selected = true;
			
			if(year_selected && week_selected) {

				const formData = new FormData(document.querySelector("form"));
				
				const url = new URLSearchParams(formData);
				
				let xhr = new XMLHttpRequest();

				xhr.open("POST", "work", true);
				xhr.setRequestHeader("Content-Type",
						"application/x-www-form-urlencoded");
				xhr.send(url);

				xhr.onload = function() {
					console.log("Response:", xhr.responseText);

					let json = JSON.parse(xhr.responseText);
					
					console.log(json);
					
					let name = document.querySelector("#c_n");
					
					json.forEach((value) => {
						let option = document.createElement("option");
						
						option.setAttribute("value", value.sku_name);
						option.innerText = value.sku_name;
						name.append(option)
						
					});		
				};	
			};
		});
		
		week.addEventListener("change", (event) => {
			
			let name = document.querySelector("#c_n");
			
			name.innerHTML = "<option value=''></option>"
			
			week_selected = true;
			
			if(year_selected && week_selected) {

				const formData = new FormData(document.querySelector("form"));
				
				const url = new URLSearchParams(formData);
				
				let xhr = new XMLHttpRequest();

				xhr.open("POST", "work", true);
				xhr.setRequestHeader("Content-Type",
						"application/x-www-form-urlencoded");
				xhr.send(url);

				xhr.onload = function() {
					console.log("Response:", xhr.responseText);

					let json = JSON.parse(xhr.responseText);
					
					console.log(json);
					let name = document.querySelector("#c_n");
					
					json.forEach((value) => {
						let option = document.createElement("option");
						
						option.setAttribute("value", value.sku_name);
						option.innerText = value.sku_name;
						name.append(option)
						
					});	
						
				};
					
			};
		});
		
		// 상품 선택하면 선택된 상품에 맞는 값 가져오기
		let name = document.querySelector("#c_n");
		name.addEventListener("change", (event) => {
			
			let id = document.querySelector("#c_pn");
			
			id.innerHTML = "<option value=''></option>"

			const formData = new FormData(document.querySelector("form"));
			
			const url = new URLSearchParams(formData);
			
			let xhr = new XMLHttpRequest();

			xhr.open("POST", "work", true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.send(url);

			xhr.onload = function() {
				console.log("Response:", xhr.responseText);

				let json = JSON.parse(xhr.responseText);
				
				console.log(json);
				let number = document.querySelector("#c_pn");
				
				json.forEach((value) => {
					let option = document.createElement("option");
					
					option.setAttribute("value", value.plan_id);
					option.innerText = value.plan_id;
					number.append(option)
					
				});			
			};
		});
		
		// 생산계획번호 선택시 그 계획 번호에 맞는 값을 가져와 밑의 칸에 기입
		let id = document.querySelector("#c_pn");
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

			const formData = new FormData(document.querySelector("form"));
			
			const url = new URLSearchParams(formData);
			
			let xhr = new XMLHttpRequest();

			xhr.open("POST", "work", true);
			xhr.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhr.send(url);

			xhr.onload = function() {
				console.log("Response:", xhr.responseText);

				let json = JSON.parse(xhr.responseText);
				
				console.log(json);
				
				json.forEach((value) => {

					plan_id.value = value.plan_id;
					bom_id.value = value.bom;
					sku_code.value = value.sku_code;
					sku_name.value = value.sku_name;
					plan_count.value = value.plan_count;
					plan_sum.value = value.plan_s;
					
					console.log(plan_count.value);
					
					self.addEventListener("change", (event) => {
						console.log(self.value);
						const insert = document.querySelector("#insert");
						console.log("insert 버튼 확인" + insert)
						let count = value.plan_count - value.plan_s;
						if ( self.value > count ) {
							remain.value = count;
							insert.classList.add("none")
						} else {
							console.log("수량 올바르게 기입")
							remain.value = count;
							insert.classList.remove("none")
						}

					});
				});			
			};
		});
		
		const hidden = document.querySelector("#hidden");
		
		const insert = document.querySelector("#insert");
		insert.addEventListener("click", function(event) {
			// 페이지 넘어감 방지
			event.preventDefault();
			// 버튼이 4개 있어 작동되는 버튼 구분을 위한 hidden타입 value 기입
			hidden.value = "insert";
			
			let data = new FormData(document.querySelector("#form"))
			console.log(data);
			
			let query = new URLSearchParams(data);
			console.log(query);
			
			// for~in으로 data객체의 값을 꺼낼 수 있으나
			// 저장된 값이 아닌 data에 있는 함수들을 꺼낼 수 있음
			/* for(let key in data) {
				console.log("data: " + data[key]);
				console.log("key: " + key);
				if(!data[key]) {
					alert("필수 값을 모두 넣어주세요.");
					return;
				}
			} */
			
			// js에서 form요소의 공백 및 null 미기입 확인
			for(let [key, value] of query) {
				console.log(key);
				console.log(value);
				if((!value && key === "c_y") || (!value && key === "c_w") || (!value && key === "c_n") || (!value && key === "c_pn")) {
					alert("필수 기입값을 모두 기입해주세요.");
					return;
				}
			};
			
			let xhr = new XMLHttpRequest();
			
			xhr.open("POST", "work", true);
			//xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhr.send(query);
			
			console.log("중간 확인");
			xhr.onreadystatechange = () => {
				if(xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
					
					try {
						let json = JSON.parse(xhr.responseText);
						
						console.log(xhr.responseText);
						//console.log(json);
						document.getElementById('check').innerText = json.error;
							
						console.log(hidden.value);
							
					} catch(e) {
						console.log(hidden.value);

						const searchButton = document.querySelector("#search");
						searchButton.click();
						
					}
					
				};
			};
		});
		
		const search = document.querySelector("#search");
		search.addEventListener("click", () => {
			hidden.value = "search";
		});
		
		const all_check = document.querySelector("#checkbox");
		let check = document.querySelectorAll("#table-body input[type='checkbox']");
		all_check.addEventListener("click", () => {
			
			check.forEach(function(c) {
				c.checked = all_check.checked
			})
		})
		
		
		check.forEach(function(c) {
			c.addEventListener("click", () => {
				if (c.checked == false) {
					all_check.checked = false;
				}
				
				let flag = true;
				if (c.checked == true) {
					check.forEach(function(value) {
						if (value.checked == false) {
							console.log("실패")
							all_check.checked = false;
							flag = false;
						} else if (flag) {
							console.log("성공")
							all_check.checked = true;
						}
					})
				}
			})
		});
		
		const btn = document.querySelectorAll(".btn")
		btn.forEach(function(btn_) {
			btn_.addEventListener("click", function() {
				event.preventDefault();
				let value = btn_.closest("tr").querySelector(".un").value
				let id = btn_.closest("tr").querySelector("#wi").value
				
				console.log(id[2]);
				
				console.log(value);
				
				hidden.value = "defect";
				
				console.log(hidden.value)
				
				let data = new FormData()
				data.append("value", value)
				data.append("hidden", "defect")
				data.append("id", id)
				console.log(data);
				
				let query = new URLSearchParams(data);
				console.log(query);

				let xhr = new XMLHttpRequest();
				
				xhr.open("POST", "work", true);
				//xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhr.send(query);
				
				console.log("중간 확인");
				xhr.onreadystatechange = () => {
					if(xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
						try {
							let json = JSON.parse(xhr.responseText);
							
							console.log(xhr.responseText);
							//console.log(json);
							document.getElementById('check').innerText = json.error;
								
							console.log(hidden.value);
								
						} catch(e) {
							console.log(hidden.value);

							const searchButton = document.querySelector("#search");
							searchButton.click();
							
						}
					};
				};
			
			})		
		})

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
							<option value=""></option>
						</select>
					</div>
					<div class="form-column select">
						주차<span>*</span> <select id="c_w" name="c_w">
							<option value=""></option>
						</select>
					</div>
					<div class="form-column select">
						상품<span>*</span> <select id="c_n" name="c_n">
							<option value=""></option>
						</select>
					</div>
					<div class="form-column select">
						번호<span>*</span> <select id="c_pn" name="c_pn">
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
						<th><input type="checkbox" id="checkbox"></th>
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
					<c:if test="${not empty resultset}">
						<c:forEach var="list" items="${ resultset }">

							<tr data=${ list.work_id }>
								<td><input type="checkbox" id="wi" name="box"
									value=${ list.work_id }></td>
								<td>${ list.date }</td>
								<td>${ list.plan_id }</td>
								<td>${ list.sku_name }</td>
								<td>${ list.sku_code }</td>
								<td>${ list.plan_count }</td>
								<td>${ list.qnt }</td>
								<td><input type="number" class="un" name="un" value=""></td>
								<c:choose>
									<c:when test="${list.coml eq 'Y'}">
										<td>완료</td>
									</c:when>
									<c:otherwise>
										<td><button type="button" class="btn" name="btn"
												value="${ list.work_id }">기입</button></td>
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
</body>

</html>