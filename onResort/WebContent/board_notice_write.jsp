<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="onResort.service.NoticeService"%>
<%@ page import="onResort.service.NoticeServiceImpl"%>
<%@ page import="onResort.dto.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>onResort</title>
</head>
<body>
	<%
		NoticeService noticeService = new NoticeServiceImpl();
		String key = "";
		String title = "";
		String content = "";
		String fileName = "";
		String orgfileName = "";

		String uploadPath = request.getRealPath("upload");

		try {
			MultipartRequest multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "utf-8",
					new DefaultFileRenamePolicy());

			key = multi.getParameter("key");
			title = multi.getParameter("title");
			content = multi.getParameter("content");
			if (key.equals("INSERT")) {
				fileName = multi.getFilesystemName("file");
				orgfileName = multi.getOriginalFileName("file");
				NoticeDto dto = new NoticeDto(title, content, fileName, orgfileName);
				noticeService.insert(dto);
				int n = noticeService.selectOneLastest();
				key = Integer.toString(n);
			} else {
				NoticeDto n = noticeService.selectOne(Integer.parseInt(key));
				if (multi.getFilesystemName("file") != null) { // 새로운 파일 업로드 시
					fileName = multi.getFilesystemName("file");
					orgfileName = multi.getOriginalFileName("file");
				} else {
					if (multi.getParameter("filename") != null) { // 이미 업로드한 파일 그대로 사용 시
						fileName = n.getImgname();
						orgfileName = n.getOrgimgname();
					} else { // 기존 것을 지우고 새로 업로드할 경우
						String fileUrl = "upload/" + n.getImgname();
						if (fileUrl == null) return;

						boolean fileexists = true;
						try {
							ServletContext cxt = getServletConfig().getServletContext();
							String file = cxt.getRealPath(fileUrl);
							File fileEx = new File(file);
							if (fileEx.exists()) {
								fileEx.delete();
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
						fileName = multi.getFilesystemName("file");
						orgfileName = multi.getOriginalFileName("file");
					}
				}
				noticeService.update(Integer.parseInt(key), new NoticeDto(title, content, fileName, orgfileName));
			}

		} catch (Exception e) {
			e.getStackTrace();
		}

		response.sendRedirect("board_notice_view.jsp?key=" + key);
	%>
</body>
</html>
