<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>소모품수불관리</title>
<style>
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
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

#consumables_code {
    background-color: #ccc;
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
		<h1>◎ 소모품 수불관리</h1>

		<span class="별">* 모두기입</span><br>
		<span class="별">소모품 코드는 소모품명 선택시 자동입력</span>
		<!-- 검색 폼 -->
		<form method="get" action="${pageContext.request.contextPath}/p_CSB">
			<span>소모품코드 or 소모품명</span> <input type="text" name="searchKeyword"
				placeholder="검색어를 입력하세요" value="${searchKeyword}"> <input
				type="hidden" name="currentPage" value="1">
			<button type="submit" class="seach">검색</button>
		</form>

		<!-- 등록/수정 폼 -->
		<div class="form">
			<div class="form-fields">
				<div class="form-row">
					<label for="consumables_code">소모품코드<span class="별">
							*</span></label> <input type="text" id="consumables_code" required readonly>
					<label for="consumables_name">소모품명<span class="별"> *</span></label>
					<select id="consumables_name" required>
						<option value="">소모품 선택</option>
						<c:forEach var="item" items="${consumregList}">
							<option value="${item.consumables_code}"
								data-stock="${item.p_Con_count}">
								${item.consumables_name} (현재 재고: ${item.p_Con_count})</option>
						</c:forEach>
					</select>
				</div>

				<div class="form-row">
					<label for="requester">불출자<span class="별"> *</span></label> <input
						type="text" id="requester"> <label for="importer">수입자<span
						class="별"> *</span></label> <input type="text" id="importer">
				</div>

				<div class="form-row">
					<label for="log_count">수량<span class="별"> *</span></label> <input
						type="number" id="log_count" min="0" required> <label
						for="receipt_payment_date">수불일자<span class="별"> *</span></label> <input
						type="date" id="receipt_payment_date">
				</div>

				<div class="form-row">
					<label for="remarks">비고사항</label> <input type="text" id="remarks">
				</div>
			</div>

			<!-- 버튼 영역 -->
			<div class="buttons">
				<button type="button" value="등록" class="buttons insert1">등록</button>
				<button type="button" value="수정" class="buttons update1">수정</button>
				<button type="button" value="삭제" class="buttons delete1">삭제</button>
			</div>
		</div>

		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>NO.</th>
					<th>소모품코드</th>
					<th>소모품명</th>
					<th>불출자</th>
					<th>수입자</th>
					<th>수량</th>
					<th>수불일자</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody id="table-body">
				<c:if test="${empty resultList}">
					<tr>
						<td colspan="9">일치되는 항목이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="dto" items="${resultList}" varStatus="loop">
					<tr>
						<td><input type="checkbox" name="check"
							value="${dto.receipt_payment_id}"></td>
						<td>${(currentPage-1)*pageSize + loop.count}</td>
						<td>${dto.consumables_code}</td>
						<td>${dto.consumables_name}</td>
						<td>${dto.requester}</td>
						<td>${dto.importer}</td>
						<td>${dto.log_count}</td>
						<td>${dto.receipt_payment_date}</td>
						<td>${dto.remarks}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 페이지 넘길때 쓸 버튼들 -->
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
	    // 오늘 날짜로 초기화
	    document.getElementById('receipt_payment_date').value = new Date().toISOString().substring(0, 10);
	    
	    // 소모품명 선택 시 코드 자동 입력
	    document.getElementById('consumables_name').addEventListener('change', function() {
	        const selectedOption = this.options[this.selectedIndex];
	        document.getElementById('consumables_code').value = selectedOption.value || '';
	    });

	    // 전체 선택/해제 체크박스
	    document.getElementById('selectAll').addEventListener('change', function() {
	        const checkboxes = document.querySelectorAll('input[name="check"]');
	        checkboxes.forEach(checkbox => checkbox.checked = this.checked);
	    });

	 // 등록 버튼 이벤트 수정 (출고 검증 추가)
	    document.querySelector('.insert1').addEventListener('click', function(event) {
	        event.preventDefault();
	        
	        // 필수값 검증
	        const requiredFields = ['consumables_code', 'requester', 'importer', 'log_count', 'receipt_payment_date'];
	        for (const field of requiredFields) {
	            const el = document.getElementById(field);
	            if (!el || (el.type === 'number' ? el.value <= 0 : !el.value.trim())) {
	                alert("필수 항목을 모두 입력해주세요.");
	                return;
	            }
	        }

	        // 재고 검증 (출고 시)
	        const selectedOption = document.getElementById('consumables_name').selectedOptions[0];
	        const currentStock = parseInt(selectedOption.dataset.stock);
	        const logCount = parseInt(document.getElementById('log_count').value);
	        
	        if (logCount > currentStock) {
	            alert(`출고 수량이 현재 재고보다 많습니다.\n현재 재고: ${currentStock}`);
	            return;
	        }

	        // 데이터 전송
	        const data = {
	            consumables_code: document.getElementById('consumables_code').value,
	            requester: document.getElementById('requester').value,
	            importer: document.getElementById('importer').value,
	            log_count: parseInt(document.getElementById('log_count').value),
	            receipt_payment_date: document.getElementById('receipt_payment_date').value,
	            remarks: document.getElementById('remarks').value
	        };

	        fetch('${pageContext.request.contextPath}/p_CSBinsert', {
	            method: 'POST',
	            headers: { 'Content-Type': 'application/json' },
	            body: JSON.stringify(data)
	        })
	        .then(response => response.text())
	        .then(result => {
	            if (result === "success") {
	                alert("등록 성공!");
	                location.reload();
	            } else {
	                alert("등록 실패!");
	            }
	        });
	    });

	    // 삭제 버튼 이벤트
	    document.querySelector('.delete1').addEventListener('click', function(e) {
		    e.preventDefault();
		    const selectedRows = Array.from(document.querySelectorAll('input[name="check"]:checked'))
		                            .map(cb => {
		                                const row = cb.closest('tr');
		                                return {
		                                	receipt_payment_id: cb.value,
		                                    consumables_code: row.cells[2].textContent.trim(),
		                                    log_count: parseInt(row.cells[6].textContent.trim())
		                                };
		                            });
		    
		    if (selectedRows.length === 0) {
		        alert("삭제할 항목을 선택하세요.");
		        return;
		    }
		    if (!confirm("정말 삭제하시겠습니까?")) return;
		
		    Promise.all(selectedRows.map(row => {
		        return fetch('${pageContext.request.contextPath}/p_CSBdelete', {
		            method: 'POST',
		            headers: {'Content-Type': 'application/json'},
		            body: JSON.stringify(row)
		        }).then(res => res.text());
		    })).then(results => {
		        if (results.every(r => r === "success")) {
		            alert("삭제 성공!");
		            location.reload();
		        } else {
		            alert("삭제 실패!");
		        }
		    });
		});
	    
	    // log_count 입력 시 음수 및 최대값 검증
	    document.getElementById('log_count').addEventListener('input', function() {
	        let value = parseInt(this.value, 10);
	        if (isNaN(value)) value = 0;

	        // 음수 입력 방지
	        if (value < 0) {
	            this.value = 0;
	            alert("음수는 입력할 수 없습니다.");
	            return;
	        }

	        // 최대 재고량 검증 (수정 시)
	        const selectedOption = document.getElementById('consumables_name').selectedOptions[0];
	        if (!selectedOption) return;
	        const currentStock = parseInt(selectedOption.dataset.stock, 10);

	        if (value > currentStock) {
	            this.value = currentStock;
	            alert(`최대 ${currentStock}개까지 입력 가능합니다.`);
	        }
	    });

	 // 수정 버튼 이벤트
	    document.querySelector('.update1').addEventListener('click', function() {
	        const selectedChecks = document.querySelectorAll('input[name="check"]:checked');
	        if (selectedChecks.length !== 1) {
	            alert(selectedChecks.length > 1 ? "수정 시 하나의 항목만 선택해주세요." : "수정할 항목을 선택해주세요.");
	            return;
	        }

	        // 선택된 행 데이터 추출
	        const selectedRow = selectedChecks[0].closest('tr');
	        const cells = selectedRow.cells;

	        // 소모품명 select의 value(=소모품코드)로 맞추기
	        const codeToSelect = cells[2].textContent.trim();
	        const selectBox = document.getElementById('consumables_name');
	        selectBox.value = codeToSelect;
	        if (selectBox.value !== codeToSelect) {
	            Array.from(selectBox.options).forEach(opt => {
	                if (opt.value === codeToSelect) opt.selected = true;
	            });
	        }

	        // 폼에 데이터 채우기
	        document.getElementById('consumables_code').value = cells[2].textContent.trim();
	        document.getElementById('requester').value = cells[4].textContent.trim();
	        document.getElementById('importer').value = cells[5].textContent.trim();
	        document.getElementById('log_count').value = cells[6].textContent.trim();
	        document.getElementById('receipt_payment_date').value = cells[7].textContent.trim();
	        document.getElementById('remarks').value = cells[8].textContent.trim();

	        // 기존 버튼 숨기기
	        document.querySelectorAll('.buttons button').forEach(btn => btn.style.display = 'none');

	        // 수정완료/취소 버튼 생성
	        const completeBtn = document.createElement('button');
	        completeBtn.textContent = '수정완료';
	        completeBtn.className = 'complete-update';

	        const cancelBtn = document.createElement('button');
	        cancelBtn.textContent = '수정취소';
	        cancelBtn.className = 'cancel-update';

	        document.querySelector('.buttons').append(completeBtn, cancelBtn);

	        // 수정완료 이벤트 (여기에 검증 추가)
	        completeBtn.addEventListener('click', function() {
			    const logCountInput = document.getElementById('log_count');
			    const logCount = parseInt(logCountInput.value, 10);
			    const selectedOption = document.getElementById('consumables_name').selectedOptions[0];
			    const currentStock = parseInt(selectedOption.dataset.stock, 10);
			    
			    // 원본 트랜잭션 수량 추출
			    const originalLogCount = parseInt(
			        selectedChecks[0].closest('tr').cells[6].textContent.trim(), 10
			    );
			    const delta = originalLogCount - logCount; // 차이 계산
			
			    // 음수 검증
			    if (isNaN(logCount) || logCount < 0) {
			        alert("수량은 0 이상 입력해야 합니다.");
			        logCountInput.focus();
			        return;
			    }
			
			    // 재고 가용성 검증 (현재 재고 + 원본 트랜잭션 복구 후 차감)
			    if ((currentStock + originalLogCount) < logCount) {
			        const maxAllowed = currentStock + originalLogCount;
			        alert(`최대 ${maxAllowed}개까지 입력 가능합니다. (현재 재고: ${currentStock}개)`);
			        logCountInput.value = maxAllowed;
			        logCountInput.focus();
			        return;
			    }

	            const data = {
	                receipt_payment_id: selectedChecks[0].value,
	                consumables_code: document.getElementById('consumables_code').value,
	                requester: document.getElementById('requester').value,
	                importer: document.getElementById('importer').value,
	                log_count: logCount,
	                receipt_payment_date: document.getElementById('receipt_payment_date').value,
	                remarks: document.getElementById('remarks').value
	            };

	            fetch('${pageContext.request.contextPath}/p_CSBupdate', {
	                method: 'POST',
	                headers: { 'Content-Type': 'application/json' },
	                body: JSON.stringify(data)
	            })
	            .then(response => response.text())
	            .then(result => {
	                if (result === "success") {
	                    alert("수정 성공!");
	                    location.reload();
	                } else {
	                    alert("수정 실패!");
	                }
	            });
	        });

	        // 수정취소 이벤트
	        cancelBtn.addEventListener('click', function() {
	            document.querySelectorAll('.buttons button').forEach(btn => btn.style.display = 'inline-block');
	            completeBtn.remove();
	            cancelBtn.remove();
	            document.querySelectorAll('input[name="check"]').forEach(cb => cb.checked = false);
	            document.getElementById('consumables_code').value = '';
	            document.getElementById('requester').value = '';
	            document.getElementById('importer').value = '';
	            document.getElementById('log_count').value = '';
	            document.getElementById('receipt_payment_date').value = new Date().toISOString().substring(0, 10);
	            document.getElementById('remarks').value = '';
	        });
	    });
	});

    </script>
</body>

</html>