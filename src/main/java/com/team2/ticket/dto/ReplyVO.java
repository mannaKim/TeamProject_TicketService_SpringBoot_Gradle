package com.team2.ticket.dto;

import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class ReplyVO {
	private int replynum;
	private Timestamp wirtedate;
	
	@NotEmpty(message="수정할 댓글을 입력해주세요.")
	@NotNull(message="수정할 댓글을 입력해주세요.")
	private String content;
	
	@NotNull(message="수정할 이벤트 평점을 선택해주세요")
	private int rate;
	private int evnum;
	private String id;
}