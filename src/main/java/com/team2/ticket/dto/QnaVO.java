package com.team2.ticket.dto;

import java.sql.Date;
import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class QnaVO {
	

	private int qseq; 
	@NotNull (message="제목을 입력하세요")
	@NotEmpty(message="제목을 입력하세요")
	private String subject;
	@NotNull (message="내용을 입력하세요")
	@NotEmpty(message="내용을 입력하세요")
	private String content;
	private String reply;
	private String id; 
	private String rep;
	private Timestamp indate;
	@NotNull (message="카테고리를 입력하세요")
	@NotEmpty(message="카테고리를 입력하세요")
	private String kind;
	private int replycnt;
	
}
