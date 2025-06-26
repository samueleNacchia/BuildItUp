package controller.functions;


import java.util.*;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import model.Newsletter.NewsletterDAO;
import model.Newsletter.NewsletterDTO;
import model.Product.ProductDTO;
import model.ProductImage.ProductImageDTO;
import java.util.Properties;
import java.sql.SQLException;
import jakarta.activation.DataHandler;
import jakarta.mail.util.ByteArrayDataSource;




public class MailService {

    public static void inviaEmail(ProductDTO product, ProductImageDTO copertina) {

    	String host = "smtp.gmail.com";              
        String from = "builditup25tsw@gmail.com";         
        String password = "dokc ahib jihg shep";   

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.starttls.enable", "true"); 
        props.put("mail.smtp.auth", "true");


        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });
        
        NewsletterDAO nws = new NewsletterDAO();
        
        try {
        	
        	List<NewsletterDTO> utenti = nws.findAll(); 

            for(NewsletterDTO iscritto : utenti) {
            	
    	        try {
    	            Message msg = new MimeMessage(session);
    	            msg.setFrom(new InternetAddress(from));
    	            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(iscritto.getEmail()));
    	            msg.setSubject("Dai un'occhiata a questo nuovo prodotto!");
    	            String htmlContent = "<h2>" + product.getName() + "</h2>"
    	                    + "<p>" + product.getDescription() + "</p>"
    	                    + "<p><strong>Prezzo: €" + product.getPrice() + "</strong></p>"
    	                    + "<img src=\"cid:copertinaimg\" style='max-width:300px; border-radius:8px;'/>";

    	            
    	            MimeBodyPart htmlPart = new MimeBodyPart();
    	            htmlPart.setContent(htmlContent, "text/html; charset=utf-8");
  	            
    	            
    	            Multipart multipart = new MimeMultipart("related");
    	            multipart.addBodyPart(htmlPart);
    	            
    	            
    	            if(copertina != null) {
    	            	MimeBodyPart imagePart = new MimeBodyPart();
    	            	ByteArrayDataSource imageDataSource = new ByteArrayDataSource(copertina.getImage(), "image/jpeg");
    	            	imagePart.setDataHandler(new DataHandler(imageDataSource));
        	            imagePart.setHeader("Content-ID", "<copertinaimg>");
        	            imagePart.setDisposition(MimeBodyPart.INLINE); 
        	            multipart.addBodyPart(imagePart);
    	            }
    	            
    	             	            
    	           
    	            
    	            msg.setContent(multipart);


    	            Transport.send(msg);
    	        } catch (MessagingException e) {
    	            e.printStackTrace();
    	        }
    	        
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }
}
