package model.ProductImage;

public class ProductImageDTO {
	
    private int id;
    private int id_product;
    private byte[] image;
    private boolean isCover;
      
    
    public ProductImageDTO() {
    	isCover = false;
    }
    
    public ProductImageDTO(int id_product, byte[] image) {
        this.id_product = id_product;
        this.image = image;
    }
    
    public ProductImageDTO(int id_product, byte[] image, boolean isCover) {
        this.id_product = id_product;
        this.image = image;
        this.isCover = isCover;
    }

    public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getIdProduct() {
		return id_product;
	}
	public void setIdProduct(int id_product) {
		this.id_product = id_product;
	}

	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	
	public boolean isCover() {
		return isCover;
	}
	public void setCover(boolean isCover) {
		this.isCover = isCover;
	}

}