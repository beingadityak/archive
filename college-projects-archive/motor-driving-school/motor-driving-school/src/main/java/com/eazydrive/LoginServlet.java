/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eazydrive;

import com.mysql.jdbc.Connection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Aditya
 */
public class LoginServlet extends HttpServlet {

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
           try
           {
            Class.forName("com.mysql.jdbc.Driver");
               Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/driving_school","root","windows");
               PreparedStatement ps = con.prepareStatement("SELECT * FROM person WHERE Email = ? AND Password = ?");
               String uname = request.getParameter("email");
               String pwd = request.getParameter("pwd");
               ps.setString(1,uname);
               ps.setString(2,pwd);
//               System.out.println(uname);
//               System.out.println(pwd);
               if(uname == null && pwd == null)
               {
                   response.sendRedirect("login.jsp");
               }
               ResultSet rs = ps.executeQuery();
               if(rs.next())
               {
                   String type = rs.getString("Type");
                   System.out.println(type);
                   if(type.equals("learner"))
                   {
                       HttpSession sess = request.getSession();
                       sess.setAttribute("username", rs.getString("Email"));
                       sess.setAttribute("type", type);
                       response.sendRedirect("learner/index.jsp");
                   }
                   else if(type.equals("tutor"))
                   {
                       HttpSession sess = request.getSession();
                       sess.setAttribute("username", rs.getString("Email"));
                       sess.setAttribute("type", type);
                       response.sendRedirect("tutor/index.jsp");
                   }
                   else if(type.equals("admin"))
                   {
                       HttpSession sess = request.getSession();
                       sess.setAttribute("username", rs.getString("Email"));
                       sess.setAttribute("type", type);
                       response.sendRedirect("admin/index.jsp");
                   }
                   else
                   {
                       response.sendRedirect("login.jsp");
                   }
               }
               else
                {
                    response.sendRedirect("login.jsp");
                }
           }
           catch (Exception ex) 
            {
                ex.printStackTrace();
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

}
