<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 실적 리포트</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	margin: 0;
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

select {
	padding: 5px 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
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

canvas {
	margin-top: 30px;
	display: block;
	margin-left: auto;
	margin-right: auto;
	background-color: #fff;
	padding: 10px;
	border-radius: 8px;
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

	<h1>생산 실적 리포트</h1>

	<div class="report_btn_area">
		<a href="${pageContext.request.contextPath}/report/page"><button class="report_btn">경영 리포트</button></a>
		<a href="${pageContext.request.contextPath}/report/production_page"><button class="report_btn">생산 리포트</button></a>
		<a href="${pageContext.request.contextPath}/report/defect_page"><button class="report_btn">불량률 추이</button></a>
	</div>
	

	<!-- 단위 선택 -->
	<section>
		<label>단위: <select id="unitSelect">
				<option value="month">월별</option>
				<option value="week">주별</option>
				<option value="quarter">분기별</option>
		</select>
		</label>
	</section>

	<!-- 차트 -->
	<section>
		<h2>생산량 차트</h2>
		<canvas id="productionChart" width=400" height="400"></canvas>
	</section>

	<!-- 테이블 -->
	<section>
		<h2>생산 실적 내역</h2>
		<table>
			<thead>
				<tr>
					<th>기간</th>
					<th>생산량</th>
				</tr>
			</thead>
			<tbody id="productionTableBody">
				<!-- JS에서 동적 삽입 -->
			</tbody>
		</table>
	</section>

	<script>
document.addEventListener("DOMContentLoaded", function () {
    const ctx = document.getElementById("productionChart").getContext("2d");
    const unitSelect = document.getElementById("unitSelect");
    let chart = null;

    function loadProductionData(unit = "month") {
		const contextPath = "${pageContext.request.contextPath}";
    	
        fetch(contextPath + `/report/production?unit=month`)
            .then(res => {
                if (!res.ok) throw new Error("서버 오류");
                return res.json();
            })
            .then(data => {
                renderChart(data);
                renderTable(data);
            })
            .catch(err => console.error("생산 데이터 오류:", err));
    }

    function renderChart(data) {
    	console.log(data.period);
        const labels = data.map(d => d.period);
        const values = data.map(d => d.total_production);

        if (chart) chart.destroy();

        chart = new Chart(ctx, {
            type: "pie",
            data: {
                labels: labels,
                datasets: [{
                    label: "생산량",
                    data: values,
                    borderWidth: 1
                }]
            },
            options: {
                responsive: false,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });
    }

    function renderTable(data) {
        const tbody = document.getElementById("productionTableBody");
        tbody.innerHTML = "";
        data.forEach(d => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>\${d.period}</td>
                <td>\${d.total_production}</td>
            `;
            tbody.appendChild(row);
        });
    }

    unitSelect.addEventListener("change", () => {
        loadProductionData(unitSelect.value);
    });

    // 초기 로딩
    loadProductionData();
});
</script>

</body>
</html>