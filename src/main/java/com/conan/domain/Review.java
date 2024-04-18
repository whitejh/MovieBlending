package com.conan.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Review {
	private int reviewID;
	private String userID;
	private String userNickname;
	private String movieCD;
	private String movieNm;
	private Double rate;
	private String content;
	private Date regDate;
	private String imgUrl;
}
