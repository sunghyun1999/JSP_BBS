<%@page import="post.PostDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="post" scope="page" class="post.Post" />
<jsp:setProperty property="postTitle" name="post" />
<jsp:setProperty property="postContent" name="post" />
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
			pw.println("location.href = 'main.jsp'");
			pw.println("</script>");
		} else {
			if (post.getPostTitle() == null || post.getPostContent() == null) {
				PrintWriter pw = response.getWriter();
				pw.println("<script>");
				pw.println("alert('There are items that are not entered.')");
				pw.println("history.back()");
				pw.println("</script>");
			} else {
				PostDAO dao = new PostDAO();
				int result = dao.write(post.getPostTitle(), userID, post.getPostContent());

				if (result == -1) {
					PrintWriter pw = response.getWriter();
					pw.println("<script>");
					pw.println("alert('Post registration failed.')");
					pw.println("history.back()");
					pw.println("</script>");
				} else {
					PrintWriter pw = response.getWriter();
					pw.println("<script>");
					pw.println("location.href = 'main.jsp'");
					pw.println("</script>");
				}
			}
		}
	%>
</body>
</html>