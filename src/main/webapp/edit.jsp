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
		if (userID == null) {
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('This service is available after logging in.')");
			pw.println("location.href = 'login.jsp'");
			pw.println("</script>");
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
		if (!userID.equals(post.getUserID())) {
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('You do not have permission.')");
			pw.println("location.href = 'main.jsp'");
			pw.println("</script>");
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
		<form method="post" action="editAction.jsp?postID=<%=postID%>">
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">Title</label>
				<input type="text" class="form-control" name="postTitle"
					maxlength="50" value="<%=post.getPostTitle()%>">
			</div>
			<div class="mb-3">
				<label for="exampleFormControlTextarea1" class="form-label">Content</label>
				<textarea class="form-control" style="height: 350px"
					name="postContent" maxlength="2048"><%=post.getPostContent()%></textarea>

			</div>
			<button class="btn btn-primary float-end" type="submit">Update</button>
		</form>
	</div>

	<!-- JavaScript Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
</html>