package model;

import java.time.LocalDate;

public class OrderDTO {
	private int id;
	private int id_user;
	private LocalDate orderDate;
	private Status status;
	
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
	
	
}
