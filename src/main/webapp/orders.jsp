<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.text.*, java.sql.Connection, java.util.*, java.sql.SQLException, hk.shoppingcart.connection.DBConnection, hk.shoppingcart.model.*, hk.shoppingcart.dao.*"%>

<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
List<Order> orders = null;
if (auth != null) {
	request.setAttribute("auth", auth);
	orders = new OrderDao(DBConnection.getConnection()).userOrders(auth.getId());
} else {
	response.sendRedirect("login.jsp");
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Shopping cart - Orders</title>
<style>
/* Overall body styling */
body {
    font-family: 'Poppins', sans-serif;
    background-color: #f0f4f7;
    margin: 0;
    padding: 0;
}

.container {
    width: 85%;
    margin: 50px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

/* Card Header Styling */
.card-header {
    font-size: 2rem;
    color: #333;
    font-weight: 600;
    border-bottom: 2px solid #f7a9a8;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

/* Table Styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

thead {
    background-color: #f7a9a8;
    color: #fff;
}

thead th {
    padding: 15px;
    text-align: left;
    font-size: 1.2rem;
}

tbody td {
    padding: 15px;
    font-size: 1rem;
    border-bottom: 1px solid #ddd;
    color: #333;
}

/* Table Row Hover */
tbody tr:hover {
    background-color: #fde6e6; /* Subtle hover effect */
    transition: background-color 0.3s ease-in-out;
}

/* Button Styles */
.btn-danger {
    background-color: #f27474;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 8px;
    cursor: pointer;
    text-decoration: none;
    transition: background-color 0.3s, transform 0.3s ease;
}

.btn-danger:hover {
    background-color: #e53935;
    transform: scale(1.05);
}

/* Animation */
@keyframes bounce {
    0%, 100% {
        transform: translateY(0);
    }
    50% {
        transform: translateY(-5px);
    }
}

.btn-danger:hover {
    animation: bounce 0.5s ease-in-out infinite;
}

/* Media Queries for Mobile Responsiveness */
@media (max-width: 768px) {
    .container {
        width: 95%;
        padding: 10px;
    }

    table thead th, table tbody td {
        padding: 10px;
        font-size: 1rem;
    }
}

</style>
<%@ include file="Includes/head.jsp"%>
</head>
<body>
    <%@ include file="Includes/navbar.jsp"%>

    <div class="container">
        <div class="card-header my-3">All Orders</div>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">Date</th>
                    <th scope="col">Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Price</th>
                    <th scope="col">Cancel</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if(orders != null){
                        for(Order o:orders){%>
                        <tr>
                            <td><%=o.getDate()%></td>
                            <td><%=o.getName()%></td>
                            <td><%=o.getCategory()%></td>
                            <td><%=o.getQuantity()%></td>
                            <td>₹<%=dcf.format(o.getPrice())%></td>
                            <td><a class="btn btn-danger" href="cancel-order?id=<%=o.getOrderId()%>">Cancel</a></td>    
                        </tr>
                        <%}
                    }
                %>
            </tbody>
        </table>
    </div>

    <%@ include file="Includes/footer.jsp"%>
</body>
</html>
