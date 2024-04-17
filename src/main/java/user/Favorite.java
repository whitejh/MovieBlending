package user;

public class Favorite {
	private int movieID;
	private String movieName;
	private int rateAvg;
	private String imgUrl;
	
	public int getMovieID() {
		return movieID;
	}
	public void setMovieID(int movieID) {
		this.movieID = movieID;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public int getRateAvg() {
		return rateAvg;
	}
	public void setRateAvg(int rateAvg) {
		this.rateAvg = rateAvg;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	
}