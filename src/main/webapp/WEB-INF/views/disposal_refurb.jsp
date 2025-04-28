<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<style>
body {
	margin: 0;
	padding: 0;
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
}

.form {
	display: flex;
	gap: 15px;
}

.form-row {
	display: flex;
	flex-grow: 1;
	flex-wrap: wrap;
	align-items: center;
	gap: 10px;
}

.form-column {
	flex: 1 1 calc(33% - 20px);
}

.form-row .buttons {
	margin-left: auto;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

label {
	min-width: 60px;
}

input {
	padding: 5px;
	border: 1px solid black;
	border-radius: 5px;
}

.add_input {
	border: 1px solid black;
	padding: 8px;
	text-align: center;
}

button {
	padding: 10px 15px;
	background: #4a90e2;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background: #0056b3;
}

table {
	width: 80%; /* 표의 너비를 80%로 설정 */
	margin: 0 auto; /* 표를 중앙에 위치시키기 위해 margin 설정 */
	border-collapse: collapse;
}

table th, table td {
	border: 1px solid black;
	padding: 8px;
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
	border: 1px solid #ccc;
	border-radius: 5px;
	background: #4a90e2;
	cursor: pointer;
}

.pagination button:hover {
	background: #0056b3;
}

.none {
	display: none;
}

/* 미디어 쿼리 */
@media ( max-width : 768px) {
	.form-row {
		flex-direction: column;
		align-items: center;
	}
	table {
		width: 100%;
	}
}
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<script>
        window.addEventListener("load", init);

        function init() {
        	
        	const pie
        	
        	let re;
        	let dis;
        	
        	 let btn = document.querySelectorAll("button")
	            
	            btn.forEach(function(btn_) {
	            	
	            	btn_.addEventListener("click", () => {
	            		
	            	let value_1 = btn_.closest("tr").querySelector("input").value	
	            	let value_2 = btn_.closest("tr").querySelector("input:not(first-child)").value
	            	let value_3 = btn_.closest("tr").value

	            	let formdata_ = new FormData()
	            	// 리퍼브 수량
	            	formdata_.append("value_1", value_1);
	            	// 폐기 수량
	            	formdata_.append("value_2", value_2);
	            	// 부적합 id
	            	formdata_.append("value_3", value_3);
	            	formdata_.append("load", "add");
	            	
	            	let input = new URLSearchParams(formdata_).toString();

	    			let xhr = new XMLHttpRequest();
	    			
	    			xhr.open("POST", "disable", true);
	    			xhr.setRequestHeader("Content-Type",
	    					"application/x-www-form-urlencoded");
	    			xhr.send(input);
	    			xhr.onload = function() {
	    				
	    				try {
	    					let json = JSON.parse(xhr.responseText);
	    					
	    					dis = json.dis;
	    					re = json.re;
	    				    				
	    				} catch(e) {
	    					console.log("오류")	
	    				}
	    				
	    			}
	            	
	            })
	            
	           })
        	
        	let refurb = {

    				load : "load"

    			}

    			let load = new URLSearchParams(refurb).toString();

    			let xhr = new XMLHttpRequest();

    			xhr.open("POST", "disable", true);
    			xhr.setRequestHeader("Content-Type",
    					"application/x-www-form-urlencoded");
    			xhr.send(load);

    			xhr.onload = function() {
    				console.log("Response:", xhr.responseText);
    				
    				let table = document.querySelector("#table-body")

    				try {
	    				let json = JSON.parse(xhr.responseText);
	    				
	    				json.forEach(function(list) {
	    					
	    					console.log(list)
	    					
	    					// tr 요소 생성
	    		            let tr = document.createElement('tr');
	    		            tr.setAttribute('data-id', list.id);

	    		            // td 요소 생성
	    		            let tdId = document.createElement('td');
	    		            tdId.textContent = list.id;

	    		            let tdCode = document.createElement('td');
	    		            tdCode.textContent = list.code;

	    		            let tdName = document.createElement('td');
	    		            tdName.textContent = list.name;

	    		            let tdCount = document.createElement('td');
	    		            tdCount.textContent = list.count || '';  // count 값이 없으면 빈칸

	    		            let tdType = document.createElement('td');
	    		            tdType.textContent = list.type;

	    		            let tdVendor = document.createElement('td');
	    		            tdVendor.textContent = list.vendor || '';  // vendor 값이 없으면 빈칸

	    		            let tdRefurbQty = document.createElement('td');
	    		            tdRefurbQty.innerHTML = "<input type='number' name='refurb'>";  // 입력창

	    		            let tdDisposalQty = document.createElement('td');
	    		            tdDisposalQty.innerHTML = "<input type='number' name='disposal'>";  // 입력창

	    		            let tdButton = document.createElement('td');
	    		            tdButton.innerHTML = "<button type='button' value='" + list.id + "'>등록</button>";

	    		            // tr에 td 추가
	    		            tr.appendChild(tdId);
	    		            tr.appendChild(tdCode);
	    		            tr.appendChild(tdName);
	    		            tr.appendChild(tdCount);
	    		            tr.appendChild(tdType);
	    		            tr.appendChild(tdVendor);
	    		            tr.appendChild(tdRefurbQty);
	    		            tr.appendChild(tdDisposalQty);
	    		            tr.appendChild(tdButton);

	    		            // table-body에 tr 추가
	    		            table.appendChild(tr);
	    		            
	    		            pie.data.datasets[0].data = [re, dis];
	    		            pie.update();
	    				            
	    				})
    					
    				} catch(e) {
    					console.log("오류")	
    				}
    			};
        	
        	
            let canvas = document.querySelector("#graph");
            canvas.getContext("2d");

            let data = {
                labels: ["부적합", "폐기물"],
                datasets: [{
                    label: "부적합/폐기물 그래프",
                    data: ,
                    backgroundColor: [
                        'rgba(74, 144, 226, 0.6)', // #4a90e2의 반투명 배경색
                        'rgba(0, 86, 179, 0.6)'    // #0056b3의 반투명 배경색
                    ],
                    borderColor: [
                        '#4a90e2', // #4a90e2 선색상
                        '#0056b3'  // #0056b3 선색상
                    ],
                    borderWidth: 2,
                    hoverBackgroundColor: [
                        'rgba(74, 144, 226, 0.8)', // #4a90e2의 조금 더 진한 배경색
                        'rgba(0, 86, 179, 0.8)'    // #0056b3의 조금 더 진한 배경색
                    ]
                }]
            }

            let options = {
                responsive: true,
                plugins: {
                    legend: {
                        position: "top",
                        labels: {
                            font: {
                                size: 14,
                                family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif"
                            },
                            color: "#333"
                        }
                    },
                    title: {
                        display: true,
                        text: "부적합 차트",
                        font: {
                            size: 18,
                            family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif"
                        },
                        color: "#333"
                    },
                    datalabels: {
                        color: "#000000",
                        anchor: "center",
                        align: "center",
                        font: {
                            size: 16,
                            family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif"
                        },
                        formatter: (value) => `${value}`
                    }
                }
            }

            let all = {
                type: "pie",
                data: data,
                options: options,
                plugins: [ChartDataLabels]
            }

            pie = new Chart(canvas, all);

        }
    </script>

</head>

<body>
	<div class="container">
		<h1>◎ 폐기물/리퍼브 관리</h1>
		<table>
			<thead>
				<tr>
					<th>부적합 번호</th>
					<th>제품코드</th>
					<th>제품명</th>
					<th>수량</th>
					<th>원자재/완제품</th>
					<th>회사명</th>
					<th>리퍼브 수량</th>
					<th>폐기 수량</th>
					<th>확정</th>
				</tr>
			</thead>

			<!-- 데이터가 추가됩니다 -->
			<tbody id="table-body">

			</tbody>

		</table>

		<!-- 페이지 넘길때 쓸 버튼들 -->
		<div class="pagination">
			<c:set var="pageCount"
				value="${(line mod viewCount == 0) ? (line div viewCount) : (line div viewCount + 1)}" />
			<c:set var="prevPage" value="${page - viewCount}" />
			<c:set var="nextPage" value="${page + viewCount}" />

			<a href="vendor?page=1"><button>&lt;&lt;</button></a> <a
				href="vendor?page=${prevPage}"><button>&lt;</button></a>

			<c:choose>
				<c:when test="${ page == pageCount }">
					<c:forEach var="i" begin="${ page - (viewCount - 1) }"
						end="${ page }">
						<c:choose>
							<c:when test="${ i == page }">
								<strong><a style="color: red;" href="?page=${i}"><button>${ i }</button></a></strong>
							</c:when>
							<c:otherwise>
								<a href="?page=${i}"><button>${ i }</button></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="i" begin="${ begin }" end="${ end }">
						<c:choose>
							<c:when test="${ i == page }">
								<strong><a style="color: red;" href="?page=${i}"><button>${ i }</button></a></strong>
							</c:when>
							<c:otherwise>
								<a href="?page=${i}"><button>${ i }</button></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<a href="vendor?page=${nextPage}"><button>&gt;</button> </a> <a
				href="vendor?page=${lastPage}"><button>&gt;&gt;</button> </a>
		</div>

		<hr>

		<!-- 내가 체크한것들을 조회버튼을 누르면 추출 -->
		<div id="check"></div>

		<!-- 입력한것을 등록할때 뭐인지 보여줄 칸 -->
		<div class="form-row">
			<div style="flex: 1; display: flex; justify-content: center;">
				<canvas id="graph" width="500" height="300"></canvas>
			</div>
		</div>
	</div>
</body>

</html>
