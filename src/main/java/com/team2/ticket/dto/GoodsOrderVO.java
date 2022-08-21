package com.team2.ticket.dto;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class GoodsOrderVO {
	@NotEmpty(message="이름을 입력하세요.")
	@NotNull(message="이름을 입력하세요.")
	private String name;
	@NotEmpty(message="전화번호를 입력하세요.")
	@NotNull(message="전화번호를 입력하세요.")
	private String phone;
	@NotEmpty(message="주소를 입력하세요.")
	@NotNull(message="주소를 입력하세요.")
	private String zip_num;
	private String address1;
	private String address2;
	private String address3;
	@NotEmpty(message="결제 방식을 선택하세요.")
	@NotNull(message="결제 방식을 선택하세요.")
	private String payment;
}
