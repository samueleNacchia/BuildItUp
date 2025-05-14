package model;

public class ProductDTO {

    private int id;
    private String name;
    private String description;
    private float price;
    private float discount;
    private boolean isOnSale;
    private int stocks;

    // Costruttore
    public ProductDTO() {
    }

    // Costruttore con tutti i campi
    public ProductDTO(int id, String name, String description, float price, float discount, boolean isOnSale, int stocks) {
        this.id = id;
    	this.name = name;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.isOnSale = isOnSale;
        this.stocks= stocks;
    }
    
    public ProductDTO(String name, String description, float price, float discount, boolean isOnSale, int stocks) {
    	this.name = name;
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

	
 
    @Override
	public String toString() {
		return "ProductDTO [id=" + id + ", name=" + name + ", description=" + description + ", price=" + price
				+ ", discount=" + discount + ", isOnSale=" + isOnSale + ", stocks=" + stocks + "]";
	}
}