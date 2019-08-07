package onResort.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import onResort.domain.Review_board;

public class Review_boardDao {
	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://3.13.15.154:3306/onResort", "root", "kopo24");
		} catch (Exception e) {
			System.out.println(e);
		}
		return con;
	}
	
	public static int insert(Review_board r) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con
					.prepareStatement("insert into review_board (title, dayOfRegister, content, rootid, imgname, orgimgname) values (?, now(), ?, (select auto_increment from information_schema.tables where table_name='review_board' and table_schema = database()), ?, ?)");
			ps.setString(1, r.getTitle());
			ps.setString(2, r.getContent());
			ps.setString(3, r.getImgname());
			ps.setString(4, r.getOrgimgname());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}
	
	public static int reinsert(Review_board r) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con
					.prepareStatement("insert into review_board (title, dayOfRegister, content, rootid, relevel, recnt, imgname, orgimgname) values (?, now(), ?, ?, ?, ?, ?, ?)");
			ps.setString(1, r.getTitle());
			ps.setString(2, r.getContent());
			ps.setInt(3, r.getRootid());
			ps.setInt(4, r.getRelevel());
			ps.setInt(5, r.getRecnt());
			ps.setString(6, r.getImgname());
			ps.setString(7, r.getOrgimgname());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}

	public static int update(Review_board r) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("update review_board set title=?, content=?, imgname=?, orgimgname=? where id=?");
			ps.setString(1, r.getTitle());
			ps.setString(2, r.getContent());
			ps.setString(3, r.getImgname());
			ps.setString(4, r.getOrgimgname());
			ps.setInt(5, r.getId());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}
	
	public static int updateViewcnt(int id) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("update review_board set viewcnt=viewcnt+1 where id=?");
			ps.setInt(1, id);
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}
	
	public static int updateRecnt(int recnt, int rootid) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("update review_board set recnt=recnt+1 where rootid=? and recnt >= ?");
			ps.setInt(1, rootid);
			ps.setInt(2, recnt);
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}

	public static int delete(Review_board r) {
		int status = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("delete from review_board where id=?;");
			ps.setInt(1, r.getId());
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}
	
	// 글 삭제시 자식 글까지 모두 지워지도록 하는 메소드
	public static int deleteAllReply(Review_board r) {
		int status = 0;
		try {
			Connection con = getConnection();
			// 들어온 값의 rootid와 같고 recnt보다 큰 목록을 조회
			PreparedStatement ps = con.prepareStatement("select title, rootid, relevel, recnt from review_board where rootid=? and recnt>? order by recnt asc;");
			ps.setInt(1, r.getRootid());
			ps.setInt(2, r.getRecnt());
			ResultSet rs = ps.executeQuery();
			int finalChild = r.getRecnt();
			while(rs.next()) { 
				if(rs.getInt("relevel")<=r.getRelevel()) { // 조회한 값에서 삭제하려는 글의 relevel보다 작거나 같은 relevel을 만나면 while문 나가기
					break;
				}
				finalChild = rs.getInt("recnt"); // recnt값으로 finalChild의 recnt 넣기
				
			}
			// rootid가 같고 recnt의 범위가 삭제하려는 글의 recnt부터 finalChild까지인 기록들 삭제하기
			ps = con.prepareStatement("delete from review_board where rootid=? and recnt between ? and ?;");
			ps.setInt(1, r.getRootid());
			ps.setInt(2, r.getRecnt());
			ps.setInt(3, finalChild);
			status = ps.executeUpdate();
			ps.close();
			con.close();
		} catch(Exception e) {
			System.out.println(e);
		}
		return status;
	}

	public static List<Review_board> getAllRecords() {
		List<Review_board> list = new ArrayList<Review_board>();

		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select * from review_board order by rootid desc, recnt asc;");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Review_board r = new Review_board();
				r.setId(rs.getInt("id"));
				r.setTitle(rs.getString("title"));
				r.setDayOfRegister(rs.getDate("dayOfRegister"));
				r.setContent(rs.getString("content"));
				r.setRootid(rs.getInt("rootid"));
				r.setRelevel(rs.getInt("relevel"));
				r.setRecnt(rs.getInt("recnt"));
				r.setViewcnt(rs.getInt("viewcnt"));
				r.setImgname(rs.getString("imgname"));
				r.setOrgimgname(rs.getString("orgimgname"));
				list.add(r);
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return list;
	}

	public static Review_board getRecordById(int id) {
		Review_board r = new Review_board();
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select * from review_board where id=?");
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				r.setId(rs.getInt("id"));
				r.setTitle(rs.getString("title"));
				r.setDayOfRegister(rs.getDate("dayOfRegister"));
				r.setContent(rs.getString("content"));
				r.setRootid(rs.getInt("rootid"));
				r.setRelevel(rs.getInt("relevel"));
				r.setRecnt(rs.getInt("recnt"));
				r.setViewcnt(rs.getInt("viewcnt"));
				r.setImgname(rs.getString("imgname"));
				r.setOrgimgname(rs.getString("orgimgname"));
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return r;
	}
	
	public static int getRecordByLastest() {
		int max_id = 0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("select max(id) from review_board;");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				max_id = rs.getInt("max(id)");
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return max_id;
		
	}
}
