package com.team2.ticket.dto;

import java.sql.Timestamp;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

import lombok.Data;

@Data
public class GoodsVO {
	private int gseq;
	@NotEmpty(message="상품명을 입력하세요.")
	@NotNull(message="상품명을 입력하세요.")
	private String name;
	@NotEmpty(message="상품 분류를 입력하세요.")
	@NotNull(message="상품 분류를 입력하세요.")
	private String kind;
	@NotNull(message="재고를 입력하세요.")
	@Min(1)
	private Integer num_inventory;
	@NotNull(message="원가를 입력하세요.")
	@Min(1)
	private Integer price1;
	@NotNull(message="판매가를 입력하세요.")
	@Min(1)
	private Integer price2;
	private Integer price3;
	private String content;
	@NotEmpty(message="상품 대표 이미지를 입력하세요.")
	@NotNull(message="상품 대표 이미지를 입력하세요.")
	private String image;
	@NotEmpty(message="상품 상세 이미지를 입력하세요.")
	@NotNull(message="상품 상세 이미지를 입력하세요.")
	private String detail_img;
	private String useyn;
	private String bestyn;
	private Timestamp indate;
}
