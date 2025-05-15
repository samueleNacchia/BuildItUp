package model;

public class UserDTO {
	private  int id;
	private String email;
	private String password;
	private String name;
	private String surname;
	private String via;
	private int roadNum;
	private String postalCode;
	private String tel;
	
	public UserDTO() {
	}
	
	public UserDTO(String email, String password, String name, String surname, String via, int roadNum, String postalCode, String tel) {
		this.email = email;
		this.password = password;
		this.name = name;
		this.surname = surname;
		this.via = via;
		this.roadNum = roadNum;
		this.postalCode = postalCode;
		this.tel = tel;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
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
	
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
}
