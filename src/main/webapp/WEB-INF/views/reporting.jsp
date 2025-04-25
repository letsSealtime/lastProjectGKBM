<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리포트 대시보드</title>
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        section {
            margin-bottom: 40px;
        }
        canvas {
            max-width: 800px;
            width: 100%;
            height: 400px;
        }
    </style>
</head>
<body>

<h1>📊 리포트 대시보드</h1>

<!-- 생산실적 -->
<section id="productionSection">
    <h2>📦 생산실적</h2>
    <canvas id="productionChart"></canvas>
</section>

<!-- 경영실적 -->
<section id="financialSection">
    <h2>💰 경영실적</h2>
    <canvas id="financialChart"></canvas>
</section>

<!-- 불량률 -->
<section id="defectSection">
    <h2>⚠️ 불량률 추이</h2>
    <canvas id="defectChart"></canvas>
</section>

<script>
document.addEventListener("DOMContentLoaded", function () {
    loadProductionData();
    loadFinancialData();
    loadDefectData();

    function loadProductionData() {
        fetch("/report/production")
            .then(res => res.json())
            .then(data => renderProductionChart(data))
            .catch(err => console.error("생산실적 오류", err));
    }

    function loadFinancialData() {
        fetch("/report/financial")
            .then(res => res.json())
            .then(data => renderFinancialChart(data))
            .catch(err => console.error("경영실적 오류", err));
    }

    function loadDefectData() {
        fetch("/report/defect")
            .then(res => res.json())
            .then(data => renderDefectChart(data))
            .catch(err => console.error("불량률 오류", err));
    }

    function renderProductionChart(data) {
        // 예시: 생산 단위별 파이차트
        const ctx = document.getElementById("productionChart");
        new Chart(ctx, {
            type: "pie",
            data: {
                labels: data.map(d => d.unit_name),
                datasets: [{
                    label: "생산량",
                    data: data.map(d => d.total_quantity)
                }]
            }
        });
    }

    function renderFinancialChart(data) {
        const ctx = document.getElementById("financialChart");
        new Chart(ctx, {
            type: "bar",
            data: {
                labels: data.map(d => d.month),
                datasets: [
                    {
                        label: "매출",
                        data: data.map(d => d.total_revenue)
                    },
                    {
                        label: "영업이익",
                        data: data.map(d => d.operating_income)
                    }
                ]
            }
        });
    }

    function renderDefectChart(data) {
        const ctx = document.getElementById("defectChart");
        new Chart(ctx, {
            type: "line",
            data: {
                labels: data.map(d => d.date),
                datasets: [{
                    label: "불량률",
                    data: data.map(d => d.defect_rate)
                }]
            }
        });
    }
});
</script>

</body>
</html>