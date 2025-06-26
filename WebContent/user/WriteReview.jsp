<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recensione</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_review.css">

</head>
<body>

<div class="page-wrapper">
    <%@ include file="/common/header.jsp" %>

    <main class="homepage">
    
    <br><br><br>
    
    <div class="review-form-container">
        <h2>Scrivi una Recensione</h2>
        <p>Condividi la tua esperienza.</p>

        <form action="${pageContext.request.contextPath}/user/ReviewServlet" method="post" class="review-form">
            <input type="hidden" name="productId" value="${param.productId}" />

            <label for="vote">Valutazione:</label>
			<div class="star-rating">
			    <input type="radio" id="star5" name="vote" value="5" required><label for="star5" title="5 stelle"></label>
			    <input type="radio" id="star4" name="vote" value="4" required><label for="star4" title="4 stelle"></label>
			    <input type="radio" id="star3" name="vote" value="3" required><label for="star3" title="3 stelle"></label>
			    <input type="radio" id="star2" name="vote" value="2" required><label for="star2" title="2 stelle"></label>
			    <input type="radio" id="star1" name="vote" value="1" required><label for="star1" title="1 stella"></label>
			</div>

			<br><br>

            <label for="text">Recensione:</label>
            <textarea name="text" id="text" rows="6" placeholder="Scrivi qui la tua recensione..." required maxlength="100"></textarea>

			<br><br>

            <button type="submit">Invia Recensione</button>
        </form>
    </div>
    
  
    </main>
 
    
</div>
	<%@ include file="/common/footer.jsp" %>
</body>
</html>