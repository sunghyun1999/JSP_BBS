<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" scope="page" class="user.User" />
<jsp:setProperty property="userID" name="user" />
<jsp:setProperty property="userPassword" name="user" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('You are already logged in.')");
			pw.println("location.href = 'main.jsp'");
			pw.println("</script>");
		}

		UserDAO dao = new UserDAO();
		int result = dao.login(user.getUserID(), user.getUserPassword());

		if (result == 1) {
			session.setAttribute("userID", user.getUserID());
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("location.href = 'main.jsp'");
			pw.println("</script>");
		} else if (result == 0) {
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('Passwords do not match.')");
			pw.println("history.back()");
			pw.println("</script>");
		} else if (result == -1) {
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('ID does not exist.')");
			pw.println("history.back()");
			pw.println("</script>");
		} else if (result == -2) {
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('A database error has occurred.')");
			pw.println("history.back()");
			pw.println("</script>");
		}
	%>
</body>
</html>