TRUNCATE TABLE users, reviews, favourites RESTART IDENTITY;

INSERT INTO users (email, password, name) VALUES ('josh@makers.com', 'password!123', 'Josh');
INSERT INTO users (email, password, name) VALUES ('ella@makers.com', 'password!123', 'Ella');
INSERT INTO users (email, password, name) VALUES ('maria@makers.com', 'password!123', 'Maria');
INSERT INTO users (email, password, name) VALUES ('kevwe@makers.com', 'password!123', 'Kevwe');
INSERT INTO reviews (place_id, comment, rating, date_posted, user_id, user_name) VALUES ('ChIJN1t_tDeuEmsRUsoyG83frY4', 'Very nice!', 4, '2022-01-01', 1, 'Josh');
INSERT INTO reviews (place_id, comment, rating, date_posted, user_id, user_name) VALUES ('ChIJN1t_tDeuEmsRUsoyG83frY4', 'OK', 3, '2022-03-01', 2, 'Ella');
INSERT INTO reviews (place_id, comment, rating, date_posted, user_id, user_name) VALUES ('ChIJN1t_tDeuEmsRUsoyG83frY4', 'Best in town', 5, '2022-05-01', 3, 'Maria');
INSERT INTO reviews (place_id, comment, rating, date_posted, user_id, user_name) VALUES ('ChIJN1t_tDeuEmsRUsoyG83frY4', 'Avoid!', 1, '2022-01-01', 1, 'Josh');
INSERT INTO favourites (place_id, user_id, name) VALUES ('ChIJk2NryLQpQg0R6SZUS4VF-84', 1, 'THUNDER Vegan Malasaña');
INSERT INTO favourites (place_id, user_id, name) VALUES ('ChIJr7qXjTYCdkgRu5uGS3VCckg', 2, 'Lovegift Vegan');