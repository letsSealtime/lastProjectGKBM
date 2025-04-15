<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹툰연습</title>
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

.buttons {
	padding: 10px 15px;
	background-color: #4a90e2;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.buttons:hover {
	background-color: #0056b3;
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

}
.active {
	background-color: #0056b3;
}

span {
	color: red;
}
</style>
</head>
<body>
	<h1>◎ 상품정보관리</h1>
	<span>* 모두 기입</span>
	<form method="post" action="p_sku" class="form">
		<div class="form-fields">
			<div class="form-row">
				<label for="상품코드">상품코드<span>*</span></label> <input type="text"
					name="sku_code" value="${select20.sku_code}"> <label
					for="상품명">상품명<span>*</span></label> <input type="text"
					name="sku_name" value="${select20.sku_name}">
			</div>
			<div class="form-row">
				<label for="규격">규격<span>*</span></label> <input type="text"
					name="sku_size" value="${select20.sku_size}"> <label
					for="업체명">업체명<span>*</span></label> <input type="text"
					name="vendor_name" value="${select20.vendor_name}">
			</div>
			<div class="form-row">
				<label for="단가">단가<span>*</span></label> <input type="text"
					name="price" value="${select20.price}"> <label for="제품분류">제품분류<span>*</span></label>
				<input type="text" name="sku_category"
					value="${select20.sku_category}">
			</div>

			<div class="form-row">
				<label for="sku_code">상품 코드로 조회</label> <input type="text"
					name="sku_code" value="${select20.sku_code}">
			</div>


		</div>

		<div>
			<input type="submit" value="등록" class="buttons"> 
			<button type="button" class="buttons" onclick="searchBySkuCode()">조회</button>
			<button type="button" class="buttons" id="editSelectedButton">수정</button>
			<button type="button" class="buttons" onclick="submitDelete()">삭제</button>

		</div>
		
	</form>
	
	

	

	<form method="get" action="p_sku2">
		<table border="1">
			<thead>
				<tr>
					<th>No.</th>
					<th>checkbox</th>
					<th>상품고유번호</th>
					<th>상품코드</th>
					<th>상품명</th>
					<th>규격</th>
					<th>업체명</th>
					<th>단가</th>
					<th>등록날짜</th>
					<th>수정날짜</th>
					<th>제품분류</th>
				</tr>
			</thead>
			<tbody></tbody>
			<c:forEach var="skuDTO" items="${list}" varStatus="loop">
				<tr>
					<td>${loop.count}</td>
					<td><input type="checkbox" name="empnos" value="${skuDTO.sku_id}"></td>
					<td>${skuDTO.sku_id}</td>
					<td>${skuDTO.sku_code}</td>
					<td>${skuDTO.sku_name}</td>
					<td>${skuDTO.sku_size}</td>
					<td>${skuDTO.vendor_name}</td>
					<td>${skuDTO.price}</td>
					<td>${skuDTO.create_date}</td>
					<td>${skuDTO.modify_date}</td>
					<td>${skuDTO.sku_category}</td>


				</tr>
			</c:forEach>
			</tbody>
		</table>
	</form>

	<!-- 여기에 JS로 checkbox 값들이 동적으로 들어감 -->
	<!-- 그냥 체크박스에 체크하면 여기로 들어가고 삭제누르면 거기로 넘어감 -->
	<!-- 그래서 안에 아무것도 안넣음 -->
	<form id="deleteForm" method="post" action="p_skuDelete"></form>

	<!-- 여긴 페이지넘기는곳 -->
	<div>
		<a href="emp5?page=1">1</a> <a href="emp5?page=2"><strong>2</strong></a>
		<a href="emp5?page=3">3</a>
	</div>


	<script>
	// 삭제
    function submitDelete() {
        const checkboxes = document.querySelectorAll('input[name="empnos"]:checked');
        if (checkboxes.length === 0) {
            alert("삭제할 항목을 선택하세요.");
            return;
        }

        const form = document.getElementById("deleteForm");
        form.innerHTML = ""; // 기존 내용 제거

        checkboxes.forEach(cb => {
            const hidden = document.createElement("input");
            hidden.type = "hidden";
            hidden.name = "sku_id";
            hidden.value = cb.value;
            form.appendChild(hidden);
        });

        form.submit();
    }
	
	
   
</script>


</body>
</html>