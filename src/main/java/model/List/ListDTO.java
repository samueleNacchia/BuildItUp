package model.List;
import java.time.LocalDateTime;

import model.ListType;

public class ListDTO {
	private int id;
	private String token;
	private int id_user;
	private ListType type;
	private LocalDateTime lastAccess;
	
	public ListDTO() {
		id_user = 0;
	}
	
	public ListDTO(ListType type, LocalDateTime lastAccess) {
		this.type = type;
		this.lastAccess = lastAccess;
	}
	
	public ListDTO(int id_user, ListType type, LocalDateTime lastAccess) {
		this.id_user = id_user;
		this.type = type;
		this.lastAccess = lastAccess;
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

	public ListType getType() {
		return type;
	}
	public void setType(ListType type) {
		this.type = type;
	}

	public LocalDateTime getLastAccess() {
		return lastAccess;
	}
	public void setLastAccess(LocalDateTime lastAccess) {
		this.lastAccess = lastAccess;
	}

	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	
}
