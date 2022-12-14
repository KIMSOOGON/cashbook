<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// Controller	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null||loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	System.out.println("[helpListAllInsertForm 진입]");

	// parameter값 불러오기
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	Help paramHelp = new Help();
	paramHelp.setHelpNo(helpNo);
	
	// 하나의 help값 불러오기
	HelpDao helpDao = new HelpDao();
	Help oneHelp = helpDao.oneHelp(paramHelp);
	String helpMemo = oneHelp.getHelpMemo();
	String memberId = oneHelp.getMemberId();
	String createdate = oneHelp.getCreatedate();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>GooDee-helpListAll-insert</title>
	
	<!-- Favicons -->
	<link href="<%=request.getContextPath()%>/assets/img/favicon.png" rel="icon">
	<link href="<%=request.getContextPath()%>/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
	<!-- Template Main CSS File -->
	<link href="<%=request.getContextPath()%>/assets/css/style.css" rel="stylesheet">
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css">
</head>
<body id="winter">
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
	<script>AOS.init();</script> 
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="../inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- helpListAll Insert -->
	<section id="pricing" class="pricing" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<div class="container">
			<div class="section-title">
				<span>Add Comment</span>
				<h1>Add Comment</h1>
				<p>답변 추가</p>
			</div>
		</div>
	</section>
	
	<div class="row box mx-4" data-aos="fade-up" data-aos-delay="600" data-aos-duration="1000">
		<div class="box mx-4 pt-5 text-center bg-light col">
			<h3 class="text-primary"><%=helpNo%>번째 문의내용</h3>
			<table class="table table-hover shadow-lg">
				<tr>
					<th>문의내용</th>
					<td><textarea rows="7" cols="50" readonly="readonly"><%=helpMemo%></textarea></td>
				</tr>
				<tr>
					<th>회원ID</th>
					<td><%=memberId%></td>
				</tr>
				<tr>
					<th>문의시각</th>
					<td><%=createdate%></td>
				</tr>
			</table>
		</div>
		
		<div class="box pt-5 mx-4 text-center bg-light col">
			<h3 class="text-primary">답변</h3>
			<form action="<%=request.getContextPath()%>/admin/helpListAllInsertAction.jsp" method="post" id="commentForm">
				<div>
					<input type="hidden" name="helpNo" value="<%=helpNo%>">
				</div>
				<table class="table table-hover shadow-lg">
					<tr>
						<th>답변</th>
						<td><textarea rows="7" cols="50" id="commentMemo" name="commentMemo" placeholder="답변을 입력하세요"></textarea></td>
					</tr>
					<tr>
						<td colspan="2"><button type="button" id="commentBtn" class="btn btn-lg btn-danger">reply</button></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<!-- js로 유효성검사 -->
	<script>
	let commentBtn = document.querySelector('#commentBtn');
	commentBtn.addEventListener('click', function(){
		// 디버깅
		console.log('commentBtn clik!');
		
		// 문의내용 유효성 검사
		let commentMemo = document.querySelector('#commentMemo');
		if(commentMemo.value == ''){
			alert('답변내용을 입력하세요');
			commentMemo.focus();
			return;
		}
		
		let commentForm = document.querySelector('#commentForm');
		commentForm.submit();
	})
	</script>
</body>
</html>