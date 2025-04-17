<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	color: red;
}
</style>

<script>

window.addEventListener("load", init)

function init() {
	
let insert = document.querySelector("#insert");
insert.addEventListener("click", (event) => {
	let button = document.querySelector("#hidden")
	button.value = "insert";
	
	event.preventDefault();
	
	let input = document.querySelectorAll(".form-row input[type='text']")
	let flag = true;
	
	console.log(input);
	
	for (let i = 0; input.length > i; i++) {
		if(input[i].value === "") {
			flag = false;		
		}
	}
	
	if(!flag) {
		alert("필수 기입 사항을 모두 기입해주세요.")
	}
	
	let xhr = new XMLHttpRequest();
	xhr.open("POST", "/second_project/company", true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
	let data = new FormData(document.querySelector("form"));
	let query = new URLSearchParams(data).toString();
	
	console.log(data);
	console.log(data.entries());
	
	xhr.send(query);
	
	xhr.onreadystatechange = () => {
		if(xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
			console.log("서버 응답:", xhr.responseText);
			
			let json;
			
			try {
				json = JSON.parse(xhr.responseText);				
			} catch(e) {
				document.querySelector("#check").innerText = "json 변환 오류 발생";
				return
			}
			
			if(json.error) {
				document.querySelector("#check").innerText = json.error;
			} else {
				document.querySelector("#check").innerText = "";
				document.querySelector("#table-body").innerHTML += json.html;				
			}
			
		}
	}
	
});
	
}

</script>

</head>

<body>
	<div class="container">
		<h1>◎ 거래처 정보관리</h1>

		<!-- 입력할곳 및 등록, 조회, 수정, 삭제버튼 -->
		<form method="post" action="">
			<span>* 모두 기입</span>
			<div class="form">
				<div class="form-row">
					<div class="form-column">
						<label for="c_c">업체코드<span>*</span></label> <input
							style="width: 150px;" type="text" id="c_c" name="c_c">
					</div>
					<div class="form-column">
						<label for="c_n">업체명<span>*</span></label> <input type="text"
							id="c_n" name="c_n">
					</div>
					<div class="form-column">
						<label for="c_m">담당자<span>*</span></label> <input type="text"
							id="c_m" name="c_m">
					</div>
					<div class="form-column">
						<label for="c_p">연락처<span>*</span></label> <input type="text"
							id="c_p" name="c_p">
					</div>
					<div class="form-column">
						<label for="c_a">주소<span>*</span></label> <input type="text"
							id="c_a" name="c_a">
					</div>
					<div class="form-column">
						종류<span>*</span> <select name="select">
							<option value="material">원자재</option>
							<option value="product">완제품</option>
						</select>
					</div>
				</div>
				<div class="form-row">
					<div class="buttons">
						<input id="hidden" type="hidden" name="button" value="">
						<button id="insert" name="button" value="insert">등록</button>
						<button id="search" name="button" value="search">조회</button>
						<button id="update" name="button" value="update">수정</button>
						<button id="delete" name="button" value="delete">삭제</button>
					</div>
				</div>
			</div>
		</form>
		<!-- 내가 체크한것들을 조회버튼을 누르면 추출 -->
		<div id="check"></div>

		<!-- 입력한것을 등록할때 뭐인지 보여줄 칸 -->
		<table id="table">
			<thead>
				<tr>
					<th><input type="checkbox" id="checkbox"></th>
					<th>순번</th>
					<th>업체코드</th>
					<th>업체명</th>
					<th>담당자</th>
					<th>연락처</th>
					<th>주소</th>
					<th>종류</th>
				</tr>
			</thead>

			<!-- 데이터가 추가됩니다 -->
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
</body>

</html>