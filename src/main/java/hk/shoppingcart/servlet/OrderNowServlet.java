package hk.shoppingcart.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hk.shoppingcart.connection.DBConnection;
import hk.shoppingcart.dao.OrderDao;
import hk.shoppingcart.model.Cart;
import hk.shoppingcart.model.Order;
import hk.shoppingcart.model.User;

/**
 * Servlet implementation class OrderNowServlet
 */
@WebServlet("/order-now")
public class OrderNowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try(PrintWriter out = response.getWriter()){
            
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // Correct date format
            Date date = new Date(); 
            User auth = (User) request.getSession().getAttribute("auth");
            
            if(auth != null) {
                String productId = request.getParameter("id");
                int productQuantity = Integer.parseInt(request.getParameter("quantity"));
                
                if(productQuantity <= 0) {
                    productQuantity = 1;
                }
               
                // Create Order object
                Order orderModel = new Order();
                orderModel.setId(Integer.parseInt(productId));
                orderModel.setuId(auth.getId());
                orderModel.setQuantity(productQuantity);
                orderModel.setDate(formatter.format(date));
                
                // Insert order
                OrderDao orderDao = new OrderDao(DBConnection.getConnection());
                boolean result = orderDao.insertOrder(orderModel);
                
                if(result) {
                	ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
    				if(cart_list != null) {
    					for(Cart c:cart_list) {
    						if(c.getId() == Integer.parseInt(productId)) {
    							cart_list.remove(cart_list.indexOf(c));
    							break;
    						}
    					}
    				}
                    response.sendRedirect("orders.jsp");
                } else {
                    out.print("Order Failed");
                }
                
            } else {
                response.sendRedirect("login.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}