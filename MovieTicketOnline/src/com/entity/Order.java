package com.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="order")
public class Order {

	int orderId;
	int userId;
	int movieId;
	int number;
	String address;
	String mobile;
}
