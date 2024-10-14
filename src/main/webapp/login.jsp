<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.Connection, java.sql.SQLException, hk.shoppingcart.connection.DBConnection, hk.shoppingcart.model.*"%>
	
	<% User auth = (User)request.getSession().getAttribute("auth");
	if(auth != null){
		response.sendRedirect("index.jsp");
	}
	%>
<!DOCTYPE html>
<html>
<head>
<title>Shopping cart - Login</title>
<%@ include file="Includes/head.jsp"%>
<style>
/* Container */
body {
	background-color: #f0f5f9;
	font-family: 'Poppins', sans-serif;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

/* Card */
.card {
	background-color: #ffffff;
	border-radius: 15px;
	box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	transition: transform 0.3s ease-in-out;
}

.card:hover {
	transform: translateY(-10px);
}

/* Card Header */
.card-header {
	background-color: #00aaff;
	color: #fff;
	font-size: 24px;
	padding: 20px;
	border-bottom: none;
	font-weight: 600;
	letter-spacing: 1.2px;
}

/* Card Body */
.card-body {
	padding: 40px;
	animation: fadeIn 1s ease-in;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}

/* Form Labels */
.form-group label {
	color: #333;
	font-weight: 500;
	font-size: 16px;
	margin-bottom: 10px;
}

/* Form Inputs */
.form-control {
	border-radius: 50px;
	border: 2px solid #00aaff;
	padding: 10px 20px;
	font-size: 16px;
	transition: all 0.3s ease;
	box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1);
}

.form-control:focus {
	border-color: #ffaa00;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

/* Button */
.btn-primary {
	background-color: #ffaa00;
	border: none;
	border-radius: 50px;
	margin-top: 20px;
	padding: 10px 25px;
	color: #fff;
	font-size: 18px;
	cursor: pointer;
	transition: background-color 0.3s ease-in-out, transform 0.2s ease;
}

.btn-primary:hover {
	background-color: #ff7700;
	transform: translateY(-5px);
	box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
}

/* Responsive */
@media ( max-width : 768px) {
	.card {
		width: 90%;
	}
}
</style>
</head>
<body>
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">User Login</div>
			<div class="card-body">
				<form action="user-login" method="post">
					<div class="form-group">
						<label>Email:</label> <input type="email" class="form-control"
							name="login-email" placeholder="Enter your email" required>
					</div>
					<div class="form-group">
						<label>Password:</label> <input type="password"
							class="form-control" name="login-password"
							placeholder="Enter your password" required>
					</div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<%@ include file="Includes/footer.jsp"%>
</body>
</html>