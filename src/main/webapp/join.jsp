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
<script src="https://kit.fontawesome.com/981a29d539.js"
	crossorigin="anonymous"></script>
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
	<div class="container">
		<div class="row">
			<div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
				<div class="card border-0 shadow rounded-3 my-5">
					<div class="card-body p-4 p-sm-5">
						<h5 class="card-title text-center mb-5 fw-light fs-5">Sign up</h5>
						<form method="post" action="joinAction.jsp">
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput"
									placeholder="ID" name="userID" maxlength="20"> <label
									for="floatingInput">ID</label>
							</div>
							<div class="form-floating mb-3">
								<input type="password" class="form-control"
									id="floatingPassword" placeholder="Password"
									name="userPassword" maxlength="20"> <label
									for="floatingPassword">Password</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="floatingInput"
									placeholder="Name" name="userName" maxlength="20"> <label
									for="floatingInput">Name</label>
							</div>
							<div class="form-group mb-3" style="text-align: center;">
								<label class="form-check form-check-inline"> <input
									class="form-check-input" type="radio" name="userGender"
									value="Male"> <span class="form-check-label">
										Male </span>
								</label> <label class="form-check form-check-inline"> <input
									class="form-check-input" type="radio" name="userGender"
									value="Female"> <span class="form-check-label">
										Female</span>
								</label>
							</div>
							<div class="form-floating mb-3">
								<input type="email" class="form-control" id="floatingInput"
									placeholder="Email address" name="userEmail" maxlength="20">
								<label for="floatingInput">Email address</label>
							</div>
							<div class="d-grid">
								<button class="btn btn-primary btn-login text-uppercase fw-bold"
									type="submit">Register</button>
							</div>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>

	<!-- JavaScript Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
</html>