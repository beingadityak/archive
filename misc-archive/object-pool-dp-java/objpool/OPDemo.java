package objpool;

public class OPDemo {
  public static void main(String args[]) {
    // Do something...

    // Create the ConnectionPool:
    JDBCConnectionPool pool = new JDBCConnectionPool(
      "com.mysql.jdbc.Driver", "jdbc:mysql://localhost/mydb",
      "username", "password");

    // Get a connection:
    Connection con = pool.checkOut();

    // Use the connection


    // Return the connection:
    pool.checkIn(con);
 
  }
}