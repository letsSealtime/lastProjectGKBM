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
	font-family: Arial, sans-serif;
}

.container {
	width: 100%;
	margin: auto;
	background: white;
	padding: 20px;
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

input, select {
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

.active {
	background-color: #0056b3;
}

.별 {
	color: red;
}

.seach {
	margin-bottom: 15px;
}

@media screen and (max-width: 800px) {
	.form-row {
		flex-direction: column;
		align-items: stretch;
		gap: 5px !important;
		width: auto;
	}
	.buttons {
		flex-direction: row;
		justify-content: center;
		margin-top: 10px;
	}
	button {
		width: auto;
	}
}
</style>
</head>
<body>
	<div class="container">
		<h1>◎ 소모품 관리</h1>

		<span class="별">* 모두기입</span>

		<!-- 검색 폼 -->
		<form method="get" action="${pageContext.request.contextPath}/p_CMB">
			<span>소모품코드 or 소모품명</span> <input type="text" name="searchKeyword"
				placeholder="검색어를 입력하세요" value="${searchKeyword}"> <input
				type="hidden" name="currentPage" value="1">
			<button type="submit" class="seach">검색</button>
		</form>

		<!-- 등록/수정 폼 -->
		<form method="post" action="p_consumreg" class="form">
			<div class="form-fields">
				<div class="form-row">
					<label for="consumablesCode">소모품코드<span class="별"> *</span></label>
					<input type="text" id="consumablesCode" name="consumables_code"
						value="${dto.consumables_code}" required> <label
						for="manager">담당자<span class="별"> *</span></label> <input
						type="text" id="manager" name="manager" value="${dto.manager}"
						required>
				</div>
				<div class="form-row">
					<label for="createDate">등록일자<span class="별"> *</span></label> <input
						type="date" id="createDate" name="create_date"
						value="${dto.create_date}" required> <label
						for="consumablesName">소모품명<span class="별"> *</span></label> <input
						type="text" id="consumablesName" name="consumables_name"
						value="${dto.consumables_name}" required>
				</div>
				<div class="form-row">
					<label for="p_Con_count">수량<span class="별"> *</span></label> <input
						type="number" id="p_Con_count" name="p_Con_count"
						value="${dto.count}" required> <label for="remarks">비고사항</label>
					<input type="text" id="remarks" name="remarks"
						value="${dto.remarks}">
				</div>

			</div>
			<div class="buttons">
				<button type="button" value="등록" class="buttons insert1">등록</button>
				<button type="button" value="수정" class="buttons update1">수정</button>
				<button type="button" value="삭제" class="buttons delete1">삭제</button>
			</div>
		</form>
	
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>NO.</th>
					<th>소모품코드</th>
					<th>소모품명</th>
					<th>담당자</th>
					<th>등록일자</th>
					<th>수량</th>
					<th>비고사항</th>
				</tr>
			</thead>
			<tbody id="table-body">
				<c:if test="${empty resultList}">
					<tr>
						<td colspan="8">일치되는 항목이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="dto" items="${resultList}" varStatus="loop">
					<tr>
						<td><input type="checkbox" name="check"
							value="${dto.consumables_code}"></td>
						<td>${(currentPage-1) * pageSize + loop.count}</td>
						<td>${dto.consumables_code}</td>
						<td>${dto.consumables_name}</td>
						<td>${dto.manager}</td>
						<td>${dto.create_date}</td>
						<td>${dto.p_Con_count}</td>
						<td>${dto.remarks}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 페이징 영역 -->
		<div class="pagination">
			<%
			int pageBlock = 10;
			int currentPage = Integer.parseInt(String.valueOf(request.getAttribute("currentPage")));
			int totalPages = Integer.parseInt(String.valueOf(request.getAttribute("totalPages")));
			int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > totalPages)
				endPage = totalPages;

			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			%>

			<c:if test="${startPage > 1}">
				<form method="get" style="display: inline;">
					<input type="hidden" name="currentPage" value="${startPage - 10}" />
					<input type="hidden" name="searchKeyword" value="${searchKeyword}" />
					<button type="submit">&lt;</button>
				</form>
			</c:if>

			<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
				<form method="get" style="display: inline;">
					<input type="hidden" name="currentPage" value="${pageNum}" /> <input
						type="hidden" name="searchKeyword" value="${searchKeyword}" />
					<button type="submit"
						class="${pageNum == currentPage ? 'active' : ''}">${pageNum}</button>
				</form>
			</c:forEach>

			<c:if test="${endPage < totalPages}">
				<form method="get" style="display: inline;">
					<input type="hidden" name="currentPage" value="${startPage + 10}" />
					<input type="hidden" name="searchKeyword" value="${searchKeyword}" />
					<button type="submit">&gt;</button>
				</form>
			</c:if>
		</div>

	</div>

	<script>
	document.addEventListener('DOMContentLoaded', function() {
	    // 오늘 날짜 자동 입력
	    if(document.getElementById('createDate')) {
	        document.getElementById('createDate').value = new Date().toISOString().substring(0, 10);
	    }

	    // 전체 선택/해제 체크박스
	    document.getElementById('selectAll').addEventListener('change', function() {
	        var checkboxes = document.querySelectorAll('input[name="check"]');
	        checkboxes.forEach(function(checkbox) {
	            checkbox.checked = this.checked;
	        }, this);
	    });
	    
	    // 개별 체크박스 전체선택 동기화
	    document.querySelectorAll('input[name="check"]').forEach(function(checkbox) {
	        checkbox.addEventListener('change', function() {
	            const allChecked = Array.from(document.querySelectorAll('input[name="check"]')).every(cb => cb.checked);
	            document.getElementById('selectAll').checked = allChecked;
	        });
	    });

	    // 등록 버튼
	    document.querySelector('.insert1').addEventListener('click', function(event) {
	    	event.preventDefault();
	    	
	    	// 필수값 검사
		    var requiredFields = [
		        'consumablesCode', 'manager', 'createDate',
		        'consumablesName', 'p_Con_count'
		    ];
		    for (var i = 0; i < requiredFields.length; i++) {
		        if (!document.getElementById(requiredFields[i]).value.trim()) {
		            alert("필수 항목을 모두 입력해주세요.");
		            return;
		        }
		    }
	    	
	        const data = {
	            consumables_code: document.getElementById('consumablesCode').value,
	            consumables_name: document.getElementById('consumablesName').value,
	            create_date: document.getElementById('createDate').value,
	            p_Con_count: document.getElementById('p_Con_count').value,
	            manager: document.getElementById('manager').value,
	            remarks: document.getElementById('remarks').value
	        };
	        fetch('${pageContext.request.contextPath}/p_CMB', {
	            method: 'POST',
	            headers: {'Content-Type': 'application/json'},
	            body: JSON.stringify(data)
	        })
	        .then(response => response.text())
	        .then(result => {
	            if(result === "success") {
	                alert("등록 성공!");
	                location.reload();
	            } else if(result === "duplicate") {
	                alert("상품코드는 중복될 수 없습니다");
	            } else {
	                alert("등록 실패!");
	            }
	        });

	    });

	    // 삭제 버튼
	    document.querySelector('.delete1').addEventListener('click', function(e) {
	        e.preventDefault();
	        const selectedCodes = Array.from(document.querySelectorAll('input[name="check"]:checked')).map(cb => cb.value);
	        if (selectedCodes.length === 0) {
	            alert("삭제할 항목을 선택하세요.");
	            return;
	        }
	        if (!confirm("정말 삭제하시겠습니까?")) return;
	        fetch('p_conDelete', {
	            method: 'POST',
	            headers: {'Content-Type': 'application/json'},
	            body: JSON.stringify(selectedCodes)
	        })
	        .then(response => response.text())
	        .then(result => {
	            if(result === "true") {
	                alert("삭제 성공!");
	                location.reload();
	            } else {
	                alert("삭제 실패!");
	            }
	        });
	    });

	    // 수정 버튼
	    document.querySelector('.update1').addEventListener('click', function() {
	        const selectedChecks = document.querySelectorAll('input[name="check"]:checked');
	        if (selectedChecks.length !== 1) {
	            alert(selectedChecks.length > 1 ?
	                "수정 시 하나의 항목만 선택해주세요." :
	                "수정할 항목을 선택해주세요.");
	            return;
	        }
	        // 선택된 행 데이터 추출
	        const consumablesCode = selectedChecks[0].value;
	        const selectedRow = selectedChecks[0].closest('tr');
	        const cells = selectedRow.cells;

	        // 폼에 데이터 채우기
	        document.getElementById('consumablesCode').value = consumablesCode;
	        document.getElementById('consumablesName').value = cells[3].textContent.trim();
	        document.getElementById('manager').value = cells[4].textContent.trim();
	        document.getElementById('createDate').value = new Date().toISOString().substring(0, 10);
	        document.getElementById('p_Con_count').value = cells[6].textContent.trim();
	        document.getElementById('remarks').value = cells[7].textContent.trim();
	        document.getElementById('consumablesCode').readOnly = true;

	        // 기존 버튼 숨기기
	        document.querySelectorAll('.buttons button').forEach(button => {
	            button.style.display = 'none';
	        });

	        // 수정완료/수정취소 버튼 생성
	        const completeButton = document.createElement('button');
	        completeButton.textContent = '수정완료';
	        completeButton.type = 'button';
	        completeButton.className = 'complete-update';

	        const cancelButton = document.createElement('button');
	        cancelButton.textContent = '수정취소';
	        cancelButton.type = 'button';
	        cancelButton.className = 'cancel-update';

	        document.querySelector('.buttons').appendChild(completeButton);
	        document.querySelector('.buttons').appendChild(cancelButton);

	        // 수정완료 버튼 AJAX
	        completeButton.addEventListener('click', function() {
	            const data = {
	                consumables_code: document.getElementById('consumablesCode').value,
	                consumables_name: document.getElementById('consumablesName').value,
	                create_date: document.getElementById('createDate').value,
	                p_Con_count: document.getElementById('p_Con_count').value,
	                manager: document.getElementById('manager').value,
	                remarks: document.getElementById('remarks').value
	            };
	            fetch('p_conUpdate', {
	                method: 'POST',
	                headers: {'Content-Type': 'application/json'},
	                body: JSON.stringify(data)
	            })
	            .then(response => response.text())
	            .then(result => {
	                if(result === "true") {
	                    alert("수정 성공!");
	                    location.reload();
	                } else {
	                    alert("수정 실패!");
	                }
	            });
	        });

	        // 수정취소 버튼
	        cancelButton.addEventListener('click', function() {
	            // 체크박스 초기화
	            document.querySelectorAll('input[name="check"]').forEach(cb => cb.checked = false);
	            document.getElementById('consumablesCode').readOnly = false;
	            document.querySelectorAll('.buttons button').forEach(button => {
	                button.style.display = 'inline-block';
	            });
	            // 폼 초기화
	            document.getElementById('consumablesCode').value = '';
	            document.getElementById('consumablesName').value = '';
	            document.getElementById('createDate').value = new Date().toISOString().substring(0, 10);
	            document.getElementById('p_Con_count').value = '';
	            document.getElementById('manager').value = '';
	            document.getElementById('remarks').value = '';
	            completeButton.remove();
	            cancelButton.remove();
	        });
	    });
	});


	</script>
</body>
</html>
