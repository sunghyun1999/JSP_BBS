package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PostDAO {
	private Connection conn;
	private ResultSet rs;

	public PostDAO() {
		String url = "jdbc:mysql://localhost:3306/bbs";
		String user = "root";
		String password = "jsh315518";
		String driverName = "com.mysql.cj.jdbc.Driver";

		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public int getNext() {
		String sql = "SELECT postID FROM POST ORDER BY postID DESC";
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			rs = st.executeQuery();

			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public String getDate() {
		String sql = "SELECT NOW()";
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			rs = st.executeQuery();

			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	public int write(String postTitle, String userID, String postContent) {
		String sql = "INSERT INTO POST VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			st.setInt(1, getNext());
			st.setString(2, postTitle);
			st.setString(3, userID);
			st.setString(4, getDate());
			st.setString(5, postContent);
			st.setInt(6, 1);
			return st.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<Post> getList(int pageNum) {
		String sql = "SELECT * FROM POST WHERE postID < ? AND postAvailable = 1 ORDER BY postID DESC LIMIT 10";
		ArrayList<Post> list = new ArrayList<>();
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			st.setInt(1, getNext() - (pageNum - 1) * 10);
			rs = st.executeQuery();

			while (rs.next()) {
				Post post = new Post();
				post.setPostID(rs.getInt(1));
				post.setPostTitle(rs.getString(2));
				post.setUserID(rs.getString(3));
				post.setPostDate(rs.getString(4));
				post.setPostContent(rs.getString(5));
				post.setPostAvailable(rs.getInt(6));
				list.add(post);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public boolean isNextPage(int pageNum) {
		String sql = "SELECT * FROM POST WHERE postID < ? AND postAvailable = 1";
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			st.setInt(1, getNext() - (pageNum - 1) * 10);
			rs = st.executeQuery();

			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public Post getPost(int postID) {
		String sql = "SELECT * FROM POST WHERE postID = ?";
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			st.setInt(1, postID);
			rs = st.executeQuery();

			if (rs.next()) {
				Post post = new Post();
				post.setPostID(rs.getInt(1));
				post.setPostTitle(rs.getString(2));
				post.setUserID(rs.getString(3));
				post.setPostDate(rs.getString(4));
				post.setPostContent(rs.getString(5));
				post.setPostAvailable(rs.getInt(6));
				return post;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public int edit(int postID, String postTitle, String postContent) {
		String sql = "UPDATE POST SET postTitle = ?, postContent = ? WHERE postID = ?";
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, postTitle);
			st.setString(2, postContent);
			st.setInt(3, postID);
			return st.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public int delete(int postID) {
		String sql = "UPDATE POST SET postAvailable = 0 WHERE postID = ?";
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			st.setInt(1, postID);
			return st.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
}
