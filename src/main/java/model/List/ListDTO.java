package model.List;
import java.time.LocalDateTime;

import model.TypeList;
/*
CREATE TABLE Lists (
    ID int primary key not null.,
    ID_user int, -- NULL per utenti anonimi
    type enum('cart', 'wishlist') not null,
    updated_at timestamp default CURRENT_TIMESTAMP
);

CREATE TABLE ItemList (
    ID_list int not null,
    ID_product int not null,
    quantity int default 1 check (quantity > 0),
    foreign key ID_list references Lists(id) on delete cascade,
    foreign key ID_product references Products(ID), 
    primary key (ID_list, ID_product)
);  */
public class ListDTO {
	private int id;
	private int id_user;
	private TypeList type;
	private LocalDateTime lastAccess;
	
	public ListDTO() {
	}
	
	public ListDTO(int id, TypeList type, LocalDateTime lastAccess) {
		this.id = id;
		//this.id_user = -1;
		this.type = type;
		this.lastAccess = lastAccess;
	}
	
	public ListDTO(int id, int id_user, TypeList type, LocalDateTime lastAccess) {
		this.id = id;
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

	public TypeList getType() {
		return type;
	}
	public void setType(TypeList type) {
		this.type = type;
	}

	public LocalDateTime getLastAccess() {
		return lastAccess;
	}
	public void setLastAccess(LocalDateTime lastAccess) {
		this.lastAccess = lastAccess;
	}
	
}
