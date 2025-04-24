<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>소모품폐기</title>
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
		<h1>◎ 소모품 폐기</h1>

		<span class="별">* 모두기입</span><br>
		<span class="별">소모품 코드는 소모품명 선택시 자동입력</span>

		<!-- 검색 폼 -->
		<form method="get" action="${pageContext.request.contextPath}/p_CPG">
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
					<label for="manager">관리자<span class="별"> *</span></label> <input
						type="text" id="manager" required> <label for="count">수량<span
						class="별"> *</span></label> <input type="text" id="count" required>
				</div>

				<div class="form-row">
					<label for="disposalReason">폐기사유<span class="별"> *</span></label> <input
						type="text" id="disposal_reason" required> <label
						for="disposal_date">폐기일자<span class="별"> *</span></label> <input
						type="date" id="disposal_date" required>
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
					<th>관리자</th>
					<th>수량</th>
					<th>폐기사유</th>
					<th>폐기일자</th>
					<th>비고사항</th>
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
							value="${dto.disposal_id}"></td>
						<td>${(currentPage-1) * pageSize + loop.count}</td>
						<td>${dto.consumables_code}</td>
						<td>${dto.consumables_name}</td>
						<td>${dto.manager}</td>
						<td>${dto.count}</td>
						<td>${dto.disposal_reason}</td>
						<td>${dto.disposal_date}</td>
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
		 // 항상 오늘 날짜로 하는 스크립트
	    document.getElementById('disposal_date').value = new Date().toISOString().substring(0, 10);
		
		 // 소모품명 선택 시 소모품코드 자동 입력
		document.getElementById('consumables_name').addEventListener('change', function() {
	    	const selectedOption = this.options[this.selectedIndex];
	   	 	document.getElementById('consumables_code').value = selectedOption.value || '';
		});
    
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
	        const requiredFields = ['consumables_code', 'manager', 'count', 'disposal_reason', 'disposal_date'];
	        for (const field of requiredFields) {
	            const el = document.getElementById(field);
	            if (!el || (el.type === 'number' ? el.value <= 0 : !el.value.trim())) {
	                alert("필수 항목을 모두 입력해주세요.");
	                return;
	            }
	        }

	        // 재고 확인
	        const selectedOption = document.getElementById('consumables_name').selectedOptions[0];
	        const currentStock = parseInt(selectedOption.dataset.stock);
	        const disposalQuantity = parseInt(document.getElementById('count').value);
			console.log(currentStock)
	        if (disposalQuantity > currentStock) {
	            alert("폐기 수량이 현재 재고보다 많습니다. \n현재 재고: "+currentStock);
	            return;
	        }

	        // 데이터 전송
	        const data = {
	            consumables_code: document.getElementById('consumables_code').value,
	            manager: document.getElementById('manager').value,
	            count: disposalQuantity,
	            disposal_reason: document.getElementById('disposal_reason').value,
	            disposal_date: document.getElementById('disposal_date').value,
	            remarks: document.getElementById('remarks').value
	        };

	        fetch('${pageContext.request.contextPath}/p_CPGinsert', {
	            method: 'POST',
	            headers: {'Content-Type': 'application/json'},
	            body: JSON.stringify(data)
	        })
	        .then(response => response.text())
	        .then(result => {
	            if(result === "success") {
	                alert("등록 성공!");
	                location.reload();
	            } else {
	                alert("등록 실패!");
	            }
	        });
	    });
		
	 // 삭제 버튼
	   document.querySelector('.delete1').addEventListener('click', function(e) {
		    e.preventDefault();
		    const selectedRows = Array.from(document.querySelectorAll('input[name="check"]:checked'))
		                            .map(cb => {
		                                const row = cb.closest('tr');
		                                return {
		                                    disposal_id: cb.value,
		                                    consumables_code: row.cells[2].textContent.trim(),
		                                    count: parseInt(row.cells[5].textContent.trim())
		                                };
		                            });
		
		    if (selectedRows.length === 0) {
		        alert("삭제할 항목을 선택하세요.");
		        return;
		    }
		    if (!confirm("정말 삭제하시겠습니까?")) return;
		

		    Promise.all(selectedRows.map(row => {
		        return fetch('${pageContext.request.contextPath}/p_CPGdelete', {
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

	    // 수정 버튼
	    document.querySelector('.update1').addEventListener('click', function() {
	        const selectedChecks = document.querySelectorAll('input[name="check"]:checked');
	        if (selectedChecks.length !== 1) {
	            alert(selectedChecks.length > 1 ?
	                "수정 시 하나의 항목만 선택해주세요." :
	                "수정할 항목을 선택해주세요.");
	            return;
	        }
	        const selectedRow = selectedChecks[0].closest('tr');
	        const cells = selectedRow.cells;

	       

	        // 소모품명 select의 value(=소모품코드)로 맞추기
	        const codeToSelect = cells[2].textContent.trim();
	        const selectBox = document.getElementById('consumables_name');
	        selectBox.value = codeToSelect;
	        // 만약 value가 안 맞으면 아래 루프로 강제 선택
	        if (selectBox.value !== codeToSelect) {
	            Array.from(selectBox.options).forEach(opt => {
	                if (opt.value === codeToSelect) opt.selected = true;
	            });
	        }
	        // 폼에 데이터 채우기 (테이블: 체크/NO/소모품코드/소모품명/관리자/수량/사유/일자/비고)
	        document.getElementById('consumables_code').value = cells[2].textContent.trim();
	        document.getElementById('manager').value = cells[4].textContent.trim();
	        document.getElementById('count').value = cells[5].textContent.trim();
	        document.getElementById('disposal_reason').value = cells[6].textContent.trim();
	        document.getElementById('disposal_date').value = cells[7].textContent.trim();
	        document.getElementById('remarks').value = cells[8].textContent.trim();
	        document.getElementById('consumables_code').readOnly = true;

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
	            // 필수값 검사
	            const requiredFields = ['consumables_code', 'manager', 'count', 'disposal_reason', 'disposal_date'];
	            for (const field of requiredFields) {
	                const el = document.getElementById(field);
	                if (!el || (el.type === 'number' ? el.value <= 0 : !el.value.trim())) {
	                    alert("필수 항목을 모두 입력해주세요.");
	                    return;
	                }
	            }
	            // 데이터 전송
	            const data = {
	                disposal_id: selectedChecks[0].value, // 체크박스 value는 disposal_id
	                consumables_code: document.getElementById('consumables_code').value,
	                manager: document.getElementById('manager').value,
	                count: document.getElementById('count').value,
	                disposal_reason: document.getElementById('disposal_reason').value,
	                disposal_date: document.getElementById('disposal_date').value,
	                remarks: document.getElementById('remarks').value
	            };
	            fetch('${pageContext.request.contextPath}/p_CPGupdate', {
	                method: 'POST',
	                headers: {'Content-Type': 'application/json'},
	                body: JSON.stringify(data)
	            })
	            .then(response => response.text())
	            .then(result => {
	                if(result === "success") {
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
	            document.getElementById('consumables_code').readOnly = false;
	            document.querySelectorAll('.buttons button').forEach(button => {
	                button.style.display = 'inline-block';
	            });
	            // 폼 초기화
	            document.getElementById('consumables_code').value = '';
	            document.getElementById('consumables_name').value = '';
	            document.getElementById('manager').value = '';
	            document.getElementById('count').value = '';
	            document.getElementById('disposal_reason').value = '';
	            document.getElementById('disposal_date').value = new Date().toISOString().substring(0, 10);
	            document.getElementById('remarks').value = '';
	            completeButton.remove();
	            cancelButton.remove();
	        });
	    });

	});
	
    </script>
</body>

</html>