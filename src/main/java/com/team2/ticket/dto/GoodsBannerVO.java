package com.team2.ticket.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class GoodsBannerVO {
	private int gbseq;
	private String name;
	private Integer order_seq;
	private String image;
	private String link;
	private String mobile;
	private String useyn;
	private Timestamp indate;
}
