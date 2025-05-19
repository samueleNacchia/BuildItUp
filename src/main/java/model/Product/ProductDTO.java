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
    private byte[] image1;
    private byte[] image3;
    private byte[] image2;
      
    

    // Costruttore
    public ProductDTO() {
    }
    
    public ProductDTO(String name, Category category, String description, float price, float discount, 
    				  boolean isOnSale, int stocks, byte[] image1, byte[] image2, byte[] image3) {
    	
    	this.name = name;
    	this.category = category;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.isOnSale = isOnSale;
        this.stocks = stocks;
        this.image1 = image1;
        this.image2 = image2;
        this.image3 = image3;
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

	public byte[] getImage1() {
		return image1;
	}
	public void setImage1(byte[] image1) {
		this.image1 = image1;
	}
	
	public byte[] getImage2() {
		return image2;
	}
	public void setImage2(byte[] image2) {
		this.image2 = image2;
	}

	public byte[] getImage3() {
		return image3;
	}
	public void setImage3(byte[] image3) {
		this.image3 = image3;
	}

}