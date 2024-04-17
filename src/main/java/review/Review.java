package review;
import java.util.Date;
public class Review {
    private int reviewID;
    private String userID;
    private String userNickname;
    private String movieCD;
    private String movieName;
    private Double rate;
    private String content;
    private Date regDate;
    private String imgUrl;
    
    public Review() {}
    public Review(int reviewID, String userID, String userNickname, String movieCD, String movieName, Double rate,
            String content, Date regDate, String imgUrl) {
        super();
        this.reviewID = reviewID;
        this.userID = userID;
        this.userNickname = userNickname;
        this.movieCD = movieCD;
        this.movieName = movieName;
        this.rate = rate;
        this.content = content;
        this.regDate = regDate;
        this.imgUrl = imgUrl;
    }
    public int getReviewID() {
        return reviewID;
    }
    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }
    public String getUserID() {
        return userID;
    }
    public void setUserID(String userID) {
        this.userID = userID;
    }
    public String getUserNickname() {
        return userNickname;
    }
    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname;
    }
    public String getMovieCD() {
        return movieCD;
    }
    public void setMovieCD(String movieCD) {
        this.movieCD = movieCD;
    }
    public String getMovieName() {
        return movieName;
    }
    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }
    public Double getRate() {
        return rate;
    }
    public void setRate(Double rate) {
        this.rate = rate;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public Date getRegDate() {
        return regDate;
    }
    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }
    public String getImgUrl() {
        return imgUrl;
    }
    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }
    
    
}