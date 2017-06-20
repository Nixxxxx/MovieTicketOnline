package com.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="user")
public class User {

	int userId;
	String userName;
	String password;
}
