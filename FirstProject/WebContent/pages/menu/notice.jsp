<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bbs.BbsDTO"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]>      <html class="no-js"> <!--<![endif]-->
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>CLAN WEB SITE</title>
<link rel="stylesheet" href="../../css/reset.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../../css/common.css">
<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet" href="../../css/responsive.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

</head>
<%
	String memberID = null;
	if(session.getAttribute("memberID") != null) {
		memberID = (String) session.getAttribute("memberID");
	}
	
	if(memberID == null) {
		session.setAttribute("messageType", "오류 메시지");
		session.setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
		response.sendRedirect("../../index.jsp");
		return;
	}
	
	String pageNumber = "1";
	if(request.getParameter("pageNumber") != null) {
		pageNumber = request.getParameter("pageNumber");
	}
	
	try {
		Integer.parseInt(pageNumber);
	} catch(Exception e) {
		session.setAttribute("messageType", "오류 메시지");
		session.setAttribute("messageContent", "페이지 번호가 잘못되었습니다.");
		response.sendRedirect("notice.jsp");
		return;
	}
	
	ArrayList<BbsDTO> bbsList = new BbsDAO().getList(pageNumber);
%>
<!--[if lt IE 7]>
	<p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="#">upgrade your browser</a> to improve your experience.</p>
<![endif]-->
<header>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container-fluid">
			<a class="navbar-brand logo" href="../../index.jsp">clan</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse bg-dark" id="navbarNav">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
						<a class="nav-link active" href="notice.jsp">공지사항</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="member.jsp">클랜원</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="rank.jsp">클랜랭킹</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="game.jsp">경기기록</a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							회원관리
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="../dropmenu/login.jsp">정보수정</a></li>
							<li><a class="dropdown-item" href="master.jsp">클랜관리</a></li>
							<li><a class="dropdown-item" href="../action/logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				</ul>
				<form class="d-flex">
					<input class="form-control me-2" type="search" placeholder="클랜원 검색" aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>
</header>

<section class="menu-section">
	<div class="clan-notice">
		<div class="container">
			<div class="section-title">
				<h3><i class="fa-solid fa-bookmark"></i> <span>clan notice</span></h3>
			</div>
			<div class="section-content">
				<table class="table table-dark table-hover table-striped">
				<thead>
					<tr>
						<th scope="col">Num</th>
						<th scope="col">Title</th>
						<th scope="col">Writer</th>
						<th scope="col">Date</th>
						<th scope="col">Hit</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < bbsList.size(); i++) {
							BbsDTO bbs = bbsList.get(i);
					%>
								<tr>
									<td><%= bbs.getBbsID() %></td>
									<td style="text-align: left;">
										<a href="bbsShow.jsp?bbsID=<%= bbs.getBbsID() %>" style="text-decoration: none; color: inherit;">
								<%
										for (int j = 0; j < bbs.getBbsLevel(); j++) {
								%>
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="16" height="16"><path fill-rule="evenodd" d="M8.22 2.97a.75.75 0 011.06 0l4.25 4.25a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06-1.06l2.97-2.97H3.75a.75.75 0 010-1.5h7.44L8.22 4.03a.75.75 0 010-1.06z"></path></svg>
								<%
										}
										if(bbs.getBbsAvailable() == 0) {
								%>
											(삭제된 게시물입니다.)
								<%
										} else {
								%>
											<%= bbs.getBbsTitle() %>
								<%
										}
								%>
										</a>
									</td>
									<td><%= bbs.getMemberID() %></td>
									<td><%= bbs.getBbsDate() %></td>
									<td><%= bbs.getBbsHit() %></td> 
								</tr>
					<%
						}
					%>
					
					<tr>
						<td colspan="5 ">
							<a class="btn btn-primary float-end" href="bbsWrite.jsp" type="submit">글쓰기</a>
							<ul class="pagination" style="margin: 0 auto;">
							<%
								int startPage = (Integer.parseInt(pageNumber) / 10) * 10 + 1;
								if(Integer.parseInt(pageNumber) % 10 == 0) startPage -= 10;
								int targetPage = new BbsDAO().targetPage(pageNumber);
								if(startPage != 1) {
							%>
									<li><a href="notice.jsp?pageNumber=<%= startPage - 1 %>" class="btn btn-outline-light">이전</a></li>
							<%
								}
								else {
							%>
									<li><a href="#" class="btn btn-outline-light">이전</a></li>
							<%
								}
								for(int i = startPage; i < Integer.parseInt(pageNumber); i++) {
							%>
									<li><a href="notice.jsp?pageNumber=<%= i %>" class="btn btn-secondary"><%= i %></a></li>
							<%		
								}
							%>
								<li class="active"><a href="notice.jsp?pageNumber=<%= pageNumber %>" class="btn btn-secondary"><%= pageNumber %></a></li>
							<%
								for(int i = Integer.parseInt(pageNumber) + 1; i <= targetPage + Integer.parseInt(pageNumber); i++) {
									if(i < startPage + 10) {
							%>
										<li><a href="notice.jsp?pageNumber=<%= i %>" class="btn btn-secondary"><%= i %></a></li>
							<%
									}
								}
								if(targetPage + Integer.parseInt(pageNumber) > startPage + 9) {
							%>
									<li><a href="notice.jsp?pageNumber=<%= startPage + 10 %>" class="btn btn-success">다음</a></li>
							<%
								}
								else {
							%>
									<li><a href="#" class="btn btn-success">다음</a></li>
							<%
								}
							%>
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
		</div>
	</div>
</section>

<footer class="py-3">
	<div class="container">
		<ul class="nav justify-content-center border-bottom pb-3 mb-3">
			<li class="nav-item">
				<a class="nav-link px-2 text-muted" href="notice.jsp">공지사항</a>
			</li>
			<li class="nav-item">
				<a class="nav-link px-2 text-muted active" href="member.jsp">클랜원</a>
			</li>
			<li class="nav-item">
				<a class="nav-link px-2 text-muted" href="rank.jsp">클랜랭킹</a>
			</li>
			<li class="nav-item"><a href="#" class="nav-link px-2 text-muted">FAQs</a></li>
			<li class="nav-item"><a href="#" class="nav-link px-2 text-muted">About</a></li>
		</ul>
		<div class="col-md-4 align-items-center">
			<p class="text-center text-muted">© 2022 Seong Jun</p>
			<ul class="nav col-md-4 justify-content-center list-unstyled">
				<li class="ms-3"><a class="text-muted" href="#"><i class="fa-brands fa-github-square"></i></a></li>
				<li class="ms-3"><a class="text-muted" href="#"><i class="fa-brands fa-instagram-square"></i></a></li>
				<li class="ms-3"><a class="text-muted" href="#"><i class="fa-solid fa-desktop"></i></a></li>
			</ul>
		</div>
	</div>
</footer>
<%
	String messageContent = null;
	if(session.getAttribute("messageContent") != null) {
		messageContent = (String) session.getAttribute("messageContent");
	}
	
	String messageType = null;
	if(session.getAttribute("messageType") != null) {
		messageType = (String) session.getAttribute("messageType");
	}
	
	if(messageContent != null) {
%>
		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header card-header <% if(messageType.equals("오류 메시지")) out.println("bg-warning text-dark"); else out.println("bg-success text-white"); %>">
							<h4 class="modal-title">
								<%= messageType %>
							</h4>
							<button type="button" class="close" aria-label="Close">
							  	<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<%= messageContent %>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
<%
		/* messageContent와 messageType은 서버로 부터 받은 어떠한 세션 값이다 */
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
	}
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script type="text/javascript">

</script>
</body>
</html>