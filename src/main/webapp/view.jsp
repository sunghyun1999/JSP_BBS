<%@page import="java.io.PrintWriter"%>
<%@page import="post.Post"%>
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

		int postID = 0;
		if (request.getParameter("postID") != null) {
			postID = Integer.parseInt(request.getParameter("postID"));
		}
		if (postID == 0) {
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('This is an invalid.')");
			pw.println("location.href = 'main.jsp'");
			pw.println("</script>");
		}

		Post post = new PostDAO().getPost(postID);
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
		<table class="table table-bordered table-sm">
			<thead>
				<tr>
					<th>Title</th>
					<th>Writer</th>
					<th>Date</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=post.getPostTitle()%></td>
					<td><%=post.getUserID()%></td>
					<td><%=post.getPostDate().substring(0, 16)%></td>
				</tr>
				<tr height="350px">
					<td colspan='3'><%=post.getPostContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>
				</tr>
			</tbody>
		</table>
		<%
			if (userID != null && userID.equals(post.getUserID())) {
		%>
		<a href="edit.jsp?postID=<%=postID%>" class="btn btn-light">Edit</a> <a
			onclick="return confirm('Are you sure you want to delete it?')"
			href="deleteAction.jsp?postID=<%=postID%>" class="btn btn-light">Delete</a>
		<%
			}
		%>
		<a href="javascript:window.history.back();"
			class="btn btn-primary float-end">List</a>
	</div>

	<!-- JavaScript Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
</html>