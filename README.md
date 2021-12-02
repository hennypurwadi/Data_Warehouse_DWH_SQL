# DataMart_SQL
Build a datamart for Renting Apartments and Bedrooms with SQL

Database for Renting Apartments and Bedrooms
Concept Phase: The Definition and Requirement Specification

Software for processing: Word, exported to Pdf
Tool to draw ER-Models: drawsql
DBMS: MySQL

Installation:
From MySQL click File, Open SQL Scripts, choose “datamart.sql” file, click “execute” icon to Run 
the scripts, then click “refresh” button in SCHEMAS.

Three main roles in the concept:
•Host who serve with their properties.
•Guest who make the booking and payment.
•Marketplace who play role as a bridge between Host and Guest, handling the booking and payment.

List of tables : 
property_commission, facilities, location, amenities, host, property, room,
guest_commission, guest_review, guest,
booking, payment, voucher, cancelation. 

Existing problem need to be discovered: 
1. Whether an entity need to be listed as a table, or listed as a column in table, or can be virtual column calculated by SQL queries. For example: availability, guest_active, guest_level.
2. Since guest and host can rate each other, how the database can show contradictive condition? 
For example: a host give bad rate to his guest, but the guest give good rate to the host's property.
3. The wiser relationship from one table to another. For example: the best relation is host-payment-guest, or host-booking-guest. (booking and payment has direct relation).


Development Phase of Data mart

The problems in development phase :

1.How to order referenced tables before the table which references them, where several tables referencing to each others. For example country table must be created before city table, because countryID is foreign key inside city table. If we order otherwise, will cause an error.

2.In which table we need to put foreign keys are problems. 
For example where we can put guestID as foreign key, in booking table pr payment table?
Since not all booking will move on to payment, but all payment will have bookingID, it's wiser to put guestID as foreign key in booking table, instead of in payment table.

3. Insert into table also need to follow order of table creation order. Otherwise will create error.

Interesting to test whether the database can show the result  expected.
For example with JOIN between booking table and room table, we can find how much the guest need to pay, with calculation of (checkout_date - checkin_date) * room_rate.


Finalization Phase

Database Management Functionality:To can gain information to make decision. 

1. To analyse: Did too high cancelation charge relate to low booking quantity? Did low
cancelation charge relate to high booking quantity? From data below, seems yes.
Low cancelation charge attract 7 bookings, high cancelation charge only attract 2 bookings.
 
2. To ban guests who received too many bad reviews from good hosts with good property 
rating. From data below, we can’t trust bad review which came from bad host ID#12 for guest 
ID#9, since host with ID#12 bad review from other guests.
But seems guest with ID#4 and ID#6 are really bad guests, since bad reviews came from 
good hosts ID #17 and #15 who received.
If guest with ID #4 and #6 receive more negative reviews from more hosts, marketplace can 
ban those guests temporarily or permanently.

3. To decrease commission from inactive host (host_active=0) to attract them to be more active.

4. To know in which city/ which country send marketing team to get more hosts to join the 
marketplace.

5. To know if there are too much payment’s error within certain period.
And many more info we can gET from the database.


