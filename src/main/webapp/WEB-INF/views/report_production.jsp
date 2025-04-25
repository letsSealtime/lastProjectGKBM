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
	padding: 20px;
}

h1, h2 {
	margin-top: 30px;
}

table {
	border-collapse: collapse;
	width: 100%;
	margin-top: 20px;
}

th, td {
	border: 1px solid #aaa;
	padding: 8px;
	text-align: center;
}

#productionChart {
	margin-top: 40px;
}
</style>
</head>
<body>

	<h1>생산 실적 리포트</h1>

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
		<canvas id="productionChart" width="800" height="400"></canvas>
	</section>

	<!-- 테이블 -->
	<section>
		<h2>📋 생산 실적 내역</h2>
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
        fetch(`/report/production?unit=${unit}`)
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
        const labels = data.map(d => d.period);
        const values = data.map(d => d.totalProduction);

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
                responsive: true,
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
                <td>${d.period}</td>
                <td>${d.totalProduction}</td>
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