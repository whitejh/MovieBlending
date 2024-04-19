package com.conan.domain;

import lombok.Data;

@Data
public class Favorite {
	private int movieID;
	private String movieNm;
	private int rateAvg;
	private Double rate;
	private String imgUrl;
}
