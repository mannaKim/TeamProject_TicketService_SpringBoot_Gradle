package com.team2.ticket.dto;

import java.sql.Timestamp;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

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
	@NotEmpty(message="원가를 입력하세요.")
	@NotNull(message="원가를 입력하세요.")
	private int price1;
	@NotEmpty(message="판매가를 입력하세요.")
	@NotNull(message="판매가를 입력하세요.")
	private int price2;
	private int price3;
	@NotEmpty(message="상품 설명을 입력하세요.")
	@NotNull(message="상품 설명을 입력하세요.")
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
