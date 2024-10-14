<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.text.*, java.sql.Connection, java.util.*, java.sql.SQLException, hk.shoppingcart.connection.DBConnection, hk.shoppingcart.model.*, hk.shoppingcart.dao.*"%>

<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProducts = null;
if (cart_list != null) {
	ProductDao pDao = new ProductDao(DBConnection.getConnection());
	cartProducts = pDao.getcartProducts(cart_list);
	double total = pDao.getTotalCartPrice(cart_list);
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("total", total);

}
%>

<!DOCTYPE html>
<html>
<head>
<title>Shopping Cart - Carts</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f5f5f5;
}

.container {
	width: 80%;
	margin: auto;
	padding-top: 120px; /* Ensure no overlap with navbar */
}

h3 {
	font-size: 2rem;
	color: #333;
	margin-bottom: 20px;
}

/* Button Styling */
.btn-primary, .btn-danger, .btn-incre {
	background: linear-gradient(135deg, #ff758c, #ff7eb3);
	border: none;
	color: #fff;
	padding: 10px 20px;
	border-radius: 8px;
	cursor: pointer;
	transition: background 0.3s ease, transform 0.3s ease;
	text-decoration: none;
	display: inline-block;
}

.btn-primary:hover, .btn-danger:hover, .btn-incre:hover {
	background: linear-gradient(135deg, #ff7eb3, #ff758c);
	transform: scale(1.05);
}

/* Table Styling */
table {
	width: 100%;
	border-collapse: collapse;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

thead {
	background-color: #ff758c;
	color: #fff;
}

thead th {
	padding: 15px;
	text-align: left;
	font-size: 1.2rem;
}

tbody td {
	padding: 15px;
	color: #333;
	font-size: 1rem;
	border-bottom: 1px solid #eee;
}

tbody tr:hover {
	background-color: rgba(255, 217, 232, 0.3); /* Adds hover effect */
}

tbody td .form-control {
	width: 50px;
	text-align: center;
	border: none;
	background-color: transparent;
	font-weight: bold;
	color: #333;
}

.d-flex {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.d-flex h3 {
	margin: 0;
}

/* Ensure the quantity controls and the "Buy now" button are aligned */
form.d-flex {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.form-group {
	display: flex;
	align-items: center;
}

/* Make sure the quantity controls are not too wide */
.form-control.text-center {
	width: 60px; /* Control the width of the quantity input */
	text-align: center;
	margin: 0 10px;
}

/* Adjust button spacing */
.btn-primary.ml-3 {
	margin-left: 10px;
}

.btn-incre {
	margin: 0 10px;
	color: #333;
	font-size: 1.2rem;
	background: transparent;
	padding: 5px;
	border: 2px solid #ff7eb3;
	border-radius: 50%;
	transition: color 0.3s ease, background-color 0.3s ease;
}

.btn-incre:hover {
	background-color: #ff7eb3;
	color: white;
}

input.form-control {
	width: 40px;
	padding: 8px;
	border-radius: 5px;
	border: 1px solid #ddd;
	background-color: #f9f9f9;
}

/* Animation for Add/Remove */
@
keyframes bounce { 0%, 100% {
	transform: translateY(0);
}

50








%
{
transform




:translateY




(




-5px




)




;
}
}
.btn-incre i {
	animation: bounce 0.4s ease-in-out infinite;
}

/* Responsive design */
@media ( max-width : 768px) {
	.container {
		width: 95%;
		padding-top: 80px; /* Adjust top padding for smaller screens */
	}
	table thead th, table tbody td {
		font-size: 1rem;
		padding: 10px;
	}
}
</style>
<%@ include file="Includes/head.jsp"%>
</head>
<body>
	<%@ include file="Includes/navbar.jsp"%>

	<div class="container">
		<div class="d-flex py-3">
			<h3>Total Price: ₹ ${(total>=0)?dcf.format(total):0}</h3>
			<a class="mx-3 btn-primary" href="check-out">Check out</a>
		</div>

		<table>
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">Buy now</th>
					<th scope="col">Cancel</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (cart_list != null) {
					for (Cart c : cartProducts) {
				%>
				<tr>
					<td><%=c.getName()%></td>
					<td><%=c.getCategory()%></td>
					<td>₹<%=dcf.format(c.getPrice())%></td>
					<td>
						<form action="order-now" method="post"
							class="d-flex justify-content-between align-items-center">
							<input type="hidden" name="id" value="<%=c.getId()%>"
								class="form-input">

							<!-- Quantity controls with flexbox alignment -->
							<div class="form-group d-flex align-items-center">
								<a class="btn btn-incre"
									href="quantity-inc-dec?action=dec&id=<%=c.getId()%>"> <i
									class="fas fa-minus-square"></i>
								</a> <input type="text" name="quantity"
									class="form-control text-center mx-2"
									value="<%=c.getQuantity()%>" readonly> <a
									class="btn btn-incre"
									href="quantity-inc-dec?action=inc&id=<%=c.getId()%>"> <i
									class="fas fa-plus-square"></i>
								</a>
							</div>

							<!-- Buy now button -->
							<button type="submit" class="btn btn-primary ml-3">Buy
								now</button>
						</form>
					</td>
					<td><a class="btn btn-danger"
						href="remove-from-cart?id=<%=c.getId()%>">Remove</a></td>
				</tr>

				<%
				}
				}
				%>

			</tbody>
		</table>
	</div>

	<%@ include file="Includes/footer.jsp"%>
</body>
</html>
