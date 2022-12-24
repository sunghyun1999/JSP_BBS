<%@page import="post.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="post.PostDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
	crossorigin="anonymous">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		int pageNum = 1;
		if (request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
	%>
	<nav class="navbar navbar-expand-lg bg-light">
		<div class="container">
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
			<%
				if (userID == null) {
			%>
			<div class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> Connect </a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="login.jsp">Login</a></li>
					<li><a class="dropdown-item" href="join.jsp">Sign up</a></li>
				</ul>
			</div>
			<%
				} else {
			%>
			<div class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> Account </a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="logoutAction.jsp">Log
							out</a></li>
				</ul>
			</div>
			<%
				}
			%>
		</div>
		</div>
	</nav>
	<div class="container mt-3">
		<p>Welcome! This is a simple bulletin board system implemented by
			JSP.</p>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>Title</th>
					<th>Writer</th>
					<th>Date</th>
				</tr>
			</thead>
			<tbody>
				<%
					PostDAO dao = new PostDAO();
					ArrayList<Post> list = dao.getList(pageNum);
					for (int i = 0; i < list.size(); i++) {
				%>
				<tr>
					<td><%=list.get(i).getPostID()%></td>
					<td><a href="view.jsp?postID=<%=list.get(i).getPostID()%>"><%=list.get(i).getPostTitle()%></a></td>
					<td><%=list.get(i).getUserID()%></td>
					<td><%=list.get(i).getPostDate().substring(0, 16)%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			if (pageNum != 1) {
		%>
		<a href="main.jsp?pageNum=<%=pageNum - 1%>" class="btn btn-light">Prev</a>
		<%
			}
			if (dao.isNextPage(pageNum + 1)) {
		%>
		<a href="main.jsp?pageNum=<%=pageNum + 1%>" class="btn btn-light">Next</a>
		<%
			}
		%>
		<a href="write.jsp" class="btn btn-primary float-end">Post</a>
	</div>

	<!-- JavaScript Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
</html>