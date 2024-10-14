<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.Connection, java.util.*,hk.shoppingcart.dao.*,java.sql.SQLException, hk.shoppingcart.connection.DBConnection, hk.shoppingcart.model.*"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ProductDao pd = new ProductDao(DBConnection.getConnection());
List<Product> products = pd.getAllProducts();

ArrayList<Cart> cart_list =(ArrayList<Cart>) session.getAttribute("cart-list");
if(cart_list != null){
	request.setAttribute("cart_list", cart_list);
}
%>


<!DOCTYPE html>
<html>
<head>
<title>Shopmate - Home</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f0f0f0;
}

.container {
	width: 80%;
	margin: auto;
	padding-top: 50px; /* Space for the navbar */
}

/* Banner styling */
.banner {
	width: 100%;
	height: 400px; /* Adjust as needed */
	background: url('product-images/banner.jpg') no-repeat center center/cover;
	display: flex;
	justify-content: center;
	align-items: center;
	color: white;
	font-size: 3rem;
	font-weight: bold;
	margin-top:50px;
	text-align: center;
}

h2 {
	text-align: center;
	margin-bottom: 100px;
	font-size: 2rem;
	color: #333;
}

/* Cards styling */
.cards-wrapper {
	display: flex;
	flex-wrap: wrap;
	justify-content: center; /* Center-align the cards */
	gap: 20px; /* Space between the cards */
}

.card {
	position: relative;
	width: calc(33.333% - 20px); /* 3 cards in a row */
	height: auto;
	border-radius: 15px;
	overflow: hidden;
	background: linear-gradient(135deg, #ff758c, #ff7eb3);
	transition: transform 0.4s ease-in-out, box-shadow 0.4s ease-in-out;
}

.card:hover {
	transform: scale(1.05);
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
}

.card img {
	width: 100%;
	height: 300px; /* Ensure consistent height */
	object-fit: fill; /* Ensures the image fits within the card without distortion */
}

.card-overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.6);
	color: #fff;
	display: flex;
	flex-direction: column;
	justify-content: flex-end;
	padding: 20px;
	opacity: 0;
	transition: opacity 0.4s ease;
}

.card:hover .card-overlay {
	opacity: 1;
}

.card-title {
	font-size: 1.5rem;
	margin: 10px 0;
}

.price, .category {
	font-size: 1.2rem;
}

.buttons {
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
}

.buttons a {
	text-decoration: none;
	padding: 10px 20px;
	color: #fff;
	background-color: #ff6f61;
	border-radius: 10px;
	transition: background-color 0.3s ease;
}

.buttons a:hover {
	background-color: #ff9f80;
}

/* Ensure the last row of cards is centered */
.cards-wrapper .card:nth-child(2) {
	margin: 0 auto;
}
</style>
<%@ include file="Includes/head.jsp"%>
</head>
<body>
	<%@ include file="Includes/navbar.jsp"%>

	<!-- Banner Section -->
	<div class="banner">
		Welcome to Our Shop
	</div>

	<!-- Products Section -->
	<div class="container">
		<h2>Products</h2>
		<div class="cards-wrapper">
		<% 
			if(!products.isEmpty()){
				for(Product p:products){ %>
					<div class="card">
						<img src="product-images/<%= p.getImage() %>" alt="Product Image">
						<div class="card-overlay">
							<h5 class="card-title"><%=p.getName() %></h5>
							<h6 class="price">₹<%= p.getPrice() %></h6>
							<h6 class="category"><%= p.getCategory() %></h6>
							<div class="buttons">
								<a href="add-to-cart?id=<%= p.getId() %>">Add to Cart</a> <a href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>
							</div>
						</div>
					</div>
			<% 	}
			}
		%>
		</div>
	</div>

	<%@ include file="Includes/footer.jsp"%>
</body>
</html>
