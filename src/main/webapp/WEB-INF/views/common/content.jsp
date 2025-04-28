<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MES System Dashboard</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	width: 100%;
	height: 100vh;
	overflow: hidden;
	font-family: Arial, sans-serif;
	align-items: center;
	justify-content: center;
}

.dashboard-container {
	width: 90%;
	max-width: 1200px;
	padding: 15px;
	background: white;
}

.summary-section {
	display: flex;
	gap: 15px;
	margin-bottom: 15px;
	justify-content: space-between;
}

.summary-box {
	flex: 1;
	background: white;
	padding: 15px;
	border-radius: 4px;
	border: 1px solid #ddd;
	text-align: center;
}

.summary-box h4 {
	font-size: 16px;
	color: #666;
	margin-bottom: 5px;
}

.summary-box p {
	font-size: 24px;
	font-weight: bold;
	color: #4a90e2;
}

.charts-section {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	grid-template-rows: repeat(2, 1fr);
	gap: 15px;
}

.chart-box {
	background: white;
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 15px;
}

.chart-box h4 {
	font-size: 16px;
	margin-bottom: 10px;
	color: #333;
}

.chart-container {
	width: 100%;
	height: 250px;
}
</style>
</head>
<body>
	<div class="dashboard-container">
		<div class="summary-section">
			<div class="summary-box">
				<h4>생산량</h4>
				<p id="productionSummary">-</p>
			</div>
			<div class="summary-box">
				<h4>불량률</h4>
				<p id="defectSummary">-</p>
			</div>
			<div class="summary-box">
				<h4>설비가동률</h4>
				<p id="operationSummary">-</p>
			</div>
		</div>
		<div class="charts-section">
			<div class="chart-box">
				<h4>생산실적</h4>
				<div class="chart-container">
					<canvas id="productionChart"></canvas>
				</div>
			</div>
			<div class="chart-box">
				<h4>경영실적</h4>
				<div class="chart-container">
					<canvas id="managementChart"></canvas>
				</div>
			</div>
			<div class="chart-box" style="grid-column: span 2;">
				<h4>불량률 추이</h4>
				<div class="chart-container">
					<canvas id="defectRateChart"></canvas>
				</div>
			</div>
		</div>
	</div>

	<script>
document.addEventListener("DOMContentLoaded", function () {
    const commonOptions = {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                display: true,
                position: 'top',
                labels: {
                    boxWidth: 12,
                    font: {
                        size: 11
                    }
                }
            }
        }
    };

    let productionChart, managementChart, defectRateChart;
    
    function loadSummary() {
		const contextPath = "${pageContext.request.contextPath}";
        Promise.all([
            fetch(contextPath + '/report/production?unit=month').then(res => res.json()),
            fetch(contextPath + '/report/defect?unit=month').then(res => res.json())
        ])
        .then(([productionData, defectData]) => {
            // 생산량 합계
            const totalProduction = productionData.reduce((sum, item) => sum + (item.total_production || 0), 0);

            // 불량률 평균
            const avgDefectRate = defectData.length > 0 
                ? (defectData.reduce((sum, item) => sum + (item.defect_rate || 0), 0) / defectData.length).toFixed(2)
                : 0;

            document.getElementById('productionSummary').innerText = totalProduction.toLocaleString() + "개";
            document.getElementById('defectSummary').innerText = avgDefectRate + "%";
            document.getElementById('operationSummary').innerText = "95%"; // 고정값
        })
        .catch(err => {
            console.error('상단 요약박스 데이터 오류:', err);
        });
    }

    function loadProductionChart() {
		const contextPath = "${pageContext.request.contextPath}";
    	
    	fetch(contextPath + '/report/production')
            .then(res => res.json())
            .then(data => {
            	const labels = data.map(d => d.period);
                const values = data.map(d => d.total_production);

                const ctx = document.getElementById('productionChart').getContext('2d');
                productionChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '월별 생산량',
                            data: values,
                            backgroundColor: 'rgba(54, 162, 235, 0.6)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: commonOptions
                });
            })
            .catch(err => console.error('생산 데이터 오류:', err));
    }

    function loadManagementChart() {
		const contextPath = "${pageContext.request.contextPath}";
    	fetch(contextPath + '/report/financial')
            .then(res => res.json())
            .then(data => {
            	const labels = data.map(d => new Date(d.report_date).toISOString().slice(0, 10));
                const values = data.map(d => d.total_sales);

                const ctx = document.getElementById('managementChart').getContext('2d');
                managementChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '월별 매출액',
                            data: values,
                            borderColor: 'rgba(255, 99, 132, 1)',
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            tension: 0.1,
                            fill: true
                        }]
                    },
                    options: commonOptions
                });
            })
            .catch(err => console.error('경영 데이터 오류:', err));
    }

    function loadDefectRateChart() {
		const contextPath = "${pageContext.request.contextPath}";
    	fetch(contextPath + '/report/defect?unit=month')
            .then(res => res.json())
            .then(data => {
                const labels = data.map(d => d.defect_date);
                const values = data.map(d => d.defect_rate);

                const ctx = document.getElementById('defectRateChart').getContext('2d');
                defectRateChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '월별 불량률 (%)',
                            data: values,
                            borderColor: 'rgba(75, 192, 192, 1)',
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            tension: 0.1,
                            fill: true
                        }]
                    },
                    options: commonOptions
                });
            })
            .catch(err => console.error('불량률 데이터 오류:', err));
    }

    // 전부 로딩
    loadSummary();
    loadProductionChart();
    loadManagementChart();
    loadDefectRateChart();
});
</script>
</body>
</html>
