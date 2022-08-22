package com.team2.ticket.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class IntroVO {
	private int itnum;
	private String title;
	private String content;
	private Timestamp indate;
	private String image;
	private String id;
}