package com.team2.ticket.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Ticket_productVO {
	
	private Integer tpseq;
	private String name;
	private String showtime;
	private Integer age;
	private String image;
	private String place;
	private String daytime;
	private Integer price1;
	private Integer price2;
	private Integer price3;
	private String bestyn;
	private String sdate;
	private String edate;
	private Timestamp indate;
	private String content;
	private String address;

}
