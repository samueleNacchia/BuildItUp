package model.Newsletter;

public class NewsletterDTO {
	
	private String email;
	
	
	public NewsletterDTO() {
	}
	
	public NewsletterDTO(String email) {
		this.email = email;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
