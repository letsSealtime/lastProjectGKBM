 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원자재현황</title>
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
	<h1>◎ 원자재현황</h1>
	<form method="post" action="p_material_in_out_3" class="form">
		<div class="form-fields">
			<div class="form-row">
				<label for="sku_code">상품 코드+ 상품명 으로 조회</label> <input type="text"
					id="skuCodeInput" name="sku_code">
			</div>


		</div>

		<div>
			
			<button type="button" class="buttons" onclick="searchBySkuCode()"
				id="searchBtn">조회</button>
			</br>
		</div>

	</form>



	<!-- 이건 부분조회 -->
	<!-- /searchBySkuCode -->
	<form method="get" action="material_in_out2_3">
		<table border="1">
			<thead>
				<tr>
					<th>checkbox</th>
					<th>No.</th>
					<th>원자재관리번호</th>
					<th>원자재수량</th>
					<th>원자재가격</th>
					<th>상품코드</th>
					<th>상품명</th>
					<th>규격</th>
					<th>분류</th>
					<th>등록날짜</th>
					<th>수정날짜</th>
					<th>비고사항</th>
					<th>상품고유번호</th>
					<th>등록번호</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="mioDTO3" items="${list}" varStatus="loop">
					<tr>
						<td><input type="checkbox" name="empnos"
							value="${mioDTO3.ib_id}"></td>
						<td>${loop.count}</td>
						<td>${mioDTO3.ib_id}</td>
						<td>${mioDTO3.material_count}</td>
						<td>${mioDTO3.material_price}</td>
						<td>${mioDTO3.sku_code}</td>
						<td>${mioDTO3.sku_name}</td>
						<td>${mioDTO3.sku_size}</td> 
						<td>${mioDTO3.sku_type}</td>
						<td>${mioDTO3.create_date}</td>
						<td>${mioDTO3.modify_date}</td>
						<td>${mioDTO3.remarks}</td>
						<td>${mioDTO3.sku_id}</td>
						<td>${mioDTO3.bill_id}</td>


					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>



	<!-- 여긴 페이지넘기는곳 -->
        <div class="pagination">
    <!-- 왼쪽 방향 버튼 -->
    <c:if test="${currentPage > 1}">
        <form method="get" >
            <input type="hidden" name="currentPage" value="${currentPage - 1}" />
            <input type="hidden" name="sku_code" value="${mioDTO3.sku_code}" />
            <button type="submit">&lt;</button>
        </form>
    </c:if>

    <!-- 페이지 번호 버튼 -->
    <!-- allpages는 1입니다 -->
    <c:forEach var="allpages" begin="1" end="${totalPages}">
        <form method="get" >
            <input type="hidden" name="currentPage" value="${allpages}" />
            <input type="hidden" name="sku_code" value="${mioDTO3.sku_code}" />
            <button type="submit">${allpages}</button>
        </form>
    </c:forEach>

    <!-- 오른쪽 방향 버튼 -->
    <c:if test="${currentPage < totalPages}">
        <form method="get">
            <input type="hidden" name="currentPage" value="${currentPage + 1}" />
            <input type="hidden" name="sku_code" value="${mioDTO3.sku_code}" />
            <button type="submit">&gt;</button>
        </form>
    </c:if>
</div>


	<script>
	// 조회
     function searchBySkuCode() {
    	 const skuCode = document.getElementById("skuCodeInput").value.trim(); // 공백 제거

    	    if (skuCode == "") {
    	        // 아무것도 입력 안 했을 때 → 전체 조회
    	        location.href = "material_in_out2_3"; 
    	    } else {
    	        // sku_code 값으로 조회
    	        location.href = "material_in_out2_3?sku_code=" + encodeURIComponent(skuCode); 
    	    }
    	 
    		/*  // 조회 후 입력란을 비우기
    	    skuCodeInput.value = "";  */
    	}
</script>
 
</body>
</html> 