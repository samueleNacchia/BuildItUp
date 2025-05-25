package model.ItemList;

import model.Product.ProductDTO;

public class ItemListDTO {
	private int id_list;
	private int id_product;
	private int quantity;
	private ProductDTO	 product;
	
	public ItemListDTO() {
		quantity = 0;
	}
	
	public ItemListDTO(int id_list, int id_product, int quantity) {
		this.id_list = id_list;
		this.id_product = id_product;
		this.quantity = quantity;
	}

	public int getId_list() {
		return id_list;
	}
	public void setId_list(int id_list) {
		this.id_list = id_list;
	}

	public int getId_product() {
		return id_product;
	}
	public void setId_product(int id_product) {
		this.id_product = id_product;
	}

	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public ProductDTO getProduct() {
		return product;
	}
	public void setProduct(ProductDTO product) {
		this.product = product;
	}
	
}
