package model.Review;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class ReviewDTO {
	
	private int id_user;
	private int id_product;
	private String text;
	private int vote;
	private LocalDate reviewDate;
	
	public ReviewDTO() {
	}
	
	public ReviewDTO(int  id_user, int id_product, String text, int vote, LocalDate reviewDate) {
		this.id_user = id_user;
		this.id_product = id_product;
		this.text = text;
		this.reviewDate = reviewDate;
	}

	public int getId_user() {
		return id_user;
	}
	public void setId_user(int id_user) {
		this.id_user = id_user;
	}

	public int getId_product() {
		return id_product;
	}
	public void setId_product(int id_product) {
		this.id_product = id_product;
	}

	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}

	public int getVote() {
		return vote;
	}
	public void setVote(int vote) {
		this.vote = vote;
	}

	public LocalDate getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(LocalDate reviewDate) {
		this.reviewDate = reviewDate;
	}	
	
	public String getReviewDateFormatted() {
	    return reviewDate != null ? reviewDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
	}
}
