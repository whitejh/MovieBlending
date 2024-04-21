
package com.movie.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.domain.Movie;
import com.movie.mapper.MovieMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//Service는 비즈니스 로직

@Log4j
@Service
public class MovieService {
	@Setter(onMethod_ = @Autowired)
	MovieMapper mapper;

	public int insertBoxOfficeKobisData(Movie movie) {
		log.info("insertBoxOfficeKobisData...");
		return mapper.insertBoxOfficeKobisData(movie);
	}

	public int updatePosterUrl(Movie movie, String movieCd) {
		log.info("updatePosterUrl...");
		return mapper.updatePosterUrl(movie, movieCd);
	}

	public int updateKmdbData(Movie movie, String movieNm, String openDt) {
		log.info("updateKmdbData...");
		return mapper.updateKmdbData(movie, movieNm, openDt);
	}
	
	// 박스 오피스 데이터 조회 1단계(진흥원 API)
	public List<Movie> fetchBoxOfficeData(String selectedDate, String type)
			throws IOException {
		StringBuilder urlBuilder
			= new StringBuilder("http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/");
		// 일별,주간,주말에 따른 파라미터 1차 구분
		urlBuilder.append(type.equals("daily") ? "searchDailyBoxOfficeList.json" : "searchWeeklyBoxOfficeList.json");
		urlBuilder.append("?key=f5eef3421c602c6cb7ea224104795888"); // 발급키
		// 일별,주간,주말에 따른 파라미터 2차 구분
		urlBuilder.append(type.equals("weekly") ? "&weekGb=0" : type.equals("weekend") ? "&weekGb=1" : "");
		urlBuilder.append("&targetDt=").append(selectedDate.replace("-", ""));

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		log.info("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		//log.info(sb.toString());

		return parseResponse(sb.toString(), type);
	}

	// 박스 오피스 데이터 조회 2단계(응답 전달받고 객체 생성)
	public List<Movie> parseResponse(String response, String type) {
		List<Movie> mList = new ArrayList<>();
		JSONObject jsonObject = new JSONObject(response);
		JSONArray jsonArray = null;
		if (type.equals("daily")) {
			jsonArray = jsonObject.getJSONObject("boxOfficeResult").getJSONArray("dailyBoxOfficeList");
		} else if (type.equals("weekly") || type.equals("weekend")) {
			jsonArray = jsonObject.getJSONObject("boxOfficeResult").getJSONArray("weeklyBoxOfficeList");
		}
		if (jsonArray != null) {
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject movieObj = jsonArray.getJSONObject(i);
				int rank = movieObj.getInt("rank");
				String movieCd = movieObj.getString("movieCd");
				String movieNm = movieObj.getString("movieNm");
				String openDt = movieObj.getString("openDt");
				//숫자를 1000 단위로 끊어서 출력(가독성 향상)
				String audiCnt = String.format("%, d", Integer.parseInt(movieObj.getString("audiCnt")));
				String audiAcc = String.format("%, d", Integer.parseInt(movieObj.getString("audiAcc")));	
				String rankOldAndNew = movieObj.getString("rankOldAndNew");	
				if(rankOldAndNew.equals("OLD")) {
					rankOldAndNew = " ";
				}
				log.info("변경된 랭크값 : " + rankOldAndNew);
				//=============================================================
				Movie movie = new Movie();
				movie.setRank(rank);
				movie.setMovieCd(movieCd);
				movie.setMovieNm(movieNm);
				movie.setOpenDt(openDt);
				movie.setRankOldAndNew(rankOldAndNew);
				movie.setAudiCnt(audiCnt);
				movie.setAudiAcc(audiAcc);
				// db 테이블에 저장(값이 1 나오면 저장 성공, 0 나오면 저장 실패)
				log.info("insertBoxOfficeKobisData 결과 : "
						+ mapper.insertBoxOfficeKobisData(movie));			

				//진흥원 데이터로 검색해, 해당 영화에 일치되는 포스터 url 가져오기
				fetchMoviePoster(mList, rank, movieCd, movieNm, openDt
						, rankOldAndNew, audiCnt, audiAcc);
			}
		}
		return mList;
	}

	// 포스터 URL 조회 전용(리턴값은 String)
	public void fetchMoviePoster(List<Movie> mList, int rank
			, String movieCd, String movieNm, String openDt
			, String rankOldAndNew, String audiCnt, String audiAcc) {		
		String posterUrl = null;		
		try {
			// 한글이 들어있는 경우에 대비해, URLEncoder.encode 사용 필요
			String encodedMovieNm = URLEncoder.encode(movieNm, "UTF-8");

			// json으로 안하면 이미지 못가져옴
			StringBuilder urlBuilder = new StringBuilder(
					"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2");
			urlBuilder.append("&ServiceKey=6CO85UB1I0DP2Y32897W").append("&title=").append(encodedMovieNm)
					.append("&releaseDts=").append(openDt.replace("-", "")); // .replace("-", "")
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			// System.out.println("Response code: " + conn.getResponseCode());
			BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			// System.out.println(sb.toString());
			// ==============================================================================
			JSONObject jsonObject = new JSONObject(sb.toString());
			JSONArray dataArray = jsonObject.getJSONArray("Data");

			if (dataArray.length() > 0) {
				JSONObject dataObject = dataArray.getJSONObject(0);
				JSONArray resultList = dataObject.getJSONArray("Result");
				if (resultList.length() > 0) {
					JSONObject movieObject = resultList.getJSONObject(0);
					String postersString = movieObject.getString("posters");// '|'로 구분된 포스터 URL 문자열
					String[] posterUrls = postersString.split("\\|"); // '|'로 문자열 분할
					if (posterUrls.length > 0) {
						// 첫 번째 포스터 URL 가져오기
						posterUrl = posterUrls[0];
						log.info("posterUrl 값: " + posterUrl);
					}
				}
			}
			Movie movie = new Movie();
			movie.setRank(rank);
	        movie.setMovieCd(movieCd);
	        movie.setMovieNm(movieNm);
	        movie.setOpenDt(openDt);
	        movie.setPosterUrl(posterUrl);
			movie.setRankOldAndNew(rankOldAndNew);
			movie.setAudiCnt(audiCnt);
			movie.setAudiAcc(audiAcc);
	        log.info("updatePosterUrl 결과 : "	
					+ mapper.updatePosterUrl(movie, movieCd));
			mList.add(movie);// 포스터 url만 db에 저장

			// KMDB 데이터들을 테이블에 저장
			// 여기다 선언해야지, KMDB API를 두번씩이나 조회할 필요가 없어짐
			saveMovieDetails(dataArray, movieNm, openDt);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 상세정보에 필요한 KMDB 데이터들을 테이블에 저장
	public void saveMovieDetails(JSONArray dataArray, String movieNm, String openDt)
			throws IOException {
		try {
			String titleEng = "", genre = "", prodYear = "", directorNm = "", actorNmList = "", company = "", rating = "",
					vodUrl = "", vodClass = "";
			String[] titleEngs, genres, prodYears, directorNms, actorNms, companies, ratings, vodUrls, vodClasses;

			if (dataArray.length() > 0) {
				JSONObject dataObject = dataArray.getJSONObject(0);
				JSONArray resultArray = dataObject.getJSONArray("Result");
				if (resultArray.length() > 0) {
					JSONObject resultObject = resultArray.getJSONObject(0);

					// titleEng 값 가져오기
					// 위치는 Data->Result->titleEng
					titleEng = resultObject.getString("titleEng");
					titleEngs = titleEng.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					titleEng = titleEngs[0];
					if(titleEng.equals(null)) {
						titleEng = " ";
					}
					log.info("titleEng 값: " + titleEng);

					// genre 값 가져오기
					// 위치는 Data->Result->genre
					genre = resultObject.getString("genre");
					genres = genre.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					genre = genres[0];
					if(genre.equals(null)) {
						genre = " ";
					}
					log.info("genre 값: " + genre);

					// prodYear 값 가져오기
					// 위치는 Data->Result->prodYear
					prodYear = resultObject.getString("prodYear");
					prodYears = prodYear.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					prodYear = prodYears[0];
					if(prodYear.equals(null)) {
						prodYear = " ";
					}
					log.info("prodYear 값: " + prodYear);

					// directorNm 값 가져오기
					// 위치는 Data->Result->directors->director->directorNm
					// 주의!! directors는 [가 없고 {로만 둘러싸여, Array 생성이 불가능('[{' 둘다 있어야 Array 생성 가능)
					// 때문에 directors는 Object만 선언하고 그다음 아랫층 director로 이동
					JSONObject directorsObject = resultObject.getJSONObject("directors");
					JSONArray directorArray = directorsObject.getJSONArray("director");
					if (directorArray.length() > 0) {
						JSONObject directorNmObject = directorArray.getJSONObject(0);
						directorNm = directorNmObject.getString("directorNm");
					}
					directorNms = directorNm.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					directorNm = directorNms[0];
					if(directorNm.equals(null)) {
						directorNm = " ";
					}
					log.info("directorNm 값: " + directorNm);
					
					// actorNm 값 가져오기
					// 위치는 Data->Result->actors->actor->actorNm
					// 주의!! actors는 [가 없고 {로만 둘러싸여, Array 생성이 불가능('[{' 둘다 있어야 Array 생성 가능)
					// 때문에 actors는 Object만 선언하고 그다음 아랫층 director로 이동
					JSONObject actorsObject = resultObject.getJSONObject("actors");
					JSONArray actorArray = actorsObject.getJSONArray("actor");
					if (actorArray.length() > 0) {
						for (int i = 0; i < actorArray.length(); i++) {
							JSONObject actorNmObject = actorArray.getJSONObject(i);
						    String actorNm = actorNmObject.getString("actorNm");
						    actorNms = actorNm.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
						    actorNmList += actorNms[0];	// actorNm를 리스트에 추가
						    if (i < actorArray.length() - 1) {
						        actorNmList += ",";	// 마지막 요소가 아니면 쉼표 추가
						    }					    
						    if(i >= 4) {
						    	break;						    	
						    }
						}
					}
					if(actorNmList.equals(null)) {
						actorNmList = " ";
					}
					log.info("actorNm 값: " + actorNmList);					

					// company 값 가져오기
					// 위치는 Data->Result->company
					company = resultObject.getString("company");
					companies = company.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					company = companies[0];
					if(company.equals(null)) {
						company = " ";
					}
					log.info("company 값: " + company);

					// rating 값 가져오기
					// 위치는 Data->Result->rating
					rating = resultObject.getString("rating");
					ratings = rating.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					rating = ratings[0];
					if(rating.equals(null)) {
						rating = " ";
					}
					log.info("rating 값: " + rating);

					// vodUrl, vodClass 값 가져오기
					// 위치는 Data->Result->vods->vod->vodUrl(vodClass)
					// 주의!! vods는 [가 없고 {로만 둘러싸여, Array 생성이 불가능('[{' 둘다 있어야 Array 생성 가능)
					// 때문에 vods는 Object만 선언하고 그다음 아랫층 vod로 이동
					JSONObject vodsObject = resultObject.getJSONObject("vods");
					JSONArray vodArray = vodsObject.getJSONArray("vod");
					if (vodArray.length() > 0) {
						JSONObject vodUrlObject = vodArray.getJSONObject(0);
						vodUrl = vodUrlObject.getString("vodUrl");
						JSONObject vodClassObject = vodArray.getJSONObject(0);
						vodClass = vodClassObject.getString("vodClass");
					}
					vodUrls = vodUrl.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					vodUrl = vodUrls[0];
					log.info("vodUrl 값: " + vodUrl);

					vodClasses = vodClass.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					vodClass = vodClasses[0];
					log.info("vodClass 값: " + vodClass);
				}
			}
			Movie movie = new Movie();
			movie.setTitleEng(titleEng);
			movie.setGenre(genre);
			movie.setProdYear(prodYear);
			movie.setDirectorNm(directorNm);
			movie.setActorNm(actorNmList);
			movie.setCompany(company);
			movie.setRating(rating);
			movie.setVodUrl(vodUrl);
			movie.setVodClass(vodClass);
			// db 테이블에 저장(값이 1 나오면 저장 성공, 0 나오면 저장 실패)
			log.info("updateKmdbData 결과 : "
					+ mapper.updateKmdbData(movie, movieNm, openDt));
			System.out.println("=======================================================================");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 검색어로 영화 조회
	public List<Movie> fetchSearchData(String searchText)
			throws IOException {
		StringBuilder urlBuilder
			= new StringBuilder("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json");
		// 일별,주간,주말에 따른 파라미터 1차 구분
		urlBuilder.append("?key=7b796b1d850b70abfe1543c0d0fbe58b"); // 발급키
		// 일별,주간,주말에 따른 파라미터 2차 구분
		urlBuilder.append("&movieNm=").append(searchText);

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		log.info("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		//log.info(sb.toString());

		return parseSearchResponse(sb.toString());
	}
	
	public List<Movie> parseSearchResponse(String response) {
		List<Movie> mList = new ArrayList<>();
		JSONObject jsonObject = new JSONObject(response);
		JSONArray jsonArray = null;
			jsonArray = jsonObject.getJSONObject("movieListResult").getJSONArray("movieList");
		if (jsonArray != null) {
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject movieObj = jsonArray.getJSONObject(i);
//				int rank = movieObj.getInt("rank");
				String movieCd = movieObj.getString("movieCd");
				String movieNm = movieObj.getString("movieNm");
				String openDt = movieObj.getString("openDt");
//				String rankOldAndNew = movieObj.getString("rankOldAndNew");
//				String audiCnt = movieObj.getString("audiCnt");
//				String audiAcc = movieObj.getString("audiAcc");
				//=============================================================
				Movie movie = new Movie();
//				movie.setRank(rank);
				movie.setMovieCd(movieCd);
				movie.setMovieNm(movieNm);
				movie.setOpenDt(openDt);
//				movie.setRankOldAndNew(rankOldAndNew);
//				movie.setAudiCnt(audiCnt);
//				movie.setAudiAcc(audiAcc);
				// db 테이블에 저장(값이 1 나오면 저장 성공, 0 나오면 저장 실패)
				log.info("insertmovieListResultKobisData 결과 : "
						+ mapper.insertBoxOfficeKobisData(movie));			

				//진흥원 데이터로 검색해, 해당 영화에 일치되는 포스터 url 가져오기
				fetchMoviePoster(mList, movieCd, movieNm, openDt);
			}
		}
		return mList;
	}
	
	
	// 포스터 URL 조회 전용(리턴값은 String)
		public void fetchMoviePoster(List<Movie> mList, String movieCd, String movieNm, String openDt) {		
			String posterUrl = null;		
			try {
				// 한글이 들어있는 경우에 대비해, URLEncoder.encode 사용 필요
				String encodedMovieNm = URLEncoder.encode(movieNm, "UTF-8");

				// json으로 안하면 이미지 못가져옴
				StringBuilder urlBuilder = new StringBuilder(
						"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2");
				urlBuilder.append("&ServiceKey=6CO85UB1I0DP2Y32897W").append("&title=").append(encodedMovieNm)
						.append("&releaseDts=").append(openDt); // .replace("-", "")
				
				URL url = new URL(urlBuilder.toString());
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.setRequestProperty("Content-type", "application/json");
				// System.out.println("Response code: " + conn.getResponseCode());
				BufferedReader rd;
				if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
					rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				} else {
					rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
				}
				StringBuilder sb = new StringBuilder();
				String line;
				while ((line = rd.readLine()) != null) {
					sb.append(line);
				}
				rd.close();
				conn.disconnect();
				// System.out.println(sb.toString());
				// ==============================================================================
				JSONObject jsonObject = new JSONObject(sb.toString());
				JSONArray dataArray = jsonObject.getJSONArray("Data");

				if (dataArray.length() > 0) {
					JSONObject dataObject = dataArray.getJSONObject(0);
					JSONArray resultList = dataObject.getJSONArray("Result");
					if (resultList.length() > 0) {
						JSONObject movieObject = resultList.getJSONObject(0);
						String postersString = movieObject.getString("posters");// '|'로 구분된 포스터 URL 문자열
						String[] posterUrls = postersString.split("\\|"); // '|'로 문자열 분할
						if (posterUrls.length > 0) {
							// 첫 번째 포스터 URL 가져오기
							posterUrl = posterUrls[0];
							log.info("포스터 URL: " + posterUrl);
						}
					}
				}
				Movie movie = new Movie();
//				movie.setRank(rank);
		        movie.setMovieCd(movieCd);
		        movie.setMovieNm(movieNm);
		        movie.setOpenDt(openDt);
		        movie.setPosterUrl(posterUrl);
//				movie.setRankOldAndNew(rankOldAndNew);
//				movie.setAudiCnt(audiCnt);
//				movie.setAudiAcc(audiAcc);
		        log.info("updatePosterUrl 결과 : "	// 포스터 url만 db에 저장
						+ mapper.updatePosterUrl(movie, movieCd));
				mList.add(movie);

				// KMDB 데이터들을 테이블에 저장
				// 여기다 선언해야지, KMDB API를 두번씩이나 조회할 필요가 없어짐
				saveMovieDetails(dataArray, movieNm, openDt);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	
}
