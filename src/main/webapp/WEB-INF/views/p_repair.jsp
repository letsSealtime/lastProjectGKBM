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
	width: 90%;
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
		<span class="별">* 모두기입</span>

		<!-- 검색 폼 -->
		<form method="post" action="p_re" class="form" id="mainForm">
			<span>설비코드 or 설비명</span> <input type="text" name="searchKeyword"
				placeholder="검색어를 입력하세요">
			<button type="submit">검색</button>
		</form>

		<form method="post" action="p_re" class="form">
			<div class="form-fields">
				<div class="form-row">
					<label for="facilityCode">설비코드<span class="별"> *</span></label> <select
						id="facilityCode" name="facilityCode" required>
						<option value="">설비코드 선택</option>
						<c:forEach var="facility" items="${facilityCodes}">
							<option value="${facility.facility_code}">${facility.facility_code}</option>
						</c:forEach>
					</select> <label for="repairItem">수리항목<span class="별"> *</span></label> <select
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
					</select>

				</div>

				<div class="form-row">
					<label for="facilityName">설비명<span class="별"> *</span></label> <input
						type="text" id="facilityName" name="facilityName" required
						readonly> <label for="requester">의뢰자<span
						class="별"> *</span></label> <input type="text" id="requester"
						name="requester" required>
				</div>

				<div class="form-row">
					<label for="repairDetails">수리내역<span class="별"> *</span></label> <input
						type="text" id="repairDetails" name="repairDetails" required>
					<label for="requestDate">의뢰일자<span class="별"> *</span></label> <input
						type="date" id="requestDate" name="requestDate" required>
				</div>

				<div class="form-row">
					<label for="remarks">비고사항</label> <input type="text" id="remarks"
						name="remarks">
				</div>
			</div>

			<!-- 버튼 영역 -->
			<div class="buttons">
				<c:if test="${user.grade == 2}">
					<button type="button" class="buttons search1">조회</button>
				</c:if>
				<c:if test="${user.grade == 1}">
					<button type="submit" value="insert" class="buttons insert1"
						name="action">등록</button>
					<button type="button" class="buttons search1">조회</button>
					<button type="submit" value="update" class="buttons update1"
						name="action">수정</button>
					<button type="submit" value="delete" class="buttons delete1"
						name="action">삭제</button>
				</c:if>
			</div>
		</form>

		<!-- 설비 목록 테이블 -->
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>설비코드</th>
					<th>설비명</th>
					<th>의뢰자</th>
					<th>수리항목</th>
					<th>수리내역</th>
					<th>의뢰일자</th>
					<th>비고사항</th>
				</tr>
			</thead>

			<tbody id="table-body">
				<c:forEach items="${repairs}" var="dto">
					<tr>
						<td><input type="checkbox" name="check"
							value="${dto.repair_id}"></td>
						<td>${dto.facility_code}</td>
						<td>${dto.facility_name}</td>
						<td>${dto.repair_requester}</td>
						<td>${dto.repair_item}</td>
						<td>${dto.repair_details}</td>
						<td>${dto.repair_request_date}</td>
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

		<script>
		
		document.addEventListener('DOMContentLoaded', function() {
            // 항상 오늘 날짜로 하는 스크립트
            document.getElementById('requestDate').value = new Date().toISOString().substring(0, 10);
            
         // 등록 버튼을 제외한 모든 버튼에서 required 속성 제거
           	document.querySelectorAll('button:not([value="insert"])').forEach(button => {
        		button.addEventListener('click', function() {
            		document.querySelectorAll(".form-fields input, .form-fields select").forEach(input => {
                	input.removeAttribute("required");
            		});
        		});
    		});
         
           	var selectAllCheckbox = document.getElementById('selectAll');
            var checkboxes = document.querySelectorAll('input[name="check"]');

            // 전체 선택 체크박스 이벤트 리스너
            selectAllCheckbox.addEventListener('change', function() {
                checkboxes.forEach(function(checkbox) {
                    checkbox.checked = selectAllCheckbox.checked;
                });
            });

            // 개별 체크박스 이벤트 리스너
            checkboxes.forEach(function(checkbox) {
                checkbox.addEventListener('change', function() {
                    var allChecked = true;
                    checkboxes.forEach(function(cb) {
                        if (!cb.checked) {
                            allChecked = false;
                        }
                    });
                    selectAllCheckbox.checked = allChecked;
                });
            });
            
         	

            // 설비코드 선택 시 설비명 자동 입력
            document.getElementById('facilityCode').addEventListener('change', function() {
                var selectedOption = this.options[this.selectedIndex];
                var facilityName = selectedOption.text.split(' - ')[1];
                document.getElementById('facilityName').value = facilityName || '';
            });

         // 삭제 버튼 클릭 이벤트
            document.querySelector('.delete1').addEventListener('click', function(event) {
                event.preventDefault();
                var selectedChecks = [];
                var checkboxes = document.querySelectorAll('input[name="check"]:checked');
                checkboxes.forEach(function(checkbox) {
                    selectedChecks.push(checkbox.value);
                });

                if (selectedChecks.length > 0) {
                    if (confirm("선택한 항목을 삭제하시겠습니까?")) {
                        var form = document.createElement('form');
                        form.method = 'post';
                        form.action = 'p_re';
                        
                        var actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        actionInput.value = 'delete';
                        form.appendChild(actionInput);
                        
                        var checkInput = document.createElement('input');
                        checkInput.type = 'hidden';
                        checkInput.name = 'check';
                        checkInput.value = selectedChecks.join(',');
                        form.appendChild(checkInput);
                        
                        document.body.appendChild(form);
                        form.submit();
                    }
                } else {
                    alert("삭제할 항목을 선택해주세요.");
                }
            });



            // 조회 버튼 클릭 이벤트
            document.querySelector('.search1').addEventListener('click', function() {
                window.location.href = 'p_re?action=all_select';
            });


                // 수정 버튼 클릭 이벤트
                document.querySelector('.update1').addEventListener('click', function () {
                    console.log("수정 클릭");
                    var selectedChecks = document.querySelectorAll('input[name="check"]:checked');
                    
                    if (selectedChecks.length === 1) {
                        var repairId = selectedChecks[0].value; // REPAIR_ID 값 가져오기
                        var selectedRow = selectedChecks[0].closest('tr');
                        var cells = selectedRow.cells;

                        // 폼 필드에 선택된 행의 데이터를 채웁니다
                        document.getElementById('repair_id').value = repairId;
                        document.getElementById('facilityCode').value = cells[1].textContent.trim();
                        document.getElementById('facilityName').value = cells[2].textContent.trim();
                        document.getElementById('requester').value = cells[3].textContent.trim();
                        document.getElementById('repairItem').value = cells[4].textContent.trim();
                        document.getElementById('repairDetails').value = cells[5].textContent.trim();
                        document.getElementById('requestDate').value = cells[6].textContent.trim();
                        document.getElementById('remarks').value = cells[7].textContent.trim();

                        // 기존 버튼들을 숨깁니다
                        document.querySelectorAll('.buttons button').forEach(button => {
                            button.style.display = 'none';
                        });

                        // 수정완료와 수정취소 버튼을 생성하고 표시합니다
                        var completeButton = document.createElement('button');
                        completeButton.textContent = '수정완료';
                        completeButton.type = 'submit';
                        completeButton.name = 'action';
                        completeButton.value = 'update';
                        
                        var cancelButton = document.createElement('button');
                        cancelButton.textContent = '수정취소';
                        cancelButton.type = 'button';

                        document.querySelector('.buttons').appendChild(completeButton);
                        document.querySelector('.buttons').appendChild(cancelButton);

                        // 수정취소 버튼 클릭 이벤트
                        cancelButton.addEventListener('click', function () {
                            // 폼 필드를 초기화합니다
                            document.querySelector('.form').reset();

                            // 원래 버튼들을 다시 표시합니다
                            document.querySelectorAll('.buttons button').forEach(button => {
                                button.style.display = 'block';
                            });

                            // 수정완료와 수정취소 버튼을 제거합니다
                            completeButton.remove();
                            cancelButton.remove();
                        });
                    } else if (selectedChecks.length > 1) {
                        alert("수정 시 하나의 항목만 선택해주세요.");
                    } else {
                        alert("수정할 항목을 선택해주세요.");
                    }
                });

                // facilityCode 선택 시 facilityName 자동 변경
                document.getElementById('facilityCode').addEventListener('change', function () {
                    var selectedOption = this.options[this.selectedIndex];
                    var facilityName = selectedOption.getAttribute('data-facility-name');
                    document.getElementById('facilityName').value = facilityName || '';
                });
            });


            // 폼 제출 전 유효성 검사
            document.getElementById('mainForm').addEventListener('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                }
            });

            function fillFormForUpdate(row) {
                var cells = row.cells;
                document.getElementById('facilityCode').value = cells[1].textContent;
                document.getElementById('facilityName').value = cells[2].textContent;
                document.getElementById('requester').value = cells[3].textContent;
                document.getElementById('repairItem').value = cells[4].textContent;
                document.getElementById('repairDetails').value = cells[5].textContent;
                document.getElementById('requestDate').value = cells[6].textContent;
                document.getElementById('remarks').value = cells[7].textContent;
            }

            function validateForm() {
                var requiredFields = document.querySelectorAll('input[required], select[required]');
                for (var i = 0; i < requiredFields.length; i++) {
                    if (!requiredFields[i].value) {
                        alert('모든 필수 항목을 입력해주세요.');
                        requiredFields[i].focus();
                        return false;
                    }
                }
                return true;
            };
		
		// 등록 버튼 클릭 시 required 속성 추가
		document.querySelector('.insert1').addEventListener('click', function() {
		    console.log("등록 클릭");
		    document.querySelectorAll(".form-fields input, .form-fields select").forEach(input => {
		        if (input.id !== "remarks") {
		            input.setAttribute("required", "");
		        }
		    });
		});
		
		// 수리항목 코드를 한글로 변환하는 함수
	    function getRepairItemName(code) {
	        var repairItems = {
	            'BR001': '브러시 삽입기 부품 교체',
	            'HN001': '손잡이 성형기 노즐 교체',
	            'PK001': '포장기 벨트 교체',
	            'CT001': '칫솔모 절단기 날 교체',
	            'ML001': '손잡이 사출기 히터 교체',
	            'CV001': '컨베이어 벨트 교체',
	            'RB001': '로봇 암 서보모터 교체',
	            'PL001': '플라스틱 압출기 히터 교체',
	            'DR001': '건조기 히터 교체',
	            'ST001': '멸균기 압력 밸브 교체',
	            'LB001': '라벨링 기계 프린트헤드 교체',
	            'SM001': '칫솔모 식모기 정렬 부품 교체',
	            'CL001': '세척기 필터 교체',
	            'VM001': '진공 성형기 실링 교체',
	            'TM001': '트리밍 기계 칼날 교체',
	            'SP001': '스프레이 코팅기 노즐 청소 및 교체',
	            'GR001': '그립 삽입기 정렬 부품 교체',
	            'HT001': '열처리 오븐 히터 교체',
	            'UV001': 'UV 살균기 램프 교체',
	            'WR001': '포장 랩핑기 히터 교체',
	            'PR001': '프린팅 기계 잉크 시스템 청소 및 교체',
	            'AC001': '공기압축기 필터 교체',
	            'MX001': '재료 혼합기 임펠러 교체',
	            'CT002': '칫솔모 컬링기 롤러 교체',
	            'WS001': '세척수 필터 교체',
	            'PD001': '분말 도포기 노즐 교체',
	            'SF001': '안전 센서 시스템 부품 교체',
	            'EL001': '전기 제어 패널 부품 교체'
	        };
	        return repairItems[code] || code;
	    }

	    // 테이블에 데이터를 표시할 때 수리항목 코드를 한글로 변환
	    function updateTable() {
	        var rows = document.querySelectorAll('#table-body tr');
	        rows.forEach(function(row) {
	            var repairItemCell = row.cells[4]; // 수리항목이 있는 열의 인덱스
	            var repairItemCode = repairItemCell.textContent;
	            repairItemCell.textContent = getRepairItemName(repairItemCode);
	        });
	    }

	    // 페이지 로드 시 테이블 업데이트
	    updateTable();

	    // 수리항목 선택 시 한글 설명 표시
	    document.getElementById('repairItem').addEventListener('change', function() {
	        var selectedCode = this.value;
	        var descriptionElement = document.getElementById('repairItemDescription');
	        if (descriptionElement) {
	            descriptionElement.textContent = getRepairItemName(selectedCode);
	        }
	    });

        </script>
	</div>
</body>
</html>
