<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>불량률 리포트</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        h2 { margin-bottom: 10px; }
        #unitSelect { margin-bottom: 20px; }
        canvas { max-width: 800px; }
    </style>
</head>
<body>

    <h2>⚠불량률 추이 리포트</h2>

    <!-- 단위 선택 필터 -->
    <label for="unitSelect">단위 선택: </label>
    <select id="unitSelect">
        <option value="month">월별</option>
        <option value="week">주별</option>
        <option value="quarter">분기별</option>
    </select>

    <!-- 차트 출력 -->
    <canvas id="defectChart"></canvas>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const unitSelect = document.getElementById("unitSelect");
        const ctx = document.getElementById("defectChart").getContext("2d");
        let chart = null;

        function loadDefectData(unit = "month") {
            fetch(`/report/defect?unit=${unit}`)
                .then(res => {
                    if (!res.ok) throw new Error("네트워크 오류");
                    return res.json();
                })
                .then(data => renderChart(data))
                .catch(err => console.error("불량률 로딩 오류:", err));
        }

        function renderChart(data) {
            const labels = data.map(d => d.defect_date);  // defect_date alias or DTO field명 맞춰야 함
            const rates = data.map(d => d.defect_rate);

            if (chart) chart.destroy();

            chart = new Chart(ctx, {
                type: "line",
                data: {
                    labels: labels,
                    datasets: [{
                        label: "불량률 (%)",
                        data: rates,
                        fill: false,
                        borderColor: "#ff3c3c",
                        tension: 0.1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { position: 'top' }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: value => value + "%"
                            }
                        }
                    }
                }
            });
        }

        // 단위 선택 시 재요청
        unitSelect.addEventListener("change", () => {
            const selected = unitSelect.value;
            loadDefectData(selected);
        });

        // 초기 로딩 (월별)
        loadDefectData();
    });
    </script>

</body>
</html>