<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"  %>
<%@ page import="bbs.BbsDAO"  %>
<%@ page import="bbs.Bbs"  %>
<%@ page import="java.util.ArrayList"  %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<title>BADA</title>
	<style type="text/css">
		a, a:hover {
			color: #000000;
			text-decoration:none;
		}
	</style>

	<script type="text/javascript">
	var request = new XMLHttpRequest();
	function searchFunction() {
		request.open("Post","./BbsSearchServlet?bbsTitle=" + encodeURIComponent(document.getElementById("bbsTitle").value), true);
		request.onreadystatechange = searchProcess;
		request.send(null);
	}
	function searchProcess() {
		var table = document.getElementById("ajaxTable");
		table.innerHTML = "";
		if(request.readyState == 4 && request.status == 200) {
			var object = eval ('('+request.responseText +')');
			var result = object.result;
			for(var i = 0; i < result.length; i++) {
				var row = table.insertRow(0);
				for(var j = 0; j < result[i].length; j++){
					var cell = row.insertCell(j);
					cell.innerHTML = result[i][j].value;
				}
			}
		}
	}
	window.onlcad = function() {
		searchFunction();
	}
	

	</script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") !=null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") !=null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
			
		
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">BADA</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
		
			</ul>
			<%
				if(userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropbown">
					<a href ="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href ="login.jsp">로그인</a></li>
						<li><a href ="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<div class="container">
				<div class=" form-group row pull-right">
					<div class="col-xs-8">
						<input class="form-control" id="bbsTitle"  onkeyup="searchFunction()" type="text" size="20">
					</div>
				<div class="col-xs-2">
					<button class="btn btn-primary" onclick="searchFunction();" type="button">검색</button>
				</div>
				</div>	
			</div>
			<% 		
				} else { 	
			 %>
			 <ul class="nav navbar-nav navbar-right">
				<li class="dropbown">
					<a href ="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href ="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			
		
		
			
			
			 <% 
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="bakground=color : @eeeeee; text-align: center">번호</th>
						<th style="bakground=color : @eeeeee; text-align: center">제목</th>
						<th style="bakground=color : @eeeeee; text-align: center">작성자</th>
						<th style="bakground=color : @eeeeee; text-align: center">작성일</th>
					</tr>
				</thead>
				<tbody id="ajaxTable">
						<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
					%>	
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(" ", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11)+ list.get(i).getBbsDate().substring(11,13)+"시"+ list.get(i).getBbsDate().substring(14,16)+"분" %></td>
				   </tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				} if (bbsDAO.nextPage(pageNumber + 1)) {
			%>	
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
				%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
</body>
</html>