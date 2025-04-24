<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>설비점검관리</title>
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
		<h1>◎ 설비점검관리</h1>
		
		<span class="별">* 모두기입</span><br>
		<span class="별">설비코드는 설비명 선택시 자동입력</span>
		
		<!-- 검색 폼 -->
		<form method="get" action="${pageContext.request.contextPath}/p_ins"
			id="mainForm">
			<span>설비코드 or 점검내용</span> <input type="text" name="searchKeyword"
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
					<label for="inspectionItem">점검항목<span class="별"> *</span></label> <select
						id="inspectionItem" name="inspectionItem" required>
						<option value="">점검항목 선택</option>
						<!-- 전기/전자 시스템 -->
						<option value="CHK001">전원상태 점검</option>
						<option value="CHK002">회로차단기 접점 상태</option>
						<option value="CHK003">배전반 내부 청결도</option>
						<option value="CHK004">전선 절연피복 상태</option>
						<option value="CHK005">접지선 연결 상태</option>

						<!-- 기계부품 -->
						<option value="CHK006">베어링 윤활 상태</option>
						<option value="CHK007">벨트 텐션 조절</option>
						<option value="CHK008">체인 구동부 마모도</option>
						<option value="CHK009">기어박스 오일량</option>
						<option value="CHK010">컨베이어 롤러 정렬</option>

						<!-- 안전장치 -->
						<option value="CHK011">비상정지 버튼 기능</option>
						<option value="CHK012">가드레일 고정 상태</option>
						<option value="CHK013">광학식 안전센서</option>
						<option value="CHK014">압력 릴리프 밸브</option>
						<option value="CHK015">화재감지기 작동 테스트</option>

						<!-- 유압/공기압 -->
						<option value="CHK016">유압펌프 압력 설정값</option>
						<option value="CHK017">공기압 실린더 누설</option>
						<option value="CHK018">공기필터 청소 주기</option>
						<option value="CHK019">유온 조절기 설정</option>
						<option value="CHK020">호스 연결부 상태</option>

						<!-- 계측/제어 -->
						<option value="CHK021">온도센서 교정</option>
						<option value="CHK022">압력게이지 오차 범위</option>
						<option value="CHK023">PLC I/O 모듈 상태</option>
						<option value="CHK024">터치패널 반응 속도</option>
						<option value="CHK025">전자밸브 응답 시간</option>

						<!-- 구조물 -->
						<option value="CHK026">프레임 볼트 체결력</option>
						<option value="CHK027">진동 감쇠 장치</option>
						<option value="CHK028">경사각 측정</option>
						<option value="CHK029">레일 마모도</option>
						<option value="CHK030">구조물 부식 상태</option>

						<!-- 특수공정 -->
						<option value="CHK031">진공 챔버 누설 테스트</option>
						<option value="CHK032">멸균기 온도 균일도</option>
						<option value="CHK033">레이저 출력 강도</option>
						<option value="CHK034">초음파 용접 강도</option>
						<option value="CHK035">냉각수 순환 효율</option>

						<!-- 환경안전 -->
						<option value="CHK036">배기덕트 유량</option>
						<option value="CHK037">소음 수준 측정</option>
						<option value="CHK038">분진 집진 효율</option>
						<option value="CHK039">폐기물 배출 시스템</option>
						<option value="CHK040">비상조명 작동</option>

						<!-- 소모품 -->
						<option value="CHK041">필터 교체 주기</option>
						<option value="CHK042">윤활유 산화도</option>
						<option value="CHK043">절삭유 청정도</option>
						<option value="CHK044">브러쉬 마모량</option>
						<option value="CHK045">씰링 부품 수명</option>

						<!-- 특수검사 -->
						<option value="CHK046">X선 검사기 차폐</option>
						<option value="CHK047">초음파 탐상 검사</option>
						<option value="CHK048">열화상 카메라 검사</option>
						<option value="CHK049">진동 스펙트럼 분석</option>
						<option value="CHK050">압력 용기 내부 검사</option>
					</select> <label for="inspectionContent">점검내용<span class="별">
							*</span></label> <input type="text" id="inspectionContent" required>
				</div>
				<div class="form-row">
					<label for="inspector">점검자<span class="별"> *</span></label> <input
						type="text" id="inspector" required> <label
						for="inspectionDate">점검일자<span class="별"> *</span></label> <input
						type="date" id="inspectionDate" required>
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
		<!-- 설비점검 목록 테이블 -->
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>NO.</th>
					<th>설비코드</th>
					<th>설비명</th>
					<th>점검자</th>
					<th>점검항목</th>
					<th>점검내용</th>
					<th>점검일자</th>
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
							value="${dto.inspection_id}"></td>
						<td>${(currentPage-1) * 10 + loop.count}</td>
						<td>${dto.facility_code}</td>
						<td>${dto.facility_name}</td>
						<td>${dto.inspector}</td>
						<td>${dto.inspection_item}</td>
						<td>${dto.inspection_content}</td>
						<td>${dto.inspection_date}</td>
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
	
	// 점검항목 코드-한글명 매핑
	const inspectionItemNames = {
	    "CHK001": "전원상태 점검",
	    "CHK002": "회로차단기 접점 상태",
	    "CHK003": "배전반 내부 청결도",
	    "CHK004": "전선 절연피복 상태",
	    "CHK005": "접지선 연결 상태",
	    "CHK006": "베어링 윤활 상태",
	    "CHK007": "벨트 텐션 조절",
	    "CHK008": "체인 구동부 마모도",
	    "CHK009": "기어박스 오일량",
	    "CHK010": "컨베이어 롤러 정렬",
	    "CHK011": "비상정지 버튼 기능",
	    "CHK012": "가드레일 고정 상태",
	    "CHK013": "광학식 안전센서",
	    "CHK014": "압력 릴리프 밸브",
	    "CHK015": "화재감지기 작동 테스트",
	    "CHK016": "유압펌프 압력 설정값",
	    "CHK017": "공기압 실린더 누설",
	    "CHK018": "공기필터 청소 주기",
	    "CHK019": "유온 조절기 설정",
	    "CHK020": "호스 연결부 상태",
	    "CHK021": "온도센서 교정",
	    "CHK022": "압력게이지 오차 범위",
	    "CHK023": "PLC I/O 모듈 상태",
	    "CHK024": "터치패널 반응 속도",
	    "CHK025": "전자밸브 응답 시간",
	    "CHK026": "프레임 볼트 체결력",
	    "CHK027": "진동 감쇠 장치",
	    "CHK028": "경사각 측정",
	    "CHK029": "레일 마모도",
	    "CHK030": "구조물 부식 상태",
	    "CHK031": "진공 챔버 누설 테스트",
	    "CHK032": "멸균기 온도 균일도",
	    "CHK033": "레이저 출력 강도",
	    "CHK034": "초음파 용접 강도",
	    "CHK035": "냉각수 순환 효율",
	    "CHK036": "배기덕트 유량",
	    "CHK037": "소음 수준 측정",
	    "CHK038": "분진 집진 효율",
	    "CHK039": "폐기물 배출 시스템",
	    "CHK040": "비상조명 작동",
	    "CHK041": "필터 교체 주기",
	    "CHK042": "윤활유 산화도",
	    "CHK043": "절삭유 청정도",
	    "CHK044": "브러쉬 마모량",
	    "CHK045": "씰링 부품 수명",
	    "CHK046": "X선 검사기 차폐",
	    "CHK047": "초음파 탐상 검사",
	    "CHK048": "열화상 카메라 검사",
	    "CHK049": "진동 스펙트럼 분석",
	    "CHK050": "압력 용기 내부 검사"
	};
	
	// 테이블의 점검항목 코드를 한글명으로 변환
	document.querySelectorAll('#table-body tr').forEach(tr => {
	    const td = tr.cells[5]; // 점검항목 컬럼(0:체크박스, 1:NO, 2:설비코드, 3:설비명, 4:점검자, 5:점검항목)
	    if(td) {
	        const code = td.textContent.trim();
	        if(inspectionItemNames[code]) {
	            td.setAttribute('data-inspection-code', code); // 코드 저장
	            td.textContent = inspectionItemNames[code];    // 한글로 표시
	        }
	    }
	});
	
	// 오늘 날짜 기본값
	document.getElementById('inspectionDate').value = new Date().toISOString().substring(0, 10);
	// 전체 선택/해제
	document.getElementById('selectAll').addEventListener('change', function() {
	    document.querySelectorAll('input[name="check"]').forEach(cb => cb.checked = this.checked);
	});
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
	            inspection_date: document.getElementById('inspectionDate').value,
	            inspector: document.getElementById('inspector').value,
	            inspection_item: document.getElementById('inspectionItem').value,
	            inspection_content: document.getElementById('inspectionContent').value,
	            remarks: document.getElementById('remarks').value
	    };
	    for (let key in data) {
	        if (key !== 'remarks' && !data[key]) {
	            alert('필수 항목을 모두 입력하세요.');
	            return;
	        }
	    }
	    fetch('${pageContext.request.contextPath}/p_insInsert', {
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
	    fetch('${pageContext.request.contextPath}/p_insDelete', {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify(selectedIds)
	    })
	    .then(res => res.text())
	    .then(result => {
	        if (result === "success") {
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
	    document.getElementById('facilityCode').value = cells[2].textContent.trim();
	    // 설비명 select 옵션값 맞추기
	    const facilityName = cells[3].textContent.trim();
	    Array.from(document.getElementById('facilityName').options).forEach(opt => {
	        if(opt.textContent.trim() === facilityName) opt.selected = true;
	    });
	    document.getElementById('inspector').value = cells[4].textContent.trim();
	    document.getElementById('inspectionItem').value = cells[5].textContent.trim();
	    document.getElementById('inspectionContent').value = cells[6].textContent.trim();
	    document.getElementById('inspectionDate').value = cells[7].textContent.trim();
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
	    	        inspection_id: selectedChecks[0].value,
	    	        facility_code: document.getElementById('facilityCode').value,
	    	        inspection_date: document.getElementById('inspectionDate').value,
	    	        inspector: document.getElementById('inspector').value,
	    	        inspection_item: document.getElementById('inspectionItem').value,
	    	        inspection_content: document.getElementById('inspectionContent').value,
	    	        remarks: document.getElementById('remarks').value
	    	    };
	        for (let key in data) {
	            if (key !== 'remarks' && !data[key]) {
	                alert('필수 항목을 모두 입력하세요.');
	                return;
	            }
	        }
	        fetch('${pageContext.request.contextPath}/p_insUpdate', {
	            method: 'POST',
	            headers: { 'Content-Type': 'application/json' },
	            body: JSON.stringify(data)
	        })
	        .then(res => res.text())
	        .then(result => {
	            if (result === "success") {
	                alert("수정 성공!");
	                location.reload();
	            } else {
	                alert("수정 실패!");
	            }
	        });
	    });
	    // 수정취소 버튼
	    cancelButton.addEventListener('click', function() {
	        document.querySelectorAll('input[name="check"]').forEach(cb => cb.checked = false);
	        document.getElementById('facilityCode').readOnly = false;
	        document.querySelectorAll('.buttons button').forEach(button => {
	            button.style.display = 'inline-block';
	        });
	        document.getElementById('facilityCode').value = '';
	        document.getElementById('facilityName').value = '';
	        document.getElementById('inspectionItem').value = '';
	        document.getElementById('inspectionContent').value = '';
	        document.getElementById('inspector').value = '';
	        document.getElementById('inspectionDate').value = new Date().toISOString().substring(0, 10);
	        document.getElementById('remarks').value = '';
	        completeButton.remove();
	        cancelButton.remove();
	    });
	});
	</script>
</body>
</html>
