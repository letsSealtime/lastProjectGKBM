<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>설비수리관리</title>
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

.별 {
	color: red;
}

.seach {
	margin-bottom: 15px;
}

#facilityCode {
	background-color: #ccc;
}

@media screen and (max-width: 800px) {
	.form-row {
		flex-direction: column;
		align-items: stretch;
		gap: 5px !important;
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

.edit-buttons {
	margin-top: 10px;
}

.active {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="container">
		<h1>◎ 설비수리관리</h1>
		<span class="별">* 모두기입</span><br>
		<span class="별">설비코드는 설비명 선택시 자동입력</span>

		<!-- 검색 폼 -->
		<form method="get"
			action="${pageContext.request.contextPath}/p_repair" id="mainForm">
			<span>설비코드 or 상세내역</span> <input type="text" name="searchKeyword"
				placeholder="검색어를 입력하세요" value="${searchKeyword}"> <input
				type="hidden" name="currentPage" value="1">
			<button type="submit" class="seach">검색</button>
		</form>


		<div class="form">
			<div class="form-fields">
				<div class="form-row">
					<label for="facilityCode">설비코드</label> <input type="text"
						id="facilityCode" required readonly> <label
						for="facilityName">설비명<span class="별"> *</span></label> <select
						id="facilityName" required>
						<option value="">설비명 선택</option>
						<c:forEach var="facility" items="${facilityList}">
							<option value="${facility.facility_code}"
								data-facility-code="${facility.facility_code}">
								${facility.facility_name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-row">
					<label for="repairItem">수리항목<span class="별"> *</span></label> <select
						id="repairItem" name="repairItem" required>
						<option value="">설비수리항목 선택</option>
						<option value="BR001">브러시 삽입기 부품 교체</option>
						<option value="HN001">손잡이 성형기 노즐 교체</option>
						<option value="PK001">포장기 벨트 교체</option>
						<option value="CT001">칫솔모 절단기 날 교체</option>
						<option value="ML001">손잡이 사출기 히터 교체</option>
						<option value="CV001">컨베이어 벨트 교체</option>
						<option value="RB001">로봇 암 서보모터 교체</option>
						<option value="PL001">플라스틱 압출기 히터 교체</option>
						<option value="DR001">건조기 히터 교체</option>
						<option value="ST001">멸균기 압력 밸브 교체</option>
						<option value="LB001">라벨링 기계 프린트헤드 교체</option>
						<option value="SM001">칫솔모 식모기 정렬 부품 교체</option>
						<option value="CL001">세척기 필터 교체</option>
						<option value="VM001">진공 성형기 실링 교체</option>
						<option value="TM001">트리밍 기계 칼날 교체</option>
						<option value="SP001">스프레이 코팅기 노즐 청소 및 교체</option>
						<option value="GR001">그립 삽입기 정렬 부품 교체</option>
						<option value="HT001">열처리 오븐 히터 교체</option>
						<option value="UV001">UV 살균기 램프 교체</option>
						<option value="WR001">포장 랩핑기 히터 교체</option>
						<option value="PR001">프린팅 기계 잉크 시스템 청소 및 교체</option>
						<option value="AC001">공기압축기 필터 교체</option>
						<option value="MX001">재료 혼합기 임펠러 교체</option>
						<option value="CT002">칫솔모 컬링기 롤러 교체</option>
						<option value="WS001">세척수 필터 교체</option>
						<option value="PD001">분말 도포기 노즐 교체</option>
						<option value="SF001">안전 센서 시스템 부품 교체</option>
						<option value="EL001">전기 제어 패널 부품 교체</option>
					</select> <label for="repairDetails">상세내역<span class="별"> *</span></label> <input
						type="text" id="repairDetails" required>
				</div>
				<div class="form-row">
					<label for="requester">의뢰자<span class="별"> *</span></label> <input
						type="text" id="requester" required> <label
						for="requestDate">의뢰일자<span class="별"> *</span></label> <input
						type="date" id="requestDate" required>
				</div>
				<div class="form-row">
					<label for="remarks">비고사항</label> <input type="text" id="remarks">
				</div>
			</div>
			<div class="buttons">
				<button type="button" class="insert1">등록</button>
				<button type="button" class="update1">수정</button>
				<button type="button" class="delete1">삭제</button>
			</div>
		</div>

		<!-- 설비수리 목록 테이블 -->
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>NO.</th>
					<th>설비코드</th>
					<th>설비명</th>
					<th>의뢰자</th>
					<th>수리항목</th>
					<th>수리상세내역</th>
					<th>의뢰일자</th>
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
							value="${dto.repair_id}"></td>
						<td>${(currentPage-1) * pageSize + loop.count}</td>
						<td>${dto.facility_code}</td>
						<td>${dto.facility_name}</td>
						<td>${dto.repair_requester}</td>
						<td data-repair-code="${dto.repair_item}">
							${repairItemNames[dto.repair_item] != null ? repairItemNames[dto.repair_item] : dto.repair_item}
						</td>

						<td>${dto.repair_details}</td>
						<td>${dto.repair_request_date}</td>
						<td>${dto.remarks}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 페이지네이션 -->
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
// 설비명 선택 시 설비코드 자동 입력
document.getElementById('facilityName').addEventListener('change', function() {
    const selectedOption = this.options[this.selectedIndex];
    document.getElementById('facilityCode').value = selectedOption.value || '';
});

const repairItemNames = {
	    "BR001": "브러시 삽입기 부품 교체",
	    "HN001": "손잡이 성형기 노즐 교체",
	    "PK001": "포장기 벨트 교체",
	    "CT001": "칫솔모 절단기 날 교체",
	    "ML001": "손잡이 사출기 히터 교체",
	    "CV001": "컨베이어 벨트 교체",
	    "RB001": "로봇 암 서보모터 교체",
	    "PL001": "플라스틱 압출기 히터 교체",
	    "DR001": "건조기 히터 교체",
	    "ST001": "멸균기 압력 밸브 교체",
	    "LB001": "라벨링 기계 프린트헤드 교체",
	    "SM001": "칫솔모 식모기 정렬 부품 교체",
	    "CL001": "세척기 필터 교체",
	    "VM001": "진공 성형기 실링 교체",
	    "TM001": "트리밍 기계 칼날 교체",
	    "SP001": "스프레이 코팅기 노즐 청소 및 교체",
	    "GR001": "그립 삽입기 정렬 부품 교체",
	    "HT001": "열처리 오븐 히터 교체",
	    "UV001": "UV 살균기 램프 교체",
	    "WR001": "포장 랩핑기 히터 교체",
	    "PR001": "프린팅 기계 잉크 시스템 청소 및 교체",
	    "AC001": "공기압축기 필터 교체",
	    "MX001": "재료 혼합기 임펠러 교체",
	    "CT002": "칫솔모 컬링기 롤러 교체",
	    "WS001": "세척수 필터 교체",
	    "PD001": "분말 도포기 노즐 교체",
	    "SF001": "안전 센서 시스템 부품 교체",
	    "EL001": "전기 제어 패널 부품 교체"
	};
	
//테이블의 수리항목 코드를 한글명으로 변환
document.querySelectorAll('#table-body tr').forEach(tr => {
    const td = tr.cells[5];
    if(td) {
        const code = td.textContent.trim();
        if(repairItemNames[code]) {
            td.textContent = repairItemNames[code];
        }
    }
});

document.querySelectorAll('#table-body tr').forEach(tr => {
    const td = tr.cells[5];
    if(td) {
        const code = td.textContent.trim();
        if(repairItemNames[code]) {
            td.setAttribute('data-repair-code', code); // 코드 저장
            td.textContent = repairItemNames[code];     // 한글로 표시
        }
    }
});



// 오늘 날짜 기본값
document.getElementById('requestDate').value = new Date().toISOString().substring(0, 10);

// 전체 선택/해제
document.getElementById('selectAll').addEventListener('change', function() {
    document.querySelectorAll('input[name="check"]').forEach(cb => cb.checked = this.checked);
});

//개별 체크박스 전체선택 동기화
document.querySelectorAll('input[name="check"]').forEach(function(checkbox) {
    checkbox.addEventListener('change', function() {
        const allChecked = Array.from(document.querySelectorAll('input[name="check"]')).every(cb => cb.checked);
        document.getElementById('selectAll').checked = allChecked;
    });
});

// 등록 버튼 (AJAX)
document.querySelector('.insert1').addEventListener('click', function() {
    const data = {
        facility_code: document.getElementById('facilityCode').value,
        repair_item: document.getElementById('repairItem').value,
        repair_details: document.getElementById('repairDetails').value,
        repair_requester: document.getElementById('requester').value,
        repair_request_date: document.getElementById('requestDate').value,
        remarks: document.getElementById('remarks').value
    };
    
    // 필수값 검사
    for (let key in data) {
        if (key !== 'remarks' && !data[key]) {
            alert('필수 항목을 모두 입력하세요.');
            return;
        }
    }
    fetch('${pageContext.request.contextPath}/p_repair', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
    .then(res => res.text())
    .then(result => {
        if (result === "success") {
            alert("등록 성공!");
            location.reload();
        } else {
            alert("등록 실패!");
        }
    });
});

// 삭제 버튼 (AJAX)
document.querySelector('.delete1').addEventListener('click', function() {
    const selectedIds = Array.from(document.querySelectorAll('input[name="check"]:checked')).map(cb => cb.value);
    if (selectedIds.length === 0) {
        alert("삭제할 항목을 선택하세요.");
        return;
    }
    if (!confirm("정말 삭제하시겠습니까?")) return;
    fetch('${pageContext.request.contextPath}/p_repairDelete', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(selectedIds)
    })
    .then(res => res.text())
    .then(result => {
        if (result === "true") {
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

    // 폼에 데이터 채우기
    document.getElementById('facilityCode').value = cells[2].textContent.trim();
    // 설비명 select 옵션값 맞추기
    const facilityName = cells[3].textContent.trim();
    Array.from(document.getElementById('facilityName').options).forEach(opt => {
        if(opt.textContent.trim() === facilityName) opt.selected = true;
    });
    document.getElementById('requester').value = cells[4].textContent.trim();
    document.getElementById('repairItem').value = cells[5].getAttribute('data-repair-code');
    document.getElementById('repairDetails').value = cells[6].textContent.trim();
    document.getElementById('requestDate').value = cells[7].textContent.trim();
    document.getElementById('remarks').value = cells[8].textContent.trim();
    document.getElementById('facilityCode').readOnly = true;

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
            repair_id: selectedChecks[0].value,
            facility_code: document.getElementById('facilityCode').value,
            repair_item: document.getElementById('repairItem').value,
            repair_details: document.getElementById('repairDetails').value,
            repair_requester: document.getElementById('requester').value,
            repair_request_date: document.getElementById('requestDate').value,
            remarks: document.getElementById('remarks').value
        };
        // 필수값 검사
        for (let key in data) {
            if (key !== 'remarks' && !data[key]) {
                alert('필수 항목을 모두 입력하세요.');
                return;
            }
        }
        fetch('${pageContext.request.contextPath}/p_repairUpdate', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        })
        .then(res => res.text())
        .then(result => {
            if (result === "true" || result === "success") {
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
        document.getElementById('facilityCode').readOnly = false;
        document.querySelectorAll('.buttons button').forEach(button => {
            button.style.display = 'inline-block';
        });
        // 폼 초기화
        document.getElementById('facilityCode').value = '';
        document.getElementById('facilityName').value = '';
        document.getElementById('repairItem').value = '';
        document.getElementById('repairDetails').value = '';
        document.getElementById('requester').value = '';
        document.getElementById('requestDate').value = new Date().toISOString().substring(0, 10);
        document.getElementById('remarks').value = '';
        completeButton.remove();
        cancelButton.remove();
    });
});

</script>
</body>
</html>
