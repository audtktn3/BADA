<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	 <%
	 	String path = request.getRealPath("fileFolder");
		 
	 	int size = 1024 * 1024 * 10; //10m
	 	String file = "";
	 	String orifile = "";
	 	
	 	try{
	 		MultipartRequest multi = new MultipartRequest(request, path, size, "EUC-KR", new DefaultFileRenamePolicy());
	 		
	 		Enumeration files = multi.getFileNames();
	 		String str = (String)files.nextElement();
	 		
	 		file = multi.getFilesystemName(str);
	 		orifile = multi.getOriginalFileName(str);
	 		
	 	} catch (Exception e) {
	 		e.printStackTrace();
	 	}
	
	 %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
</body>
</html>