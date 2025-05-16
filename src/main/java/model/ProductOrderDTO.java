package model;

public class ProductOrderDTO {
	private int id_product;
	private int id_order;
	private float price;
	private int quantity;
	
	public ProductOrderDTO() {
	}
	
	public ProductOrderDTO(ProductDTO product, OrderDTO order, float price, int quantity) {	
		this.id_product = product.getId();
		this.id_order = order.getId();
	}
	
	public ProductOrderDTO(int id_product, int id_order, float price, int quantity) {	
		this.id_product = id_product;
		this.id_order = id_order;
	}

	public int getId_product() {
		return id_product;
	}
	public void setId_product(int id_product) {
		this.id_product = id_product;
	}

	public int getId_order() {
		return id_order;
	}
	public void setId_order(int id_order) {
		this.id_order = id_order;
	}

	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
