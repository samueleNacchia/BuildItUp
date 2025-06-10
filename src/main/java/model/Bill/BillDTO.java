package model.Bill;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class BillDTO {

	private int id_order;
	private float total;
	private LocalDate billDate;
	
	public BillDTO() {
	}
	
	public BillDTO(int id_order, float totale, LocalDate billDate) {
		this.id_order = id_order;
		this.total = totale;
		this.billDate = billDate;
	}
	
	public int getId_order() {
		return id_order;
	}
	public void setId_order(int id_order) {
		this.id_order = id_order;
	}
	
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	
	public LocalDate getBillDate() {
		return billDate;
	}
	public void setBillDate(LocalDate billDate) {
		this.billDate = billDate;
	}
	
	public String getBillDateFormatted() {
	    return billDate != null ? billDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
	}
	
}
