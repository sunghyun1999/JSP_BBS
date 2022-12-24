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
		<form method="post" action="writeAction.jsp">
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">Title</label>
				<input type="text" class="form-control" name="postTitle"
					maxlength="50">
			</div>
			<div class="mb-3">
				<label for="exampleFormControlTextarea1" class="form-label">Content</label>
				<textarea class="form-control" style="height: 350px"
					name="postContent" maxlength="2048"></textarea>
			</div>
			<button class="btn btn-primary float-end" type="submit">Complete</button>
		</form>
	</div>

	<!-- JavaScript Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
</html>