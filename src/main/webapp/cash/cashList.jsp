<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%
	// Controller : session, request
	// request 년 + 월
	int year = 0;
	int month = 0;
	
	if(request.getParameter("year") == null || request.getParameter("month") == null){ // 입력값 없을 시, 오늘기준
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else { // 연,월 입력값 있을 경우 받아오기
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12일 경우
		if(month == -1){ // 올해 1월에서 작년 12월로 넘어가기
			month = 11;
			year -= 1;
		} 
		if(month == 12){ // 올해 12월에서 내년 1월로 넘어가기
			month = 0;
			year += 1;
		}
	}
	
	// 마지막날짜
	
	// 출력하고자 하는 월과 월의 1일의 요일(일~토, 1~7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일
	// begin blank개수는 firstDay - 1
	
	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // beginBlank + lastDate + endBlank --> 7로 나누어 떨어진다
	if((beginBlank + lastDate) % 7 != 0){
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank;
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(year, month+1);

	// View : 달력출력 + 일별 cash 목록
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashList</title>
</head>
<body>
	<div>
		<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
	</div>
	
	<div>
		<%=year%>년 <%=month+1%>월
	</div>
	<table>
		<tr>
			<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
		</tr>
		<tr>
			<!-- 달력 -->
			<%
				for(int i=1; i<=totalTd; i++){ // 해당 월 1~말일까지 출력
			%>
					<td>
			<%
						int date = i-beginBlank;
						if((i-beginBlank)>0 && (i-beginBlank)<=lastDate){
			%>				
							<%=date%>
			<%				
						}
			%>	
					</td>
			<%
					if(i%7==0){
			%>
						</tr><tr><!-- td 7개 만들고 줄바꿈 -->
			<%
					}
				}
			%>
		</tr>
	</table>
	<div>
		<%
			for(HashMap<String,Object> m : list){
		%>
				<%(Integer)(m.get("cashNo"))%>
		<%
			}
		%>
	</div>
</body>
</html>