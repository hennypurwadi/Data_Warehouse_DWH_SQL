# DataMart_SQL
Build a datamart for Renting Apartments and Bedrooms with SQL

### Presentation:
https://youtu.be/ZEq-_trr3_s


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


### Data Warehouse Development using MySQL
This is the development of a data warehouse using MySQL as the database management system.

In this ER diagram, there are three user groups:

The green group represents hosts, including their properties, cities, and countries.

The yellow group represents guests, who can make bookings, leave ratings, and write reviews.

And finally, the marketplace group acts as a bridge between hosts and guests, managing bookings, payments, and paying out commissions to hosts after receiving payments from guests.

Now, let’s explore the SQL code used in this data mart.

Each table includes up to 20 attributes. For instance, the country table has country_id and country_name.
The city table links to country via a foreign key country_id, while city_id serves as its primary key.

The property_commission table records different commission rates for each property.
Property_type defines whether a property is a hotel, guesthouse, homestay, vacation home, or apartment.

The neighborhood table connects to the city table, which in turn connects to country.
Using natural joins, we can retrieve the country name directly from a neighborhood.
For example, neighborhoods in Berlin and Munich show the country as Germany.

The property_host table lists the host’s name, contact information, and address.
The property table includes commission ID, rating, size, room quantity, and property address.

The facility table indicates available amenities like internet, parking, and swimming pools—1 means available, 0 means not.

Then we have room_type, room, and guest tables, all linkable through natural joins.
This powerful feature of MySQL allows insights across multiple tables.

We can, for example, filter guests with ratings under 3 and low guest levels.

The review tables help detect problem guests—if negative reviews come from trusted hosts, action can be taken.
Guest IDs 4 and 6, for instance, may be flagged if multiple good hosts give consistently bad reviews.

Cancellations, bookings, vouchers, and payments are also tracked.
Patterns show low cancellation rates often correlate with higher booking volumes.

Payment issues are tracked in the payment_status table, and inactive hosts can be identified by their activity status.

This database also helps marketing teams target cities or countries where new hosts are needed.

All of this is made possible by MySQL and structured data design.

This concludes my presentation.
