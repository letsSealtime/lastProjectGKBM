<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품정보관리</title>
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
				<label for="sku_code">상품 코드로 조회</label> 
				<input type="text" id="skuCodeInput" name="sku_code">
			</div>


		</div>

		<div>
		<!-- onclick="setFormAction('insert')" -->
			<!-- 기존 버튼들 -->
			<input type="submit" value="등록" class="buttons" id="insertBtn"> </br>
			<button type="button" class="buttons" onclick="searchBySkuCode()" id="searchBtn">조회</button></br>
			<button type="button" class="buttons" id="editSelectedButton" onclick="handleEdit()">수정</button></br>
			<button type="button" class="buttons" onclick="submitDelete()" id="deleteBtn">삭제</button></br>
			
			<!-- 수정 모드 버튼 -->
			 <input type="submit" value="수정완료" class="buttons" 
			id="updateBtn" style="display:none;" onclick="setFormAction('update')"></br>
			<button type="button" class="buttons" id="cancelUpdateBtn" 
			style="display:none;" onclick="cancelUpdate()">수정취소</button> 

		</div>
		
	</form>
	
	

	<!-- 이건 부분조회 -->
	<!-- /searchBySkuCode -->
	<form method="get" action="p_sku2">
		<table border="1">
			<thead>
				<tr>
					<th>checkbox</th>
					<th>No.</th>
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
			<tbody>
			<c:forEach var="skuDTO" items="${list}" varStatus="loop">
				<tr>
					<td><input type="checkbox" name="empnos" value="${skuDTO.sku_id}"></td>
					<td>${loop.count}</td>
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
        <div class="pagination">
    <!-- 왼쪽 방향 버튼 -->
    <c:if test="${currentPage > 1}">
        <form method="get" >
            <input type="hidden" name="currentPage" value="${currentPage - 1}" />
            <input type="hidden" name="sku_code" value="${skuDTO.sku_code}" />
            <button type="submit">&lt;</button>
        </form>
    </c:if>

    <!-- 페이지 번호 버튼 -->
    <!-- allpages는 1입니다 -->
    <c:forEach var="allpages" begin="1" end="${totalPages}">
        <form method="get" >
            <input type="hidden" name="currentPage" value="${allpages}" />
            <input type="hidden" name="sku_code" value="${skuDTO.sku_code}" />
            <button type="submit"
                    style="${allpages == currentPage ? 'font-weight:bold; background-color:#eee;' : ''}">
                ${allpages}
            </button>
        </form>
    </c:forEach>

    <!-- 오른쪽 방향 버튼 -->
    <c:if test="${currentPage < totalPages}">
        <form method="get">
            <input type="hidden" name="currentPage" value="${currentPage + 1}" />
            <input type="hidden" name="sku_code" value="${skuDTO.sku_code}" />
            <button type="submit">&gt;</button>
        </form>
    </c:if>
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
	
	// 조회
     function searchBySkuCode() {
    	 const skuCode = document.getElementById("skuCodeInput").value.trim(); // 공백 제거

    	    if (skuCode == "") {
    	        // 아무것도 입력 안 했을 때 → 전체 조회
    	        location.href = "p_sku2"; 
    	    } else {
    	        // sku_code 값으로 조회
    	        location.href = "p_sku2?sku_code=" + encodeURIComponent(skuCode); 
    	    }
    	 
    		/*  // 조회 후 입력란을 비우기
    	    skuCodeInput.value = "";  */
    	}
	
  	 // 수정 버튼 클릭 시 - 체크된 항목의 데이터를 입력란에 채우고 버튼 상태 변경
     function handleEdit() {
         const selected = document.querySelectorAll('input[name="empnos"]:checked');
         if (selected.length !== 1) {
             alert("수정할 항목을 하나만 선택하세요.");
             return;
         }

         // 기존 버튼 숨기기
         document.getElementById("insertBtn").style.display = "none";
         document.getElementById("searchBtn").style.display = "none";
         document.getElementById("editSelectedButton").style.display = "none";
         document.getElementById("deleteBtn").style.display = "none";

         // 수정완료/취소 버튼 보이기
         document.getElementById("updateBtn").style.display = "inline-block";
         document.getElementById("cancelUpdateBtn").style.display = "inline-block";

         // 선택된 항목의 데이터를 입력란에 넣기
         const checked = selected[0];
         const row = checked.closest("tr");
         const cells = row.querySelectorAll("td");

         document.querySelector('input[name="sku_code"]').value = cells[3].textContent.trim();
         document.querySelector('input[name="sku_name"]').value = cells[4].textContent.trim();
         document.querySelector('input[name="sku_size"]').value = cells[5].textContent.trim();
         document.querySelector('input[name="vendor_name"]').value = cells[6].textContent.trim();
         document.querySelector('input[name="price"]').value = cells[7].textContent.trim();
         document.querySelector('input[name="sku_category"]').value = cells[10].textContent.trim();

         // 숨겨진 sku_id 필드 처리 (없으면 생성해서 폼에 추가)
         let hidden = document.querySelector('input[name="sku_id"]');
         if (!hidden) {
             hidden = document.createElement("input");
             hidden.type = "hidden";
             hidden.name = "sku_id";
             document.querySelector("form.form").appendChild(hidden);
         }
         hidden.value = cells[2].textContent.trim();
     }

     // 수정취소 버튼 클릭 시 - 입력란 초기화 및 버튼 상태 원래대로
     function cancelUpdate() {
         // 기존 버튼 보이기
         document.getElementById("insertBtn").style.display = "inline-block";
         document.getElementById("searchBtn").style.display = "inline-block";
         document.getElementById("editSelectedButton").style.display = "inline-block";
         document.getElementById("deleteBtn").style.display = "inline-block";

         // 수정완료/취소 버튼 숨기기
         document.getElementById("updateBtn").style.display = "none";
         document.getElementById("cancelUpdateBtn").style.display = "none";

         // 입력란 초기화
         document.querySelector('input[name="sku_code"]').value = "";
         document.querySelector('input[name="sku_name"]').value = "";
         document.querySelector('input[name="sku_size"]').value = "";
         document.querySelector('input[name="vendor_name"]').value = "";
         document.querySelector('input[name="price"]').value = "";
         document.querySelector('input[name="sku_category"]').value = "";

         // 숨겨진 sku_id 필드 제거
         const hidden = document.querySelector('input[name="sku_id"]');
         if (hidden) {
             hidden.remove();
         }
     }

     // 폼 액션 설정 및 전송 - insert or update 시 사용
     function setFormAction(action) {
         const form = document.querySelector("form.form");
         form.action = "udpateList"; // 예: "insert", "update" 같은 URL로 설정
         form.submit();
     }
 
   
</script>


</body>
</html>