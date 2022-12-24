<%@page import="post.Post"%>
<%@page import="post.PostDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
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
		} else {
			PostDAO dao = new PostDAO();
			int result = dao.delete(postID);

			if (result == -1) {
				PrintWriter pw = response.getWriter();
				pw.println("<script>");
				pw.println("alert('Post deletion failed.')");
				pw.println("history.back()");
				pw.println("</script>");
			} else {
				PrintWriter pw = response.getWriter();
				pw.println("<script>");
				pw.println("location.href = 'main.jsp'");
				pw.println("</script>");
			}
		}
	%>
</body>
</html>