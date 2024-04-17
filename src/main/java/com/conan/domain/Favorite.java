package com.conan.domain;

import lombok.Data;

@Data
public class Favorite {
	private int movieID;
	private String movieName;
	private int rateAvg;
	private String imgUrl;
}
