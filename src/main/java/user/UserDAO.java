package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import review.Review;

/*DAO : 데이터베이스 접근 객체 약자
실질적으로 데이터베이스에서 회원정보를 불러오거나 데이터베이스에 회원정보를 넣고자 사용*/
public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	// DB 연결
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/MB_DB";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 로그인 
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // 데이터 조회
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공 (비밀번호 일치)
				} else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}

	// 회원가입 
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES(?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserNickname());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public User getAccount(String userID) {
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		User user = new User();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user.setUserID(rs.getString("userID"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserName(rs.getString("userName"));
				user.setUserNickname(rs.getString("userNickname"));
				user.setUserEmail(rs.getString("userEmail"));
			
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public List<Review> getReviews(String userID) {
		String SQL = "select review.movieID, rate, movieName, content, imgUrl from review inner join movie on review.movieID = movie.movieID where userID = ?";
		List<Review> reviews = new ArrayList<Review>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Review rev = new Review();
				rev.setMovieCD(rs.getString("movieID"));
				rev.setRate(rs.getDouble("rate"));
				rev.setMovieName(rs.getString("movieName"));
				rev.setContent(rs.getString("content"));
				rev.setImgUrl(rs.getString("imgUrl"));
				reviews.add(rev);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reviews;
	}
	
	public List<Favorite> getFavorites(String userID) {
		String SQL = "select favorite.movieID, movieName, rateAvg, imgUrl from favorite inner join movie on favorite.movieID = movie.movieID where userID = ?;";
		List<Favorite> favorites = new ArrayList<Favorite>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Favorite favorite = new Favorite();
				favorite.setMovieID(rs.getInt(1));
				favorite.setMovieName(rs.getString(2));
				favorite.setRateAvg(rs.getInt(3));
				favorite.setImgUrl(rs.getString(4));
				favorites.add(favorite);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return favorites;
	}
}
