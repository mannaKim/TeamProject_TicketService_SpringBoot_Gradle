package com.team2.ticket.dto;

import java.sql.Timestamp;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class EventVO {
	
	private int evnum;
	
	@NotEmpty(message="제목을 입력해주세요.")
	@NotNull(message="제목을 입력해주세요.")
	private String title;
	
	@NotEmpty(message="이벤트날짜를 입력해주세요.")
	@NotNull(message="이벤트날짜를 입력해주세요.")
	private String evdate;
	
	@NotEmpty(message="당첨자날짜를 입력해주세요.")
	@NotNull(message="당첨자날짜를 입력해주세요.")
	private String evperson;
	private String eimage;
	private String eimage2;
	
	private int readcount;
	private Timestamp indate;
	private String id;
	
}
