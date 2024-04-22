<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css" />
</head>

<body>
    <div class="subHeader">
        
    </div>
    <div class="sub">
        <span class="title">리뷰 수정</span>
        <div class="reviewSubBox">
            <img class="posterImgSub" src="../images/Exhuma.jpg">
            <span class="movieNameSub">파묘</span><br>
            <div class="starBox">
                <img class="star" src="../images/star.fill@2x.png">
                <img class="star" src="../images/star.fill@2x.png">
                <img class="star" src="../images/star.fill@2x.png">
                <img class="star" src="../images/star.fill@2x.png">
                <img class="star" src="../images/star.fill@2x.png">
                <span class="movieRate">&nbsp;5.0 / 5.0</span><br>
            </div>
            <span class="reviewDes"></span>
        </div>
        <textarea name="description" cols="60" rows="10"></textarea>
        <input class="update" type="submit" onclick="window.close()" value="내용 수정">
    </div>
</body>
</html>