
/*
Add ship: ask user for detals of a Ship and add it to the DB
attributes: ship_ID, model, make, age, seats

Add captain: Ask the user for details of a Captain and add it to the DB
attributes: cap_ID, name

Add cruise: Ask the user for details of a Cruise and add it to the DB
attributes: c_num, cost, num_sold, num_stops, actual_arrive_date, actual_arrive_time, source, destination, cap_ID

Book Cruise: Given a customer and Cruise taht he/she wants to book, determine the status of the reservation and add the reservation to the database with appropriate status

Relations: Customer, Cruise, Has, reservation, waitlist, confirmed, reserved
reservation has the primary key r_num and the statuses borrow as a foreign key
"Has" relation attributes: cust_ID, c_num, r_num

List total number of available seats for a given Cruise: Given a Cruise number and a departure date, find the number of available seats in the Cruise

List total number of repairs per Ship in descending order: Return the list of Ships in decreasing order of number of repairs that have been made on the Ships

Find total number of passengers with a given status: For a given Cruise and passenger status, return the number of passengers with the given status
*/
