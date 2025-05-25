package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DataSourceManager;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/image")
public class ViewImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	int id = Integer.parseInt(request.getParameter("id"));
    	String n = request.getParameter("n"); 
        byte[] imageData = null;
        
        String query = "SELECT image"+n+ " FROM Products WHERE ID = ?";
        
        try (Connection connection = DataSourceManager.getDataSource().getConnection();
                PreparedStatement stmt = connection.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            try(ResultSet rs = stmt.executeQuery()){
	            if (rs.next()) 
	                imageData = rs.getBytes("image"+n);
            }   
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (imageData != null) {
            response.setContentType("image/jpeg"); // o image/png
            response.setContentLength(imageData.length);
            response.getOutputStream().write(imageData);
            response.getOutputStream().flush();
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	doGet(request,response);
    }
}
