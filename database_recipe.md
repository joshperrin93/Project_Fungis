Two Tables Design Recipe Template
Copy this recipe template to design and create two related database tables from a specification.

1. Extract nouns from the user stories or specification
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a user, I'd like to be able to find tasty restaurants around the world

As a user, I'd like to know information about each restaurant e.g. cuisine and price

As a user, I want to see the restaurants in categories so I can filter to the type of food I am looking for

As a user, I want to be able to log in

As a user, I want to be able to leave review and see a restaurants rating from other reviews

As a user, I want to be able to save my favourite restaurants

As a user, I want to view restaurants based on how close they are to my location

Nouns:
email, password, name



2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

Record	        Properties
users	        email, password, name
reviews         place_id, text, rating, user_id, date_posted
favourites      place_id, user_id

Name of the first table (always plural): users

Column names: email, password, name

Name of the second table (always plural): reviews

Column names: place_id, comment, rating, user_id, date_posted

Name of the second table (always plural): favourites

Column names: place_id, user_id

3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: users
id: SERIAL
email: text
password: text
name: text

Table: reviews
id: SERIAL
place_id: text
comment: text
rating: float
date_posted: date
user_id: int

Table: favourites
id: SERIAL
place_id: text
user_id: int

4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one user have many reviews? Yes
Can one user have many favourites? Yes
Can one review have many users? No
Can one review have many favourites? No
Can one favourite have many users? No
Can one favourite have many reviews? No

Replace the relevant bits in this example with your own:

4. Write the SQL.
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email text,
  password text,
  name text
);

-- Then the table with the foreign key first.
CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  place_id text,
  comment text,
  rating float,
  date_posted date,
-- The foreign key name is always {other_table_singular}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

CREATE TABLE favourites (
  id SERIAL PRIMARY KEY,
  place_id text,
-- The foreign key name is always {other_table_singular}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);


5. Create the tables.
psql -h 127.0.0.1 vegan_restaurant_test < albums_table.sql