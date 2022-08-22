package com.team2.ticket.dto;

import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class QreplyVO {
	
	private int renum;
	private int qnanum;
	private String id;
	private Timestamp indate;
	@NotEmpty(message="내용을 입력하세요")
	@NotNull(message="내용을 입력하세요")
	private String content;
	
}
