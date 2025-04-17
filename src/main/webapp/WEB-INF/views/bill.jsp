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
}

.form-column {
	flex: 1 1 calc(33% - 20px)
}

.form-row .buttons {
	margin-left: auto;
	/* 오른쪽으로 정렬 */
	display: flex;
	flex-direction: column;
	/* 세로 정렬 */
	gap: 10px;
	/* 버튼 간 간격 */
}

label {
	min-width: 60px;
}

input {
	padding: 5px;
	border: 1px solid black;
	border-radius: 5px;
}

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
</style>

<script>
	window.addEventListener("DOMContentLoaded", init)

	function init() {

		/* function date() {
			let date = new Date();
			const yyyy = date.getFullYear();
			const mm = String(date.getMonth() + 1).padStart(2, '0');
			const dd = String(date.getDate()).padStart(2, '0');
			
			console.log(yyyy);
			console.log(mm);
			console.log(dd);

			const formattedDate = yyyy + "-" + mm + "-" + dd;
			console.log(formattedDate)
			document.getElementById('c_d').value = formattedDate;
		}

		date(); */
		
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
				if((!value && key === "c_d") || (!value && key === "c_q") || (!value && key === "c_b") || (!value && key === "c_a")) {
					alert("필수 기입값을 모두 기입해주세요.");
					return;
				}
			};
			
			let xhr = new XMLHttpRequest();
			
			xhr.open("POST", "bill", true);
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
		})
		
		const delet = document.querySelector("#delet");
		delet.addEventListener("click", (event) => {
			event.preventDefault();
			
			hidden.value = "delet";
			
			console.log("delet 클릭");
			
			let data = new FormData(document.querySelector("#form"))
			let query = new URLSearchParams(data);
			
			let xhr = new XMLHttpRequest();
			xhr.open("POST", "bill", true);
			xhr.send(query);
			
			xhr.onreadystatechange = () => {
				if(xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
					console.log(xhr.responseText);
					
					try {
						let json = JSON.parse(xhr.responseText);
						
						console.log(xhr.responseText);
							
						console.log(hidden.value);
							
					} catch(e) {
						console.log(hidden.value);

						const searchButton = document.querySelector("#search");
						searchButton.click();
						
					}
					
				};
			};
		})
		
		const update = document.querySelector("#update")
		update.addEventListener("click", (event) => {
			event.preventDefault();
			
			const input = document.querySelectorAll("input[type='checkbox']:checked")
			if (input.length > 1 || input.length == 0) {
				alert("수정할 항목을 1가지만 선택해주세요.")
			} else {
				
				const td = document.querySelectorAll("tr[data='"+input[0].value+"'] td")
				
				console.log(input[0].value);
				
				console.log(td);
				console.log(td[2]);
				
				const c_i = document.querySelector("#c_i");
				c_i.value = td[5].innerText
				const c_d = document.querySelector("#c_d");
				c_d.value = td[1].innerText;
				const c_c = document.querySelector("#c_c");
				c_c.value = td[2].innerText
				c_c.setAttribute("readonly", "readonly")
				const c_b = document.querySelector("#c_b");
				c_b.value = td[4].innerText
				const c_q = document.querySelector("#c_q");
				c_q.value = td[3].innerText
				const c_a = document.querySelector("#c_a");
				c_a.value = td[9].innerText
			
				const form = document.querySelector(".form-row.second")
				form.classList.toggle("none");
				
				const parent = document.querySelector(".form")
				const div = document.createElement("div")
				parent.append(div)
				div.classList.add("form-row")
				const button = document.createElement("button")
				const button_2 = document.createElement("button")
				button.classList.add("buttons")
				button.classList.add("button_1")
				button_2.classList.add("buttons")
				button_2.classList.add("button_2")
				button.type = "button"
				button_2.type = "button"
				button.textContent = "수정완료"
				button_2.textContent = "수정취소"
				div.append(button)
				div.append(button_2)
				
				button_2.addEventListener("click", () => {
					form.classList.toggle("none");
					div.remove();
					input[0].checked = false;
					
					c_d.value = ""
					c_c.value = ""
					c_q.value = ""
					c_b.value = ""
					c_p.value = ""
					c_i.value = ""
					c_i.removeAttribute("readonly")
					c_n.value = ""
					c_p.value = ""
					c_j.value = ""
					c_a.value = ""
				})
				
				button.addEventListener("click", () => {
					
					hidden.value = "update";
					
					let data = new FormData(document.querySelector("#form"));
					
					let query = new URLSearchParams(data);
					
					form.classList.toggle("none");
					div.remove();
					input[0].checked = false;
					
					c_d.value = ""
					c_c.value = ""
					c_q.value = ""
					c_b.value = ""
					c_p.value = ""
					c_i.value = ""
					c_i.removeAttribute("readonly")
					c_n.value = ""
					c_p.value = ""
					c_j.value = ""
					c_a.value = ""
					
					let xhr = new XMLHttpRequest();
					xhr.open("POST", "bill", true);
					xhr.send(query);
					
					xhr.onreadystatechange = () => {
						if(xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
							
							try {
								let json = JSON.parse(xhr.responseText);
									
								console.log(hidden.value);
									
							} catch(e) {
								console.log(hidden.value);

								const searchButton = document.querySelector("#search");
								searchButton.click();
								
							}
							
						};
					};
					
				})
				
			}
					
		})

	}
</script>

</head>

<body>
	<div class="container">
		<h1>◎ 거래명세서 관리</h1>

		<!-- 입력할곳 및 등록, 조회, 수정, 삭제버튼 -->
		<span>* 모두 기입</span>
		<form id="form" method="get" action="bill">
			<div class="form">
				<div class="form-row">
					<div class="form-column">
						<label for="c_d">날짜<span>*</span></label><input
							style="width: 150px;" type="date" id="c_d" value="" name="c_d">
					</div>
					<div class="form-column">
						<label for="c_c">등록번호</label> <input style="width: 150px;"
							type="text" id="c_c" name="c_c">
					</div>
					<div class="form-column">
						<label for="c_q">수량<span>*</span></label> <input type="text"
							id="c_q" name="c_q">
					</div>
					<div class="form-column">
						<label for="c_b">가격<span>*</span></label> <input type="text"
							id="c_b" name="c_b">
					</div>
					<div class="form-column">
						<label for="c_m">상품번호<span>*</span></label> <input type="text"
							id="c_i" name="c_i">
					</div>
					<div class="form-column">
						<label for="c_n">공급자</label> <input type="text" id="c_n"
							name="c_n">
					</div>
					<div class="form-column">
						<label for="c_p">연락처</label> <input type="text" id="c_p"
							name="c_p">
					</div>
					<div class="form-column">
						<label for="c_j">주소</label> <input type="text" id="c_j" name="c_j">
					</div>

					<div class="form-column">
						진행사항<span>*</span> <select id="c_a" name="c_a">
							<option value=""></option>
							<option value="발행">발행</option>
							<option value="승인">승인</option>
							<option value="진행중">진행중</option>
							<option value="인수완료">인수완료</option>
							<option value="대금결제">대금결제</option>
						</select>
					</div>
				</div>
				<div class="form-row second">
					<div class="buttons">
						<input type="hidden" id="hidden" name="hidden" value="search">
						<button type="submit" id="insert">등록</button>
						<button type="submit" id="search">조회</button>
						<button type="submit" id="update">수정</button>
						<button type="submit" id="delet">삭제</button>
						<c:if test="${ lu eq 2 }">
							<input type="hidden" id="hidden" name="hidden" value="search">
							<button type="submit" id="search">조회</button>
						</c:if>
						<c:if test="${ lu eq 1 }">
							<input type="hidden" id="hidden" name="hidden" value="search">
							<button type="submit" id="insert">등록</button>
							<button type="submit" id="search">조회</button>
							<button type="submit" id="update">수정</button>
							<button type="submit" id="delet">삭제</button>
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
						<th>날짜</th>
						<th>등록번호</th>
						<th>수량</th>
						<th>가격</th>
						<th>상품번호</th>
						<th>공급자</th>
						<th>연락처</th>
						<th>주소</th>
						<th>진행사항</th>
					</tr>
				</thead>

				<!-- 데이터가 추가됩니다 -->
				<tbody id="table-body">
					<c:if test="${not empty resultset}">
						<c:forEach var="list" items="${ resultset }">

							<tr data=${ list.c_c }>
								<td><input type="checkbox" name="box" value=${ list.c_c }>
								</td>
								<td>${ list.c_d }</td>
								<td>${ list.c_c }</td>
								<td>${ list.c_q }</td>
								<td>${ list.c_b }</td>
								<td>${ list.c_i }</td>
								<td>${ list.c_n }</td>
								<td>${ list.c_p }</td>
								<td>${ list.c_j }</td>
								<td>${ list.c_a }</td>
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