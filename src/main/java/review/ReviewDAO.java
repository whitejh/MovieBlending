package review;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class ReviewDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    public ReviewDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/MB_DB?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
            String dbID = "root";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
            
        }
    }
    public int write(String userID, String userNickname, String movieCD, String movieName, Double rate, String content, String imgUrl) {
        String SQL = "INSERT INTO review(userID, userNickname, movieCD, movieName, rate, content, imgUrl) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.setString(2, userNickname);
            pstmt.setString(3, movieCD);
            pstmt.setString(4, movieName);
            pstmt.setDouble(5, rate);
            pstmt.setString(6, content);
            pstmt.setString(7, imgUrl);
             
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            
        } finally {
            
        }
        return -1; // 데이터베이스 오류
    }
    
    public Review getUserReview(String userID) {
        String SQL = "SELECT * FROM review WHERE userID = ?";
        Review review = new Review();
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                review.setUserID(rs.getString("userID"));
                review.setUserNickname(rs.getString("userNickname"));
                review.setMovieCD(rs.getString("movieCD"));
                review.setMovieName(rs.getString("movieName"));
                review.setRate(rs.getDouble("rate"));
                review.setContent(rs.getString("content"));
                review.setRegDate(rs.getDate("regDate"));
                review.setImgUrl(rs.getString("imgUrl"));
            }
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return review;
    }
    
    public List<Review> getMovieReviews(String userID) {
        String SQL = "select userNickname, movieCD, movieName, rate, content, imgUrl from review where userID = ?";
        List<Review> review = new ArrayList<Review>();
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Review rev = new Review();
                rev.setUserNickname(rs.getString("userNickname"));
                rev.setMovieCD(rs.getString("movieCD"));
                rev.setMovieName(rs.getString("movieName"));
                rev.setRate(rs.getDouble("rate"));
                rev.setContent(rs.getString("content"));
                rev.setImgUrl(rs.getString("imgUrl"));
                review.add(rev);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return review;
    }
}