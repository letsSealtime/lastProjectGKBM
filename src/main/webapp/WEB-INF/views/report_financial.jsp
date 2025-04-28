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
        body { font-family: Arial, sans-serif; padding: 20px; }
        h1, h2 { margin-top: 30px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #aaa; padding: 8px; text-align: center; }
        #financialChart { margin-top: 40px; }
    </style>
</head>
<body>

<h1>경영 실적 리포트</h1>

<!-- 기간 필터 -->
<section>
    <h2>기간 필터</h2>
    <label>시작일: <input type="date" id="startDate" /></label>
    <label>종료일: <input type="date" id="endDate" /></label>
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
            
            console.log("label", label, "total_sales", d.total_sales, "operating_profit", d.operating_profit, "net_profit", d.net_profit, "report_date", d.report_date);
            
            row.innerHTML = `
                <td>\${month}</td>
                <td>\${d.total_sales}</td>
                <td>\${d.operating_profit}</td>
                <td>\${d.net_profit}</td>
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
