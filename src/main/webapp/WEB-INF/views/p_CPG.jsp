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

input[type="text"] {
	width: 40%;
}

.소모품명 {
	width: 40%;
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

h1 {
	width: 90%;
}

}
.active {
	background-color: #0056b3;
}

.hide {
	display: none;
}

.별 {
	color: red;
}
</style>
</head>

<body>
	<div class="container">
		<h1>◎ 소모품 폐기</h1>

		<span class="별">* 모두기입</span>
		<div class="form">
			<div class="form-fields">
				<div class="form-row">
					<label for="소모품코드">소모품코드<span class="별"> *</span></label> <input
						type="text" id="소모품코드"> <span>소모품명</span><span class="별">
						*</span> <select class="소모품명">
						<option>라텍스장갑</option>
						<option>보안경</option>
						<option>마스크</option>
						<option>헤어넷</option>
						<option>작업복</option>
						<option>안전화</option>
						<option>소독제</option>
						<option>종이타월</option>
						<option>청소용 천</option>
						<option>걸레</option>
						<option>브러시</option>
						<option>진공 청소기 필터</option>
						<option>윤활유</option>
						<option>구리스</option>
						<option>세척제</option>
						<option>부품 세정액</option>
						<option>방청제</option>
						<option>테이프</option>
						<option>완충재</option>
						<option>라벨 스티커</option>
						<option>포장용 끈</option>
						<option>칼</option>
						<option>가위</option>
						<option>마킹 펜</option>
						<option>접착제</option>
						<option>검사용 돋보기</option>
						<option>pH테스트 스트립</option>
						<option>샘플링 백</option>
						<option>품질 검사 스티커</option>
						<option>프린터 잉크 카트리지</option>
						<option>복사용지</option>
						<option>문서파일</option>
						<option>바인터클립</option>
						<option>보드마커</option>
					</select>
				</div>

				<div class="form-row">
					<label for="관리자">관리자<span class="별"> *</span></label> <input
						type="text" id="관리자"> <label for="수량">수량<span
						class="별"> *</span></label> <input type="text" id="수량">
				</div>

				<div class="form-row">
					<label for="폐기사유">폐기사유<span class="별"> *</span></label> <input
						type="text" id="폐기사유"> <label for="폐기일자">폐기일자<span
						class="별"> *</span></label> <input type="date" id="폐기일자">
				</div>

				<div class="form-row">
					<label for="비고사항">비고사항</label> <input type="text" id="비고사항">
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
		</div>
	</div>

	<div id="check"></div>

	<table>
		<thead>
			<tr>
				<th><input type="checkbox" id="체크박스"></th>
				<th>소모품코드</th>
				<th>소모품명</th>
				<th>관리자</th>
				<th>수량</th>
				<th>폐기사유</th>
				<th>폐기일자</th>
				<th>비고사항</th>
			</tr>
			<tr>
				<td><input type="checkbox" id="체크박스"></td>
				<td>NT-100</td>
				<td>니트릴장갑</td>
				<td>김천안</td>
				<td>100</td>
				<td>손상</td>
				<td>2025-02-06</td>
				<td>-</td>
			</tr>
		</thead>
		<tbody id="table-body"></tbody>
	</table>

	<!-- 페이지 넘길때 쓸 버튼들 -->
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
        // 항상 오늘 날짜로 하는 스크립트
        document.getElementById('폐기일자').value = new Date().toISOString().substring(0, 10);

        // 체크박스 템플릿 생성
        const checkboxTemplate = document.createElement('input');
        checkboxTemplate.type = 'checkbox';

        // 행 번호를 갱신하는 함수
        function updateRowNumbers() {
            const rows = document.querySelectorAll("#table-body tr");
            rows.forEach((row, index) => {
                row.cells[1].textContent = index + 1;  // 순번 갱신
            });
        }

        // 새 행을 추가하는 함수
        function addRow(소모품코드, 소모품명, 관리자, 수량, 폐기사유, 폐기일자, 비고사항) {
            const tableBody = document.getElementById("table-body");
            const row = document.createElement("tr");
            const checkbox = checkboxTemplate.cloneNode(true);

            // 개별 체크박스에 이벤트 리스너 추가
            checkbox.addEventListener('change', updateSelectAllCheckbox);

            row.innerHTML = `
        <td></td>
        <td>${tableBody.children.length + 1}</td>
        <td>${소모품코드}</td>
        <td>${소모품명}</td>
        <td>${관리자}</td>
        <td>${수량}</td>
        <td>${폐기사유}</td>
        <td>${폐기일자}</td>
        <td>${비고사항}</td>`;

            row.cells[0].appendChild(checkbox);
            tableBody.appendChild(row);
            updateRowNumbers();
            updateTable();
        }

        // '등록' 버튼 이벤트 리스너
        document.getElementById("등록").addEventListener("click", function () {
            const fields = ["소모품코드", "소모품명", "관리자", "수량", "폐기사유", "폐기일자"];
            const values = fields.map(field => document.getElementById(field).value);

            if (values.some(value => !value)) {
                alert("필수 항목을 모두 올바르게 입력해주세요.");
                return;
            }

            const 비고사항 = document.getElementById("비고사항").value || "";

            addRow(...values, 비고사항);
            clearInputFields();
        });

        // '조회' 버튼 이벤트 리스너
        document.getElementById("조회").addEventListener("click", function () {
            const checkedRows = document.querySelectorAll("#table-body tr input[type='checkbox']:checked");
            const check = [];
            checkedRows.forEach(checkbox => {
                const row = checkbox.closest('tr');
                const cells = row.cells;
                const data = {
                    순번: cells[1].textContent,
                    소모품코드: cells[2].textContent,
                    소모품명: cells[3].textContent,
                    관리자: cells[4].textContent,
                    수량: cells[5].textContent,
                    폐기사유: cells[6].textContent,
                    폐기일자: cells[7].textContent,
                    비고사항: cells[8].textContent
                };
                check.push(data);
            });

            const resultArea = document.getElementById("check");
            resultArea.innerHTML = '';
            check.forEach(item => {
                const p = document.createElement('p');
                p.textContent = `순번: ${item.순번}, 
                소모품코드: ${item.소모품코드}, 
                소모품명: ${item.소모품명}, 
                관리자: ${item.관리자},
                수량: ${item.수량},
                폐기사유: ${item.폐기사유}, 
                폐기일자: ${item.폐기일자}, 
                비고사항: ${item.비고사항}`;
                resultArea.appendChild(p);
            });

            uncheckAllCheckboxes();
        });

        // 입력 필드 초기화 함수
        function clearInputFields() {
            document.querySelectorAll(".form-fields input").forEach(input => {
                if (input.id === '폐기일자') {
                    input.value = new Date().toISOString().substring(0, 10);
                } else {
                    input.value = "";
                }
            });
        }

        // '삭제' 버튼 이벤트 리스너
        document.getElementById("삭제").addEventListener("click", function () {
            const checkedRows = document.querySelectorAll("#table-body tr input[type='checkbox']:checked");

            if (checkedRows.length === 0) {
                alert("삭제할 항목을 1개 이상 체크해주십시오.");
                return;
            }

            if (confirm("삭제 하시겠습니까?")) {
                let deletedCount = 0;

                checkedRows.forEach(checkbox => {
                    checkbox.closest('tr').remove();
                    deletedCount++;
                });

                if (deletedCount > 0) {
                    updateRowNumbers();
                    updateTable();
                }
            }

            uncheckAllCheckboxes();
        });

        // '수정' 버튼 이벤트 리스너
        document.getElementById("수정").addEventListener("click", function () {
            const checkedRows = document.querySelectorAll("#table-body tr input[type='checkbox']:checked");
            if (checkedRows.length !== 1) {
                alert("수정할 항목을 하나만 선택해주세요.");
                return;
            }

            const row = checkedRows[0].closest('tr');
            enterEditMode(row);
        });

        function enterEditMode(row) {
            uncheckAllCheckboxes();
            toggleEditMode(true);

            const editableCells = [2, 3, 4, 5, 6, 7, 8, 9];
            const originalValues = {};

            editableCells.forEach(index => {
                const cell = row.cells[index];
                originalValues[index] = cell.textContent;
                cell.innerHTML = createInputField(index, originalValues[index]);
            });

            const editButtons = createEditButtons();
            document.querySelector('.buttons').appendChild(editButtons);

            document.getElementById("수정완료").addEventListener("click", () => completeEdit(row, editableCells));
            document.getElementById("수정취소").addEventListener("click", () => cancelEdit(row, originalValues, editableCells));
        }

        function toggleEditMode(isEditing) {
            const buttonsContainer = document.querySelector('.buttons');
            const originalButtons = Array.from(document.querySelectorAll('.buttons button'));
            const formRows = document.querySelectorAll('.form-row');

            originalButtons.forEach(button => button.style.display = isEditing ? 'none' : '');
            formRows.forEach(row => row.classList.toggle('hide', isEditing));

            if (!isEditing) {
                document.querySelector('.edit-buttons')?.remove();
            }
        }

        function createEditButtons() {
            const editButtons = document.createElement('div');
            editButtons.className = 'edit-buttons';
            editButtons.innerHTML = `
        <button id="수정완료">수정완료</button>
        <button id="수정취소">수정취소</button>
    `;
            return editButtons;
        }

        function createInputField(index, value) {
            const inputType = index === 8 ? 'date' : 'text';
            return `<input type="${inputType}" value="${value}" style="width: 90%;">`;
        }

        function completeEdit(row, editableCells) {
            editableCells.forEach(index => {
                const input = row.cells[index].querySelector('input');
                row.cells[index].textContent = input.value;
            });
            exitEditMode();
        }

        function cancelEdit(row, originalValues, editableCells) {
            editableCells.forEach(index => {
                row.cells[index].textContent = originalValues[index];
            });
            exitEditMode();
        }

        function exitEditMode() {
            toggleEditMode(false);
            updateRowNumbers();
            updateTable();
        }


        // 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
        function updateSelectAllCheckbox() {
            const allCheckboxes = document.querySelectorAll("#table-body input[type='checkbox']");
            const selectAllCheckbox = document.getElementById("체크박스");
            selectAllCheckbox.checked = allCheckboxes.length > 0 &&
                Array.from(allCheckboxes).every(checkbox => checkbox.checked);
        }

        // 모든 체크박스 해제 함수
        function uncheckAllCheckboxes() {
            document.querySelectorAll("#table-body input[type='checkbox'], #체크박스").forEach(checkbox => {
                checkbox.checked = false;
            });
        }

        // 전체 선택 체크박스 이벤트 리스너
        document.getElementById("체크박스").addEventListener("change", function () {
            const checkboxes = document.querySelectorAll("#table-body input[type='checkbox']");
            checkboxes.forEach(checkbox => checkbox.checked = this.checked);
        });

        // 페이지당 표시할 데이터 수
        const pagedata = 5;

        // 현재 페이지 번호
        let page = 1;

        // 페이지네이션 버튼에 이벤트 리스너 추가
        document.querySelectorAll('.pagination button').forEach(button => {
            button.addEventListener('click', function () {
                const pageText = this.textContent;
                if (pageText === '<') {
                    if (page > 1) {
                        page--;
                    }
                } else if (pageText === '>') {
                    if (page < Math.ceil(tableBody.children.length / pagedata)) {
                        page++;
                    }
                } else {
                    page = parseInt(pageText, 10);
                }
                updateTable();
            });
        });

        // 테이블 업데이트 함수
        function updateTable() {
            const rows = document.querySelectorAll("#table-body tr");
            const startIndex = (page - 1) * pagedata;
            const endIndex = startIndex + pagedata;

            rows.forEach((row, index) => {
                if (index >= startIndex && index < endIndex) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });

            // 페이지네이션 버튼 업데이트
            updatePaginationButtons();
        }

        // 페이지네이션 버튼 업데이트 함수
        function updatePaginationButtons() {
            const buttons = document.querySelectorAll('.pagination button');
            buttons.forEach(button => {
                if (button.textContent === page.toString()) {
                    button.classList.add('active');
                } else {
                    button.classList.remove('active');
                }
            });
        }

        // 초기 테이블 업데이트
        updateTable();

    </script>
</body>

</html>