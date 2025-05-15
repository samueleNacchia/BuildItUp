package model;

public class ProductDTO {
/*CREATE TABLE Products(	
  ID int primary key auto_increment,
  name char(50),
  category enum('CPU', 'GPU', 'MOBO', 'CASE', 'COOLING', 'RAM', 'MEM', 'PSU'),
  description char(50),
  price decimal(10,2) unsigned,
  discount float unsigned,
  isOnSale boolean,
  stocks int unsigned,
  image1 blob,
  image2 blob,
  image3 blob
);*/
	
    private int id;
    private String name;
    private Category category; 
    private String description;
    private float price;
    private float discount;
    private boolean isOnSale;
    private int stocks;
      
    

    // Costruttore
    public ProductDTO() {
    }
    
    public ProductDTO(String name, Category category, String description, float price, float discount, boolean isOnSale, int stocks) {
    	this.name = name;
    	this.category = category;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.isOnSale = isOnSale;
        this.stocks= stocks;
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
	
}