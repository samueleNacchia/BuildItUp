package controller;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Properties;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = request.getParameter("email");
        String userMessage = request.getParameter("message");

        String host = "smtp.gmail.com";              
        String from = "builditup25tsw@gmail.com";         
        String password = "dokc ahib jihg shep";           

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(from));  
            message.setSubject("Messaggio dal sito da: " + userEmail);
            message.setText(userMessage);

            Transport.send(message);

            response.sendRedirect(request.getContextPath() + "/common/contact-status.jsp?status=success");

        } catch (MessagingException e) {
            e.printStackTrace();
            
            response.sendRedirect(request.getContextPath() + "/common/contact-status.jsp?status=fail");
        }
    }
}