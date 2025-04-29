<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경영 실적 리포트</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	margin: 0;
	padding: 0;
}

h1, h2 {
	margin: 30px 0 10px 0;
	text-align: center;
	color: #333;
}

section {
	margin: 20px auto;
	width: 90%;
	max-width: 1200px;
	background: #fff;
	padding: 20px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

label {
	display: inline-block;
	margin: 10px 10px 10px 0;
	font-weight: 500;
}

input[type="date"] {
	padding: 5px 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

#filterBtn {
	padding: 6px 15px;
	font-size: 14px;
	font-weight: bold;
	color: white;
	background-color: #4CAF50;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.2s;
}

#filterBtn:hover {
	background-color: #45a049;
}

table {
	border-collapse: collapse;
	width: 100%;
	margin-top: 20px;
	background-color: white;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
	font-size: 14px;
}

th {
	background-color: #f2f2f2;
	font-weight: bold;
	color: #333;
}

#financialChart {
	margin-top: 30px;
}

.report_btn_area {
	text-align: center;
	margin: 30px 0;
}

.report_btn {
	display: inline-block;
	padding: 10px 20px;
	font-size: 15px;
	font-weight: 500;
	color: #333;
	background-color: #f0f0f0;
	border: 1px solid #ccc;
	border-radius: 6px;
	cursor: pointer;
	text-decoration: none;
	transition: background-color 0.2s, color 0.2s;
	margin: 0 10px;
}

.report_btn:hover {
	background-color: #e0e0e0;
	color: #000;
}
</style>
</head>
<body>

	<h1>경영 실적 리포트</h1>

	<div class="report_btn_area">
		<a href="${pageContext.request.contextPath}/report/page"><button class="report_btn">경영 리포트</button></a>
		<a href="${pageContext.request.contextPath}/report/production_page"><button class="report_btn">생산 리포트</button></a>
		<a href="${pageContext.request.contextPath}/report/defect_page"><button class="report_btn">불량률 추이</button></a>
	</div>

	<!-- 기간 필터 -->
	<section>
		<h2>기간 필터</h2>
		<label>시작일: <input type="date" id="startDate" /></label> <label>종료일:
			<input type="date" id="endDate" />
		</label>
		<button id="filterBtn">조회</button>
	</section>

	<!-- 차트 영역 -->
	<section>
		<h2>월별 실적 차트</h2>
		<canvas id="financialChart"></canvas>
	</section>

	<!-- 테이블 영역 -->
	<section>
		<h2>상세 실적 내역</h2>
		<table>
			<thead>
				<tr>
					<th>월</th>
					<th>매출</th>
					<th>영업이익</th>
					<th>순이익</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody id="financialTableBody">
				<!-- JS로 동적 삽입 -->
			</tbody>
		</table>
	</section>

	<script>
document.addEventListener("DOMContentLoaded", function () {
    const chartCtx = document.getElementById("financialChart").getContext("2d");
    let chart = null;
    
    function fetchFinancialData() {
		const contextPath = "${pageContext.request.contextPath}";
    	
    	fetch(contextPath + `/report/financial`)
            .then(res => {
                if (!res.ok) throw new Error("데이터 불러오기 실패");
                return res.json();
            })
            .then(data => {
                renderChart(data);
                renderTable(data);
            })
            .catch(err => {
                console.error("경영실적 오류:", err);
            });
    }

    function renderChart(data) {
    	const labels = data.map(d => new Date(d.report_date).toISOString().slice(0, 10));
    	const sales = data.map(d => d.total_sales);
        const opProfit = data.map(d => d.operating_profit);
        const netProfit = data.map(d => d.net_profit);

        if (chart) chart.destroy();

        chart = new Chart(chartCtx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: "매출",
                        data: sales,
                        backgroundColor: "rgba(54, 162, 235, 0.6)"
                    },
                    {
                        label: "영업이익",
                        data: opProfit,
                        backgroundColor: "rgba(255, 206, 86, 0.6)"
                    },
                    {
                        label: "순이익",
                        data: netProfit,
                        backgroundColor: "rgba(75, 192, 192, 0.6)"
                    }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    function renderTable(data) {
        const tbody = document.getElementById("financialTableBody");
        tbody.innerHTML = "";
        
        data.forEach(d => {
            const row = document.createElement("tr");
            
            const label = new Date(d.report_date).toISOString().slice(0, 10);
            const month = label.slice(5, 7) + "월";
            const totalSales = d.total_sales.toLocaleString();
            const operatingProfit = d.operating_profit.toLocaleString();
            const netProfit = d.net_profit.toLocaleString();
            
            row.innerHTML = `
                <td>\${month}</td>
                <td>\${totalSales}</td>
                <td>\${operatingProfit}</td>
                <td>\${netProfit}</td>
                <td>\${label}</td>
            `;

            tbody.appendChild(row);
        });
    }

    document.getElementById("filterBtn").addEventListener("click", () => {
        const startDate = document.getElementById("startDate").value;
        const endDate = document.getElementById("endDate").value;
        if (startDate && endDate) {
            const query = `/report/financial?startDate=${startDate}&endDate=${endDate}`;
            fetchFinancialData(query);
        } else {
            alert("시작일과 종료일을 모두 선택해주세요.");
        }
    });

    // 초기 로딩
    fetchFinancialData();
});
</script>

</body>
</html>
