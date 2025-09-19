<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Logged Out</title>

    <!-- Optional: Redirect after a few seconds -->
    

    <!-- Bootstrap CSS (Optional for styling) -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-success text-center">
            <h3><%= request.getAttribute("message") %></h3>
            <p>You will be redirected to the login page in a few seconds...</p>
        </div>
    </div>
    <script>
    setTimeout(function() {
        window.location.href = `<%= request.getContextPath() %>/login.jsp`;
    }, 2000); // 2 seconds
</script>
    
</body>

</html>