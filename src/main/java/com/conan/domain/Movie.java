
package com.conan.domain;

public class Movie {
	private String movieCd;
	private String movieNm;
	private String titleEng;
	private String openDt;
	private String genre;
	private String posterUrl;
	private String prdtYear;
	private String director;
	private String actorNm;
	private String company;
	private String rating;
	private String vodUrl;
	private String vodClass;
	private String rate;
	private Integer rank;

	public Movie() {
		super();
	}
	
	//진흥원 데이터 저장 전용 생성자
	public Movie(String movieCd, String movieNm, String openDt) {
		super();
		this.movieCd = movieCd;
		this.movieNm = movieNm;
		this.openDt = openDt;
	}
	
	//기즌 진흥원 생성자 + 포스터 url까지 겸한 생성자
	public Movie(Integer rank, String movieCd, String movieNm, String openDt, String posterUrl) {
		super();
		this.rank = rank;
		this.movieCd = movieCd;
		this.movieNm = movieNm;
		this.openDt = openDt;
		this.posterUrl = posterUrl;
	}

	//kmdb 데이터 저장 전용 생성자
	public Movie(String titleEng, String genre, String prdtYear, String director, String actorNm,
			String company, String rating, String vodUrl, String vodClass) {
		super();
		this.titleEng = titleEng;
		this.genre = genre;
		this.prdtYear = prdtYear;
		this.director = director;
		this.actorNm = actorNm;
		this.company = company;
		this.rating = rating;
		this.vodUrl = vodUrl;
		this.vodClass = vodClass;
	}

	//전체 생성자
	public Movie(String movieCd, String movieNm, String titleEng, String openDt, String genre, String posterUrl,
			String prdtYear, String director, String actorNm, String company, String rating,
			String vodUrl, String vodClass, String rate) {
		super();
		this.movieCd = movieCd;
		this.movieNm = movieNm;
		this.titleEng = titleEng;
		this.openDt = openDt;
		this.genre = genre;
		this.posterUrl = posterUrl;
		this.prdtYear = prdtYear;
		this.director = director;
		this.actorNm = actorNm;
		this.company = company;
		this.rating = rating;
		this.vodUrl = vodUrl;
		this.vodClass = vodClass;
		this.rate = rate;
	}

	public String getMovieCd() {
		return movieCd;
	}

	public void setMovieCd(String movieCd) {
		this.movieCd = movieCd;
	}

	public String getMovieNm() {
		return movieNm;
	}

	public void setMovieNm(String movieNm) {
		this.movieNm = movieNm;
	}

	public String getTitleEng() {
		return titleEng;
	}

	public void setTitleEng(String titleEng) {
		this.titleEng = titleEng;
	}

	public String getOpenDt() {
		return openDt;
	}

	public void setOpenDt(String openDt) {
		this.openDt = openDt;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getPosterUrl() {
		return posterUrl;
	}

	public void setPosterUrl(String posterUrl) {
		this.posterUrl = posterUrl;
	}

	public String getPrdtYear() {
		return prdtYear;
	}

	public void setPrdtYear(String prdtYear) {
		this.prdtYear = prdtYear;
	}

	public String getDirectorNm() {
		return director;
	}

	public void setDirectorNm(String director) {
		this.director = director;
	}

	public String getActorNm() {
		return actorNm;
	}

	public void setActorNm(String actorNm) {
		this.actorNm = actorNm;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getVodUrl() {
		return vodUrl;
	}

	public void setVodUrl(String vodUrl) {
		this.vodUrl = vodUrl;
	}

	public String getVodClass() {
		return vodClass;
	}

	public void setVodClass(String vodClass) {
		this.vodClass = vodClass;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public Integer getRank() {
		return rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}

}
