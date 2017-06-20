package com.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="admin")
public class Admin {

	int adminId;
	String adminName;
	String password;
}
