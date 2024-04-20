package com.conan.domain;

import lombok.Data;

@Data
public class Favorite {
	private String movieCd;
	private String userID;
	private String movieNm;
	private Double rate;
	private String imgUrl;
	private boolean state;
}
