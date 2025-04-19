<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>설비 등록</title>
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

@media screen and (max-width: 800px) {
	.form-row {
		flex-direction: column;
		align-items: stretch;
		gap: 5px !important;
		/* 모바일에서 간격 조정 */
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

@media screen and (max-width: 800px) {
	.form-row {
		flex-direction: column;
		align-items: stretch;
		gap: 5px !important;
		/* 모바일에서 간격 조정 */
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

h1 {
	width: 90%;
}
</style>
</head>

<body>
	<div class="container">
		<h1>◎ 설비 등록</h1>

		<span class="별">* 모두 기입</span>

		<!-- 검색 폼 -->
		<form method="get" action="p_eq" class="form">
			<span>설비코드 or 설비명</span> <input type="text" name="searchKeyword"
				placeholder="검색어를 입력하세요">
			<button type="submit">검색</button>
		</form>

		<!-- 등록/수정 폼 -->
		<form method="post" action="p_equipreg" class="form">
			<div class="form-fields">
				<div class="form-row">
					<label for="facilityCode">설비코드<span class="별"> *</span></label> <input
						type="text" id="facilityCode" name="facility_code"
						value="${dto.facility_code}" required> <label
						for="facilityManager">관리자<span class="별"> *</span></label> <input
						type="text" id="facilityManager" name="facility_manager"
						value="${dto.facility_manager}" required>
				</div>

				<div class="form-row">
					<label for="installationDate">설치일자<span class="별"> *</span></label>
					<input type="date" id="installationDate" name="installation_date"
						value="${dto.installation_date}" required> <label
						for="facilityName">설비명<span class="별"> *</span></label> <input
						type="text" id="facilityName" name="facility_name"
						value="${dto.facility_name}" required>
				</div>

				<div class="form-row">
					<label for="facilityLocation">설비위치<span class="별"> *</span></label>
					<input type="text" id="facilityLocation" name="facility_location"
						value="${dto.facility_location}" required> <label
						for="inspectionCycle">점검주기<span class="별"> *</span></label> <input
						type="text" id="inspectionCycle" name="inspection_cycle"
						value="${dto.inspection_cycle}" required>
				</div>

				<div class="form-row">
					<label for="remarks">비고사항</label> <input type="text" id="remarks"
						name="remarks" value="${dto.remarks}">
				</div>
			</div>

			<!-- 버튼 영역 -->
			<div class="buttons">
				<c:if test="${user.grade == 2}">
					<button type="button" value="조회" class="buttons serch1">조회</button>
				</c:if>
				<%-- 				<c:if test="${user.grade == 1}"> --%>
				<button type="submit" value="등록" class="buttons insert1">등록</button>
				<button type="button" value="수정" class="buttons update1">수정</button>
				<button type="submit" value="삭제" class="buttons delete1">삭제</button>
				<%-- 				</c:if> --%>
			</div>
		</form>
		<!-- 설비 목록 테이블 -->
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>NO.</th>
					<th>설비코드</th>
					<th>설비명</th>
					<th>관리자</th>
					<th>설치일자</th>
					<th>점검주기</th>
					<th>설비위치</th>
					<th>비고사항</th>
				</tr>
			</thead>

			<tbody id="table-body">
				<c:forEach var="dto" items="${resultList}" varStatus="loop">
					<tr>
						<td><input type="checkbox" name="check"
							value="${dto.facility_code}"></td>
						<td>${loop.count}</td>
						<td>${dto.facility_code}</td>
						<td>${dto.facility_name}</td>
						<td>${dto.facility_manager}</td>
						<td>${dto.installation_date}</td>
						<td>${dto.inspection_cycle}</td>
						<td>${dto.facility_location}</td>
						<td>${dto.remarks}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
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
	<script>
		// 페이지 로드 시 초기 설정
		document.addEventListener('DOMContentLoaded', function() {
		    // 등록 버튼을 제외한 모든 버튼에서 required 속성 제거
		    document.querySelectorAll('button:not([value="등록"])').forEach(button => {
		        button.addEventListener('click', function() {
		            document.querySelectorAll(".form-row input").forEach(input => {
		                input.removeAttribute("required");
		            });
		        });
		    });
		});
		
		// 항상 오늘 날짜로 하는 스크립트
		document.getElementById('installationDate').value = new Date().toISOString().substring(0, 10);

		// 전체 선택/해제 체크박스 이벤트
		document.getElementById('selectAll').addEventListener('change', function() {
		    var checkboxes = document.querySelectorAll('input[name="check"]');
		    checkboxes.forEach(function(checkbox) {
		        checkbox.checked = document.getElementById('selectAll').checked;
		    });
		});

		// 조회 버튼


		// 삭제 버튼 클릭 이벤트
		document.querySelector('.delete1').addEventListener('click', function(event) {
		    event.preventDefault();
		    var selectedCodes = [];
		    document.querySelectorAll('input[name="check"]:checked').forEach(function(checkbox) {
		        selectedCodes.push(checkbox.value);
		    });
		
		    if (selectedCodes.length > 0) {
		        if (confirm("선택한 항목을 삭제하시겠습니까?")) {
		            // AJAX로 삭제 요청 (추천)
		            fetch('${pageContext.request.contextPath}/p_eqDelete', {
		                method: 'POST',
		                headers: { 'Content-Type': 'application/json' },
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
		        }
		    } else {
		        alert("삭제할 항목을 선택해주세요.");
		    }
		});

		// 수정 버튼 클릭 이벤트
		document.querySelector('.update1').addEventListener('click', function() {
		    var selectedChecks = document.querySelectorAll('input[name="check"]:checked');
		    if (selectedChecks.length !== 1) {
		        alert(selectedChecks.length > 1 ?
		            "수정 시 하나의 항목만 선택해주세요." :
		            "수정할 항목을 선택해주세요.");
		        return;
		    }
		
		    // 선택된 행 데이터 추출
		    var facilityCode = selectedChecks[0].value;
		    var selectedRow = selectedChecks[0].closest('tr');
		    var cells = selectedRow.cells;
		
		    // 폼 필드에 데이터 채우기 (테이블 구조에 따라 인덱스 조정)
		    document.getElementById('facilityCode').value = facilityCode;
		    document.getElementById('facilityName').value = cells[3].textContent;
		    document.getElementById('facilityManager').value = cells[4].textContent;
		    document.getElementById('installationDate').value = cells[5].textContent;
		    document.getElementById('inspectionCycle').value = cells[6].textContent;
		    document.getElementById('facilityLocation').value = cells[7].textContent;
		    document.getElementById('remarks').value = cells[8].textContent;
		    document.getElementById('facilityCode').readOnly = true;
		
		    // 기존 버튼 숨기기
		    document.querySelectorAll('.buttons button').forEach(button => {
		        button.style.display = 'none';
		    });
		
		    // 수정완료/수정취소 버튼 생성
		    var completeButton = document.createElement('button');
		    completeButton.textContent = '수정완료';
		    completeButton.type = 'button';
		    completeButton.className = 'complete-update';
		
		    var cancelButton = document.createElement('button');
		    cancelButton.textContent = '수정취소';
		    cancelButton.type = 'button';
		    cancelButton.className = 'cancel-update';
		
		    document.querySelector('.buttons').appendChild(completeButton);
		    document.querySelector('.buttons').appendChild(cancelButton);
		
		    // 수정완료 버튼 AJAX 이벤트
		    completeButton.addEventListener('click', function() {
		        // 유효성 검사
		        var requiredFields = [
		            'facilityCode', 'facilityManager', 'installationDate',
		            'facilityName', 'facilityLocation', 'inspectionCycle'
		        ];
		        for (var i=0; i<requiredFields.length; i++) {
		            if (!document.getElementById(requiredFields[i]).value.trim()) {
		                alert("필수 항목을 모두 입력해주세요.");
		                return;
		            }
		        }
		
		        // 데이터 준비 (DTO 필드명과 일치)
		        var data = {
		            facility_code: document.getElementById('facilityCode').value,
		            facility_manager: document.getElementById('facilityManager').value,
		            installation_date: document.getElementById('installationDate').value,
		            facility_name: document.getElementById('facilityName').value,
		            facility_location: document.getElementById('facilityLocation').value,
		            inspection_cycle: document.getElementById('inspectionCycle').value,
		            remarks: document.getElementById('remarks').value
		        };
		
		        // AJAX로 수정 요청
		        fetch('${pageContext.request.contextPath}/p_eqUpdate', {
		            method: 'POST',
		            headers: { 'Content-Type': 'application/json' },
		            body: JSON.stringify(data)
		        })
		        .then(response => response.text())
		        .then(result => {
		            if(result === "true" || result === "success") {
		                alert("수정 성공!");
		                location.reload();
		            } else {
		                alert("수정 실패!");
		            }
		        })
		        .catch(() => alert("서버 오류!"));
		    });
		
		    // 수정취소 버튼
		    cancelButton.addEventListener('click', function() {
		    	// 체크박스 초기화
		    	document.querySelectorAll('input[name="check"]').forEach(cb => cb.checked = false);
		    	
		        document.getElementById('facilityCode').readOnly = false;
		        document.querySelectorAll('.buttons button').forEach(button => {
		            button.style.display = 'inline-block';
		            
		            // 필드 초기화
		            document.getElementById('facilityCode').value = "";
		            document.getElementById('facilityManager').value = "";
		            document.getElementById('installationDate').value = new Date().toISOString().substring(0, 10);
		            document.getElementById('facilityName').value = "";
		            document.getElementById('facilityLocation').value = "";
		            document.getElementById('inspectionCycle').value = "";
		            document.getElementById('remarks').value = "";

		        });
		        completeButton.remove();
		        cancelButton.remove();
		    });
		});


		// 전체 체크기능
		function selectAll(selectAllCheckbox) {
		    const checkboxes = document.getElementsByName('check');
		    for (let checkbox of checkboxes) {
		        checkbox.checked = selectAllCheckbox.checked;
		    }
		}

		function updateSelectAll() {
		    const selectAllCheckbox = document.getElementById('selectAll');
		    const checkboxes = document.getElementsByName('check');
		    selectAllCheckbox.checked = Array.from(checkboxes).every(checkbox => checkbox.checked);
		}

		// 개별 체크박스에 이벤트 리스너 추가
		document.addEventListener('DOMContentLoaded', function() {
		    const checkboxes = document.getElementsByName('check');
		    for (let checkbox of checkboxes) {
		        checkbox.addEventListener('change', updateSelectAll);
		    }
		});

// 		// 수정 폼 숨기기
// 		function hideUpdateForm() {
// 		    document.getElementById('updateForm').style.display = 'none';
// 		}

		// 수정 폼 표시
// 		function showUpdateForm(facilityCode, facilityManager, installationDate, facilityName, facilityLocation, inspectionCycle, remarks) {
// 		    document.getElementById('updateFacilityCode').value = facilityCode;
// 		    document.getElementById('updateFacilityManager').value = facilityManager;
// 		    document.getElementById('updateInstallationDate').value = installationDate;
// 		    document.getElementById('updateFacilityName').value = facilityName;
// 		    document.getElementById('updateFacilityLocation').value = facilityLocation;
// 		    document.getElementById('updateInspectionCycle').value = inspectionCycle;
// 		    document.getElementById('updateRemarks').value = remarks;

// 		    document.getElementById('updateForm').style.display = 'block';
// 		}

		// 등록 버튼 클릭 시 required 속성 추가
		document.querySelector('.insert1').addEventListener('click', function() {
		    console.log("등록 클릭")
		    
		    
		    document.querySelectorAll(".form-row input").forEach(input => {
		        if (input.id !== "remarks") {
		            input.setAttribute("required", "");
		        }
		    });
		});
	
        </script>
</body>
</html>
