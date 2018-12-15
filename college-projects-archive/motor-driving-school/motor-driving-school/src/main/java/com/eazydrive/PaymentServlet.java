/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eazydrive;

import com.instamojo.wrapper.api.Instamojo;
import com.instamojo.wrapper.api.InstamojoImpl;
import com.instamojo.wrapper.exception.ConnectionException;
import com.instamojo.wrapper.exception.InvalidPaymentOrderException;
import com.instamojo.wrapper.model.PaymentOrder;
import com.instamojo.wrapper.response.CreatePaymentOrderResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Aditya
 */
public class PaymentServlet extends HttpServlet {

    private static final String CLIENT_ID = "eIgQVN9JzmOSUUC1Q4aRNVHNoDXbI3CJROxg7Zxs";
    private static final String CLIENT_SECRET = "8kevGVWp3BxGzWHIwpjwhJ0XMWipGWTOVAFcEApQMG3Or3Z1q0uOrp9ERa8kOyE6T4jXR3rs87C0SuOHLhnMlf7lO7agmQGcvYpPjBnjjO91Zs7vdmmrk4abB9aF20SF";
    private static final String API_ENDPOINT = "https://api.instamojo.com/v2/";
    private static final String AUTH_ENDPOINT = "https://www.instamojo.com/oauth2/token/"; 
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet PaymentServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet PaymentServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//
//            
//        }

        PaymentOrder order = new PaymentOrder();
        order.setName("Aditya K");
        order.setEmail("aaaa@aaaa.aaaa");
        order.setPhone("9898989898");
        order.setCurrency("INR");
        order.setAmount(200D);
        order.setDescription("Test transaction");
        order.setRedirectUrl("http://localhost");
        order.setTransactionId("fonnif");
        
        Instamojo api = null;
        
        try
        {
            api = InstamojoImpl.getApi(CLIENT_ID, CLIENT_SECRET, API_ENDPOINT, AUTH_ENDPOINT);
        }
        catch(Exception e)
                {
                    e.printStackTrace();
                }
        boolean isOrderValid = order.validate();
        
        if(isOrderValid)
        {
            try
            {
                CreatePaymentOrderResponse createPaymentOrderResponse = api.createNewPaymentOrder(order);
                System.out.println(createPaymentOrderResponse.getPaymentOrder().getStatus());
                // insert records after successful payment...
            }
            catch(InvalidPaymentOrderException ex)
            {
                Logger.getLogger(PaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
                
            } catch (ConnectionException ex) {
                Logger.getLogger(PaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public void insertRecords(String name, String phoneNo, String emailId, String pwd, String packName, Date dateOfBirth)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/driving_school","root","windows");
            PreparedStatement addRec = con.prepareStatement("INSERT INTO person (Name,Password,Email,DOB,PhoneNum,Type,Pid) VALUES (?,?,?,?,?,?,LAST_INSERT_ID() + 1)");
            addRec.setString(1,name);
            addRec.setString(2, pwd);
            addRec.setString(3, emailId);
            addRec.setDate(4, dateOfBirth);
            int noOfRows = addRec.executeUpdate();
            if(noOfRows > 0)
            {
                System.out.println("Inserted !!!!!!");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
}
