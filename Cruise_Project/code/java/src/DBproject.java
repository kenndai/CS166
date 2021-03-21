/*
 * Template JAVA User Interface
 * =============================
 *
 * Database Management Systems
 * Department of Computer Science &amp; Engineering
 * University of California - Riverside
 *
 * Target DBMS: 'Postgres'
 *
 */


import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.io.File;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;
import java.util.ArrayList;

/**
 * This class defines a simple embedded SQL utility class that is designed to
 * work with PostgreSQL JDBC drivers.
 *
 */

public class DBproject{
	//reference to physical database connection
	private Connection _connection = null;
	static BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
	
	public DBproject(String dbname, String dbport, String user, String passwd) throws SQLException {
		System.out.print("Connecting to database...");
		try{
			// constructs the connection URL
			String url = "jdbc:postgresql://localhost:" + dbport + "/" + dbname;
			System.out.println ("Connection URL: " + url + "\n");
			
			// obtain a physical connection
	        this._connection = DriverManager.getConnection(url, user, passwd);
	        System.out.println("Done");
		}catch(Exception e){
			System.err.println("Error - Unable to Connect to Database: " + e.getMessage());
	        System.out.println("Make sure you started postgres on this machine");
	        System.exit(-1);
		}
	}
	
	/**
	 * Method to execute an update SQL statement.  Update SQL instructions
	 * includes CREATE, INSERT, UPDATE, DELETE, and DROP.
	 * 
	 * @param sql the input SQL string
	 * @throws java.sql.SQLException when update failed
	 * */
	public void executeUpdate (String sql) throws SQLException { 
		// creates a statement object
		Statement stmt = this._connection.createStatement ();

		// issues the update instruction
		stmt.executeUpdate (sql);

		// close the instruction
	    stmt.close ();
	}//end executeUpdate

	/**
	 * Method to execute an input query SQL instruction (i.e. SELECT).  This
	 * method issues the query to the DBMS and outputs the results to
	 * standard out.
	 * 
	 * @param query the input query string
	 * @return the number of rows returned
	 * @throws java.sql.SQLException when failed to execute the query
	 */
	public int executeQueryAndPrintResult (String query) throws SQLException {
		//creates a statement object
		Statement stmt = this._connection.createStatement ();

		//issues the query instruction
		ResultSet rs = stmt.executeQuery (query);

		/*
		 *  obtains the metadata object for the returned result set.  The metadata
		 *  contains row and column info.
		 */
		ResultSetMetaData rsmd = rs.getMetaData ();
		int numCol = rsmd.getColumnCount ();
		int rowCount = 0;
		
		//iterates through the result set and output them to standard out.
		boolean outputHeader = true;
		while (rs.next()){
			if(outputHeader){
				for(int i = 1; i <= numCol; i++){
					System.out.print(rsmd.getColumnName(i) + "\t");
			    }
			    System.out.println();
			    outputHeader = false;
			}
			for (int i=1; i<=numCol; ++i)
				System.out.print (rs.getString (i) + "\t");
			System.out.println ();
			++rowCount;
		}//end while
		stmt.close ();
		return rowCount;
	}
	
	/**
	 * Method to execute an input query SQL instruction (i.e. SELECT).  This
	 * method issues the query to the DBMS and returns the results as
	 * a list of records. Each record in turn is a list of attribute values
	 * 
	 * @param query the input query string
	 * @return the query result as a list of records
	 * @throws java.sql.SQLException when failed to execute the query
	 */
	public List<List<String>> executeQueryAndReturnResult (String query) throws SQLException { 
		//creates a statement object 
		Statement stmt = this._connection.createStatement (); 
		
		//issues the query instruction 
		ResultSet rs = stmt.executeQuery (query); 
	 
		/*
		 * obtains the metadata object for the returned result set.  The metadata 
		 * contains row and column info. 
		*/ 
		ResultSetMetaData rsmd = rs.getMetaData (); 
		int numCol = rsmd.getColumnCount (); 
		int rowCount = 0; 
	 
		//iterates through the result set and saves the data returned by the query. 
		boolean outputHeader = false;
		List<List<String>> result  = new ArrayList<List<String>>(); 
		while (rs.next()){
			List<String> record = new ArrayList<String>(); 
			for (int i=1; i<=numCol; ++i) 
				record.add(rs.getString (i)); 
			result.add(record); 
		}//end while 
		stmt.close (); 
		return result; 
	}//end executeQueryAndReturnResult
	
	/**
	 * Method to execute an input query SQL instruction (i.e. SELECT).  This
	 * method issues the query to the DBMS and returns the number of results
	 * 
	 * @param query the input query string
	 * @return the number of rows returned
	 * @throws java.sql.SQLException when failed to execute the query
	 */
	public int executeQuery (String query) throws SQLException {
		//creates a statement object
		Statement stmt = this._connection.createStatement ();

		//issues the query instruction
		ResultSet rs = stmt.executeQuery (query);

		int rowCount = 0;

		//iterates through the result set and count nuber of results.
		if(rs.next()){
			rowCount++;
		}//end while
		stmt.close ();
		return rowCount;
	}
	
	/**
	 * Method to fetch the last value from sequence. This
	 * method issues the query to the DBMS and returns the current 
	 * value of sequence used for autogenerated keys
	 * 
	 * @param sequence name of the DB sequence
	 * @return current value of a sequence
	 * @throws java.sql.SQLException when failed to execute the query
	 */
	
	public int getCurrSeqVal(String sequence) throws SQLException {
		Statement stmt = this._connection.createStatement ();
		
		ResultSet rs = stmt.executeQuery (String.format("Select currval('%s')", sequence));
		if (rs.next()) return rs.getInt(1);
		return -1;
	}

	/**
	 * Method to close the physical connection if it is open.
	 */
	public void cleanup(){
		try{
			if (this._connection != null){
				this._connection.close ();
			}//end if
		}catch (SQLException e){
	         // ignored.
		}//end try
	}//end cleanup

	/**
	 * The main execution method
	 * 
	 * @param args the command line arguments this inclues the <mysql|pgsql> <login file>
	 */
	public static void main (String[] args) {
		if (args.length != 3) {
			System.err.println (
				"Usage: " + "java [-classpath <classpath>] " + DBproject.class.getName () +
		            " <dbname> <port> <user>");
			return;
		}//end if
		
		DBproject esql = null;
		
		try{
			System.out.println("(1)");
			
			try {
				Class.forName("org.postgresql.Driver");
			}catch(Exception e){

				System.out.println("Where is your PostgreSQL JDBC Driver? " + "Include in your library path!");
				e.printStackTrace();
				return;
			}
			
			System.out.println("(2)");
			String dbname = args[0];
			String dbport = args[1];
			String user = args[2];
			
			esql = new DBproject (dbname, dbport, user, "");
			
			boolean keepon = true;
			while(keepon){
				System.out.println("MAIN MENU");
				System.out.println("---------");
				System.out.println("1. Add Ship");
				System.out.println("2. Add Captain");
				System.out.println("3. Add Cruise");
				System.out.println("4. Book Cruise");
				System.out.println("5. List number of available seats for a given Cruise.");
				System.out.println("6. List total number of repairs per Ship in descending order");
				System.out.println("7. Find total number of passengers with a given status");
				System.out.println("8. < EXIT");
				
				switch (readChoice()){
					case 1: AddShip(esql); break;
					case 2: AddCaptain(esql); break;
					case 3: AddCruise(esql); break;
					case 4: BookCruise(esql); break;
					case 5: ListNumberOfAvailableSeats(esql); break;
					case 6: ListsTotalNumberOfRepairsPerShip(esql); break;
					case 7: FindPassengersCountWithStatus(esql); break;
					case 8: keepon = false; break;
				}
			}
		}catch(Exception e){
			System.err.println (e.getMessage ());
		}finally{
			try{
				if(esql != null) {
					System.out.print("Disconnecting from database...");
					esql.cleanup ();
					System.out.println("Done\n\nBye !");
				}//end if				
			}catch(Exception e){
				// ignored.
			}
		}
	}

	public static int readChoice() {
		int input;
		// returns only if a correct value is given.
		do {
			System.out.print("Please make your choice: ");
			try { // read the integer, parse it and break.
				input = Integer.parseInt(in.readLine());
				break;
			}catch (Exception e) {
				System.out.println("Your input is invalid!");
				continue;
			}//end try
		}while (true);
		return input;
	}//end readChoice

	public static void AddShip(DBproject esql) {//1
		try {

			String query = String.format("select s.id from Ship s");
			List<List<String>> ship_ID_relation = esql.executeQueryAndReturnResult(query);
			int ship_id = ship_ID_relation.size(); //id is the next in order

			//reading strings
			System.out.print("Please enter the make of the ship: ");
			String make = in.readLine();
			System.out.print("Please enter the ship's model: ");
			String model = in.readLine();
			//reading ints
			System.out.print("Please enter the age of the ship: ");
			int age = Integer.parseInt(in.readLine());
			System.out.print("Please enter the number of seats on the ship: ");
			int seats = Integer.parseInt(in.readLine());

			query = String.format("INSERT INTO Ship (id, make, model, age, seats) VALUES (%d , '%s', '%s', %d, %d)", ship_id, make, model, age, seats);
			esql.executeUpdate(query);

			//print the new tuple
			query = String.format("select * from Ship s where s.id = %d", ship_id); 
			int rowCount = esql.executeQueryAndPrintResult(query);

			System.out.println ("total row(s): " + rowCount);

		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static void AddCaptain(DBproject esql) {//2
		try {

			String query = String.format("select c.id from Captain c");
			List<List<String>> cap_ID_relation = esql.executeQueryAndReturnResult(query);
			int cap_id = cap_ID_relation.size();

			//reading strings
			System.out.print("Please enter the captain's full name: ");
			String fullname = in.readLine();
			System.out.print("Please enter their nationality: ");
			String nationality = in.readLine();
			
			query = String.format("INSERT INTO Captain (id, fullname, nationality) VALUES (%d, '%s', '%s')", cap_id, fullname, nationality);
			esql.executeUpdate(query);

			//print the new tuple
			query = String.format("select * from Captain c where c.id = %d", cap_id); 
			int rowCount = esql.executeQueryAndPrintResult(query);

			System.out.println ("total row(s): " + rowCount);

		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static void AddCruise(DBproject esql) {//3
		try {

			String query = String.format("select c.cnum from Cruise c");
			List<List<String>> cnum_relation = esql.executeQueryAndReturnResult(query);
			int cnum = cnum_relation.size();

			//reading ints 
			System.out.print("Please enter the cost of a ticket: ");
			int cost = Integer.parseInt(in.readLine());
			System.out.print("Please enter the number of tickets sold: ");
			int num_sold = Integer.parseInt(in.readLine());
			System.out.print("Please enter the number of stops: ");
			int numstops = Integer.parseInt(in.readLine());

			//reading strings
			System.out.print("Please enter the departure date: ");
			String departure_date = in.readLine();
			System.out.print("Please enter the arrival date: ");
			String arrival_date = in.readLine();
			System.out.print("Please enter the arrival port: ");
			String arrival_port = in.readLine();
			System.out.print("Please enter the departure port: ");
			String departure_port = in.readLine();

			query = String.format("INSERT INTO Cruise (cnum, cost, num_sold, num_stops, actual_departure_date, actual_arrival_date, arrival_port, departure_port) VALUES (%d, %d, %d, %d, '%s', '%s', '%s', '%s')", cnum, cost, num_sold, numstops, departure_date, arrival_date, arrival_port, departure_port);
			esql.executeUpdate(query);

			//print the new tuple
			query = String.format("select * from Cruise c where c.cnum = %d", cnum); 
			int rowCount = esql.executeQueryAndPrintResult(query);

			System.out.println ("total row(s): " + rowCount);
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static void BookCruise(DBproject esql) {//4
		// Given a customer and a Cruise that he/she wants to book, determine the status of the reservation and add the reservation to the database with the appropriate status

		try {
			
			String query = String.format("select r.rnum from Reservation r");
			List<List<String>> rnum_relation = esql.executeQueryAndReturnResult(query);
			int rnum = rnum_relation.size(); //assign rnum as the next in the sequence

			//reading ints
 			System.out.print("Please enter your customer ID: ");
			int cust_id = Integer.parseInt(in.readLine());
			System.out.print("Please enter the cruise number of the cruise you'd like to book: ");
			int cnum = Integer.parseInt(in.readLine());

			//check if there were any reservations made already for that pair of customer and cruise
			query = String.format("select * from Reservation r where r.ccid = %d AND r.cid = %d", cust_id, cnum);
			int rowCount = esql.executeQuery(query);

			if (rowCount > 0) {
				System.out.println ("You have already made a reservation for this cruise");
				rowCount = esql.executeQueryAndPrintResult(query);
				System.out.println ("total row(s): " + rowCount);
				return;	
			}

			//number of available seats
			query = String.format("select s.seats - c.num_sold as available_seats from CruiseInfo ci, Ship s, Cruise c where ci.cruise_id = %d AND ci.cruise_id = c.cnum AND ci.ship_id = s.id", cnum);

			List<List<String>> availableSeatsRelation = esql.executeQueryAndReturnResult(query);
			int numSeats = Integer.parseInt(availableSeatsRelation.get(0).get(0));

			char status;
			if (numSeats > 0) status = 'R';
			else status = 'W';
			
			//inserting tuple
			query = String.format("insert into Reservation(rnum, ccid, cid, status) values (%d, %d, %d, '%s')", rnum, cust_id, cnum, status);
			esql.executeUpdate(query);

			//update numsold when a customer books
			query = String.format("update Cruise set num_sold = num_sold + 1 where cnum = %d", cnum);
			esql.executeUpdate(query);

			//print out new tuple
			query = String.format("select * from Reservation r where rnum = %d", rnum);
			rowCount = esql.executeQueryAndPrintResult(query);

			System.out.println ("total row(s): " + rowCount);

		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static void ListNumberOfAvailableSeats(DBproject esql) {//5
		// For Cruise number and date, find the number of availalbe seats (i.e. total Ship capacity minus booked seats )
		try {
			//reading ints
 			System.out.print("Please enter cruise number: ");
			int cnum = Integer.parseInt(in.readLine());
			//reading strings
			System.out.print("Please enter the cruise's departure date: ");
			String departure_date = in.readLine();

			String query = String.format("select s.seats - c.num_sold as available_seats from CruiseInfo ci, Ship s, Cruise c where ci.cruise_id = %d AND ci.cruise_id = c.cnum AND ci.ship_id = s.id", cnum);
			int rowCount = esql.executeQueryAndPrintResult(query);
			System.out.println ("total row(s): " + rowCount);

		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static void ListsTotalNumberOfRepairsPerShip(DBproject esql) {//6
		// Count number of repairs per Ships and list them in descending order
		try {
			String query = String.format("select repair_count.id, repair_count.repairs from (select s.id as id, count(r.rid) as repairs from Ship s, Repairs r where s.id = r.ship_id group by s.id) as repair_count order by repair_count.repairs desc");

			int rowCount = esql.executeQueryAndPrintResult(query);
			System.out.println ("total row(s): " + rowCount);

		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static void FindPassengersCountWithStatus(DBproject esql) {//7
		// Find how many passengers there are with a status (i.e. W,C,R) and list that number.
		try {
			//reading ints
 			System.out.print("Please enter a cruise number: ");
			int cnum = Integer.parseInt(in.readLine());
			//reading strings
			System.out.print("Please enter a reservation status: ");
			String status = in.readLine();

			String query = String.format(
			"select r.status, count(*) from Reservation r where r.status = '%s' AND r.cid = %d group by r.status", status, cnum);
			int rowCount = esql.executeQueryAndPrintResult(query);

			System.out.println ("total row(s): " + rowCount);

		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
