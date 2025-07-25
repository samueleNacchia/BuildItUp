package model.Order;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import model.Status;
import model.User.UserDTO;

public class OrderDTO {
	private int id;
	private int id_user;
	private LocalDate orderDate;
	private Status status;
	private String via;
	private int roadNum;
	private String postalCode;
	private String provincia;
	
	
	public OrderDTO(){
	}
	
	public OrderDTO(UserDTO user, LocalDate orderDate) {
		this.id_user = user.getId();
		this.orderDate = orderDate;
	}
	
	public OrderDTO(int id_user, LocalDate orderDate) {
		this.id_user = id_user;
		this.orderDate = orderDate;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public int getId_user() {
		return id_user;
	}
	public void setId_user(int id_user) {
		this.id_user = id_user;
	}

	public LocalDate getOrderDate(){
		return orderDate;
	}
	public void setOrderDate(LocalDate orderDate) {
		this.orderDate = orderDate;
	}

	public Status getStatus() {
		return status;
	}
	public void setStatus(Status status) {
		this.status = status;
	}
	
	public String getOrderDateFormatted() {
	    return orderDate != null ? orderDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
	}
	
	public String getStatusName() {
	    return status != null ? status.name() : "";
	}
	public String getVia() {
		return via;
	}
	public void setVia(String via) {
		this.via = via;
	}
	
	public int getRoadNum() {
		return roadNum;
	}
	public void setRoadNum(int roadNum) {
		this.roadNum = roadNum;
	}
	
	public String getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	
	
	public String getProvincia() {
		return provincia;
	}
	public void setProvincia(String prov) {
		this.provincia= prov;
	}
}
