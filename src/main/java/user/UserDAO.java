package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
	private Connection conn;
	private ResultSet rs;

	public UserDAO() {
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

	public int login(String userID, String userPassword) {
		String sql = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, userID);
			rs = st.executeQuery();

			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1;
				} else {
					return 0;
				}
			}
			return -1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -2;
	}

	public int join(User user) {
		String sql = "INSERT INTO USER VALUES (?,?,?,?,?)";
		try {
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, user.getUserID());
			st.setString(2, user.getUserPassword());
			st.setString(3, user.getUserName());
			st.setString(4, user.getUserGender());
			st.setString(5, user.getUserEmail());
			return st.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
}
