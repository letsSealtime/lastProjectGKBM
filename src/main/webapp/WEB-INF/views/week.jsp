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
<title>Week</title>
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

.select select {
	width: 100%; /* 부모 크기에 맞게 */
	padding: 8px;
	border: 1px solid #ccc; /* 기본 테두리 */
	border-radius: 5px; /* 둥근 모서리 */
	background: #fff; /* 흰색 배경 */
	color: #333; /* 텍스트 색상 */
	font-size: 14px;
	font-family: Arial, sans-serif; /* 깔끔한 글꼴 */
	appearance: auto; /* 기본 브라우저 화살표 제거 */
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); /* 은은한 그림자 */
	transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.select select:focus {
	outline: none; /* 포커스 시 기본 아웃라인 제거 */
	border-color: #4a90e2; /* 포커스 시 강조 테두리 */
	box-shadow: 0 0 5px rgba(74, 144, 226, 0.5); /* 포커스 시 그림자 강조 */
	background: #fff; /* 포커스 배경 유지 */
}

select option {
	padding: 8px; /* 옵션 간격 */
	font-size: 14px;
	background-color: #fff; /* 옵션 배경 흰색 */
	color: #333; /* 옵션 텍스트 색상 */
	font-family: Arial, sans-serif;
	transition: background-color 0.2s ease, color 0.2s ease;
}

/* Hover 스타일 (일부 브라우저 지원) */
select option:hover {
	background-color: #e0e0e0; /* 약간 어두운 배경 */
	color: #333;
}
</style>

<script>
	window.addEventListener("DOMContentLoaded", init)

	function init() {

		const hidden = document.querySelector("#hidden");
		
		const insert = document.querySelector("#insert");
		insert.addEventListener("click", function(event) {
			// 페이지 넘어감 방지
			event.preventDefault();
			// 버튼이 4개 있어 작동되는 버튼 구분을 위한 hidden타입 value 기입
			hidden.value = "insert";
			
			let data = {
			        c_i: document.querySelector("#c_i").value,
			        c_y: document.querySelector("#c_y").value,
			        c_w: document.querySelector("#c_w").value,
			        c_c: document.querySelector("#c_c").value,
			        c_k: document.querySelector("#c_k").value
			};
			
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
		for(let key in data) {
			console.log(key);
			if(!data.c_c || !data.c_k) {
				alert("필수 기입값을 모두 기입해주세요.");
				return;
			}
		};
			
			let xhr = new XMLHttpRequest();
			
			xhr.open("PUT", "week");
			xhr.setRequestHeader("Content-type", "application/json");
			document.querySelector("#c_c").innerText = ""
	        document.querySelector("#c_k").innerText = ""
			xhr.send(JSON.stringify(data));
			
			console.log("중간 확인");
			xhr.onreadystatechange = () => {
				if(xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
					
					try {
						let json = JSON.parse(xhr.responseText);
						
						console.log(xhr.responseText);
						//console.log(json);
						document.getElementById('check').innerText = json.error;
						
						const searchButton = document.querySelector("#search");
						searchButton.click();
							
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
		
		
		const delet = document.querySelector("#delet");
		delet.addEventListener("click", (event) => {
			event.preventDefault();
			
			hidden.value = "delet";
			
			console.log("delet 클릭");
			
			let check = []
			let checkbox = document.querySelectorAll(".check")
			
			console.log(checkbox.length)
			
			for(i = 0; checkbox.length > i; i++) {
				let value = checkbox[i]
				if(value.checked) {
					check.push(value.value);
				}
			}
			
			let query = {
					"check": check
			}
			
			let xhr = new XMLHttpRequest();
			xhr.open("DELETE", "week");
			xhr.setRequestHeader("Content-type", "application/json");
			xhr.send(JSON.stringify(query));
			
			xhr.onreadystatechange = () => {
				if(xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
					console.log(xhr.responseText);
					
					try {
						let json = JSON.parse(xhr.responseText);
						
						console.log(xhr.responseText);
							
						console.log(hidden.value);
						
						const searchButton = document.querySelector("#search");
						searchButton.click();
							
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
				console.log(td[3].innerText);
				console.log(td[5]);
				console.log(td[6]);
				
				const c_i = document.querySelector("#c_i");
				c_i.value = td[1].innerText
				c_i.setAttribute("readonly", "readonly")
				const c_c = document.querySelector("#c_c");
				c_c.value = td[4].innerText	
				const c_k = document.querySelector("#c_k");
				c_k.data = td[7].innerText
				const c_y = document.querySelector("#year");
				c_y.value = td[5].innerText
				const c_w = document.querySelector("#c_w");
				c_w.value = td[6].innerText
			
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
					
					c_i.value = ""
					c_c.value = ""
					c_k.value = ""
					c_y.value = ""
					c_w.value = ""
					c_i.removeAttribute("readonly")
				})
				
				button.addEventListener("click", () => {
					
					hidden.value = "update";
					
					let data = {
						c_c: document.querySelector("#c_c").value,
						c_k: document.querySelector("#c_k").value
					};
					
					form.classList.toggle("none");
					div.remove();
					input[0].checked = false;
					
					c_i.value = ""
					c_c.value = ""
					c_k.value = ""
					c_y.value = ""
					c_w.value = ""
					c_i.removeAttribute("readonly")
					
					let xhr = new XMLHttpRequest();
					xhr.open("POST", "week");
					xhr.setRequestHeader("Content-type", "application/json");
					xhr.send(JSON.stringify(data));
					
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
		<h1>◎ 생산 계획 관리</h1>

		<!-- 입력할곳 및 등록, 조회, 수정, 삭제버튼 -->
		<span>* 모두 기입</span>
		<form id="form" method="get" action="week">
			<div class="form">
				<div class="form-row">
					<div class="form-column">
						<label for="c_i">생산관리계획번호</label><input type="text" id="c_i"
							name="c_i">
					</div>
					<div class="form-column">
						<label for="c_w">주차 생산 수량<span>*</span></label> <input
							type="number" id="c_c" name="c_c">
					</div>
					<div class="form-column select">
						상품코드<span>*</span> <select id="c_k" name="c_k">
							<option></option>
							<c:if test="${not empty list}">
								<c:forEach var="list" items="${ list }">

									<option data=${ list.c_k } value=${ list.c_k }>${ list.c_k }</option>

								</c:forEach>
							</c:if>
						</select>
					</div>
					<div class="form-column select">
						년도
						<%
					Date date = new Date();
					int year = date.getYear() + 1900;
					%>
						<select id="c_y" name="c_y">
							<option value=""></option>
							<option value="<%=year%>"><%=year%></option>
							<option value="<%=year - 1%>"><%=year - 1%></option>
							<option value="<%=year - 2%>"><%=year - 2%></option>
							<option value="<%=year - 3%>"><%=year - 3%></option>
							<option value="<%=year - 4%>"><%=year - 4%></option>
						</select>
					</div>
					<div class="form-column select">
						주차<select id="c_w" name="c_w">
							<option value=""></option>
							<c:forEach var="i" begin="1" end="52">
								<option value="${i}">${i}w</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-row second">
					<div class="buttons">
						<input type="hidden" id="hidden" name="hidden" value="search">
						<button type="button" id="insert">등록</button>
						<button type="submit" id="search">조회</button>
						<button type="button" id="update">수정</button>
						<button type="button" id="delet">삭제</button>
						<c:if test="${ lu eq 2 }">
							<input type="hidden" id="hidden" name="hidden" value="search">
							<button type="submit" id="search">조회</button>
						</c:if>
						<c:if test="${ lu eq 1 }">
							<input type="hidden" id="hidden" name="hidden" value="search">
							<button type="button" id="insert">등록</button>
							<button type="submit" id="search">조회</button>
							<button type="button" id="update">수정</button>
							<button type="button" id="delet">삭제</button>
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
						<th>생상계획번호</th>
						<th>상품명</th>
						<th>상품코드</th>
						<th>주차 생산 수량</th>
						<th>년도</th>
						<th>주차</th>
					</tr>
				</thead>

				<!-- 데이터가 추가됩니다 -->
				<tbody id="table-body">
					<c:if test="${not empty select}">
						<c:forEach var="list" items="${ select }">

							<tr data=${ list.c_i }>
								<td><input class="check" type="checkbox" name="box"
									value=${ list.c_i }></td>
								<td>${ list.c_i }</td>
								<td>${ list.c_n }</td>
								<td>${ list.c_k }</td>
								<td>${ list.c_c }</td>
								<td>${ list.c_y }</td>
								<td>${ list.c_w }</td>
								<td style="display: none;">${ list.c_i }</td>
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
			<c:url var="firstPageUrl" value="week">
				<c:param name="page" value="1" />
				<c:param name="c_i" value="${param.c_i}" />
				<c:param name="c_c" value="${param.c_c}" />
				<c:param name="c_s" value="${param.c_s}" />
				<c:param name="c_y" value="${param.c_y}" />
				<c:param name="c_w" value="${param.c_w}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_n" value="${param.c_n}" />
				<c:param name="c_k" value="${param.c_k}" />
			</c:url>
			<a href="${firstPageUrl}"><button>&lt;&lt;</button></a>

			<!-- < 버튼 (이전 페이지로 이동) -->
			<c:url var="prevPageUrl" value="week">
				<c:param name="page" value="${prevPage}" />
				<c:param name="c_i" value="${param.c_i}" />
				<c:param name="c_c" value="${param.c_c}" />
				<c:param name="c_s" value="${param.c_s}" />
				<c:param name="c_y" value="${param.c_y}" />
				<c:param name="c_w" value="${param.c_w}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_n" value="${param.c_n}" />
				<c:param name="c_k" value="${param.c_k}" />
			</c:url>
			<a href="${prevPageUrl}"><button>&lt;</button></a>

			<!-- 페이지 번호 선택 -->
			<c:choose>
				<c:when test="${ page == pageCount }">
					<c:forEach var="i" begin="${ begin }" end="${ end }">
						<c:choose>
							<c:when test="${ i == page }">
								<strong> <c:url var="currentPageUrl" value="week">
										<c:param name="page" value="${i}" />
										<c:param name="c_i" value="${param.c_i}" />
										<c:param name="c_c" value="${param.c_c}" />
										<c:param name="c_s" value="${param.c_s}" />
										<c:param name="c_y" value="${param.c_y}" />
										<c:param name="c_w" value="${param.c_w}" />
										<c:param name="c_d" value="${param.c_d}" />
										<c:param name="c_n" value="${param.c_n}" />
										<c:param name="c_k" value="${param.c_k}" />
									</c:url> <a style="color: red;" href="${currentPageUrl}"><button>${i}</button></a>
								</strong>
							</c:when>
							<c:otherwise>
								<c:url var="pageUrl" value="week">
									<c:param name="page" value="${i}" />
									<c:param name="c_i" value="${param.c_i}" />
									<c:param name="c_c" value="${param.c_c}" />
									<c:param name="c_s" value="${param.c_s}" />
									<c:param name="c_y" value="${param.c_y}" />
									<c:param name="c_w" value="${param.c_w}" />
									<c:param name="c_d" value="${param.c_d}" />
									<c:param name="c_n" value="${param.c_n}" />
									<c:param name="c_k" value="${param.c_k}" />
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
								<strong> <c:url var="currentPageUrl" value="week">
										<c:param name="page" value="${i}" />
										<c:param name="c_i" value="${param.c_i}" />
										<c:param name="c_c" value="${param.c_c}" />
										<c:param name="c_s" value="${param.c_s}" />
										<c:param name="c_y" value="${param.c_y}" />
										<c:param name="c_w" value="${param.c_w}" />
										<c:param name="c_d" value="${param.c_d}" />
										<c:param name="c_n" value="${param.c_n}" />
										<c:param name="c_k" value="${param.c_k}" />
									</c:url> <a style="color: red;" href="${currentPageUrl}"><button>${i}</button></a>
								</strong>
							</c:when>
							<c:otherwise>
								<c:url var="pageUrl" value="week">
									<c:param name="page" value="${i}" />
									<c:param name="c_i" value="${param.c_i}" />
									<c:param name="c_c" value="${param.c_c}" />
									<c:param name="c_s" value="${param.c_s}" />
									<c:param name="c_y" value="${param.c_y}" />
									<c:param name="c_w" value="${param.c_w}" />
									<c:param name="c_d" value="${param.c_d}" />
									<c:param name="c_n" value="${param.c_n}" />
									<c:param name="c_k" value="${param.c_k}" />
								</c:url>
								<a href="${pageUrl}"><button>${i}</button></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>

			<!-- > 버튼 (다음 페이지로 이동) -->
			<c:url var="nextPageUrl" value="week">
				<c:param name="page" value="${nextPage}" />
				<c:param name="c_i" value="${param.c_i}" />
				<c:param name="c_c" value="${param.c_c}" />
				<c:param name="c_s" value="${param.c_s}" />
				<c:param name="c_y" value="${param.c_y}" />
				<c:param name="c_w" value="${param.c_w}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_n" value="${param.c_n}" />
				<c:param name="c_k" value="${param.c_k}" />
			</c:url>
			<a href="${nextPageUrl}"><button>&gt;</button></a>

			<!-- >> 버튼 (마지막 페이지로 이동) -->
			<c:url var="lastPageUrl" value="week">
				<c:param name="page" value="${lastPage}" />
				<c:param name="c_i" value="${param.c_i}" />
				<c:param name="c_c" value="${param.c_c}" />
				<c:param name="c_s" value="${param.c_s}" />
				<c:param name="c_y" value="${param.c_y}" />
				<c:param name="c_w" value="${param.c_w}" />
				<c:param name="c_d" value="${param.c_d}" />
				<c:param name="c_n" value="${param.c_n}" />
				<c:param name="c_k" value="${param.c_k}" />
			</c:url>
			<a href="${lastPageUrl}"><button>&gt;&gt;</button></a>
		</div>
</body>

</html>