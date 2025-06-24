package model.Product;

import model.Category;

public class ProductDTO {
	
    private int id;
    private String name;
    private Category category; 
    private String description;
    private float price;
    private float discount;
    private boolean isOnSale;
    private int stocks;
    private int numReview;
    private float avgReview;
    
    public ProductDTO() {
    }
    
    public ProductDTO(String name, Category category, String description, float price, float discount, boolean isOnSale, int stocks) {
    	
    	this.name = name;
    	this.category = category;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.isOnSale = isOnSale;
        this.stocks = stocks;
    }

    public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
	    this.name = name;
	}
	
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	
	public String getDescription() {
	    return description;
	}
	public void setDescription(String description) {
	    this.description = description;
	}
	
	public float getPrice() {
		return price;
	}   
	public void setPrice(float price) {
		this.price = price;
	}
	    
	public float getDiscount() {
		return discount;
	}
	public void setDiscount(float discount) {
		this.discount = discount;
	}

	public boolean isOnSale() {
		return isOnSale;
	}
	public void setOnSale(boolean isOnSale) {
		this.isOnSale = isOnSale;
	}

	public int getStocks() {
		return stocks;
	}
	public void setStocks(int stocks) {
		this.stocks = stocks;
	}

	public int getNumReview() {
		return numReview;
	}
	public void setNumReview(int numReview) {
		this.numReview = numReview;
	}

	public float getAvgReview() {
		return avgReview;
	}
	public void setAvgReview(float avgReview) {
		this.avgReview = avgReview;
	}

}