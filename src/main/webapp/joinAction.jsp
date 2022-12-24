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
<jsp:setProperty property="userName" name="user" />
<jsp:setProperty property="userGender" name="user" />
<jsp:setProperty property="userEmail" name="user" />
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

		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
				|| user.getUserGender() == null || user.getUserEmail() == null) {
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('There are items that are not entered.')");
			pw.println("history.back()");
			pw.println("</script>");
		} else {
			UserDAO dao = new UserDAO();
			int result = dao.join(user);

			if (result == -1) {
				PrintWriter pw = response.getWriter();
				pw.println("<script>");
				pw.println("alert('ID already exists.')");
				pw.println("history.back()");
				pw.println("</script>");
			} else {
				session.setAttribute("userID", user.getUserID());
				PrintWriter pw = response.getWriter();
				pw.println("<script>");
				pw.println("location.href = 'main.jsp'");
				pw.println("</script>");
			}
		}
	%>
</body>
</html>