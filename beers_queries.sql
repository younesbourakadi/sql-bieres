-- Combien de bières différentes sont disponibles dans la base de données ? 
-- 3922 biéres

SELECT COUNT(id_article)
FROM article
ORDER BY id_article;

-- Quel est le nom de la bière avec le prix de vente le plus élevé ? 

SELECT article_name, MAX(purchase_price) AS price
FROM article  
GROUP BY id_article
ORDER BY price DESC;

-- Quel est le nom du continent qui compte le plus grand nombre de pays répertoriés dans la base de données ? 

SELECT continent_name, COUNT(country_name) AS nb_countries
FROM continent
      JOIN country ON country.id_continent = continent.id_continent
GROUP BY continent_name
ORDER BY nb_countries DESC
LIMIT 1;

-- Quel est le nom du pays d'origine de la marque de bière Heineken ? 
 
SELECT country_name, brand_name
FROM country 
      JOIN brand USING(id_country)
WHERE brand_name LIKE "%heineken%";

-- Combien de bières ont été vendues lors de chaque transaction ? 
-- Afficher les numéros de ticket, la date de ticket, et le nombre de bières.

SELECT id_ticket, ticket_date, SUM(quantity) AS quantity_of_beer
FROM ticket JOIN sale USING(id_ticket) JOIN article USING(id_article)
GROUP BY id_ticket
ORDER BY id_ticket;


-- Quel est le nombre total de bières vendues jusqu'à présent ? 
SELECT SUM(quantity) AS total_sold_beer
FROM sale ;


-- Quelle est la marque de bière la plus vendue (en termes de quantité) ? 
SELECT brand_name, SUM(quantity) AS most_sold_brand
FROM sale JOIN article USING(id_article) JOIN brand USING(id_brand)
GROUP BY id_brand
ORDER BY most_sold_brand DESC
LIMIT 1 ;



-- ##### SECOND EXO #####



-- 1/ Afficher la liste des articles avec leur nom, prix d'achat et quantité totale vendue (en nombre de bière).

SELECT article_name, purchase_price, SUM(quantity)
FROM sale JOIN article USING(id_article)
GROUP BY id_article
ORDER BY article_name;


-- 2/ Afficher le nombre de bières vendues par pays, en affichant le nom du pays.

SELECT country_name, SUM(quantity) AS total_sold
FROM country JOIN brand USING(id_country) JOIN article USING(id_brand) JOIN sale USING (id_article)
GROUP BY id_country;

-- 3/ Afficher la quantité totale de bières vendues par marque, avec le nom de chaque marque, triée par ordre décroissant.

SELECT brand_name, SUM(quantity) AS total_quantity FROM brand
  JOIN article USING(id_brand)
  JOIN sale USING (id_article)
GROUP BY id_brand
ORDER BY total_quantity DESC;


-- 4/ Afficher la quantité totale de bières vendues par continent, en affichant le nom du continent.

SELECT continent_name, SUM(quantity) AS total_quantity FROM continent
  JOIN country USING(id_continent)
  JOIN brand USING(id_country)
  JOIN article USING(id_brand)
  JOIN sale USING (id_article)
GROUP BY id_continent
ORDER BY total_quantity DESC;

-- 5/ Afficher la moyenne des prix d'achat des articles par type, en indiquant le nom du type et la moyenne des prix d'achat.

SELECT type_name, AVG(purchase_price) AS average_purchase_price FROM type
  JOIN article USING(id_type)
GROUP BY type_name
ORDER BY average_purchase_price DESC;

-- 6/ Afficher la somme des quantités vendues pour chaque couleur de bière, en affichant le nom de la couleur et la somme des quantités.

SELECT color_name, SUM(quantity) AS total_quantity FROM color
  JOIN article USING(id_color)
  JOIN sale USING (id_article)
GROUP BY color_name
ORDER BY total_quantity DESC;


-- 7/ Afficher le volume total des ventes réalisées pour chaque marque, trié par ordre décroissant.

SELECT brand_name, SUM(quantity * volume) AS total_volume FROM brand
  JOIN article USING(id_brand)
  JOIN sale USING (id_article)
GROUP BY brand_name
ORDER BY total_volume DESC;

-- 8/ Afficher le prix d'achat moyen des articles pour chaque pays, en indiquant le nom du pays et le prix d'achat moyen.

SELECT country_name, AVG(purchase_price) AS average_purchase_price 
FROM country
  JOIN brand USING(id_country)
  JOIN article USING(id_brand)
GROUP BY country_name
ORDER BY average_purchase_price DESC;

-- 9/ Afficher le prix d'achat le plus élevé et le prix d'achat le plus bas par continent, en précisant le nom du continent.

SELECT MAX(purchase_price), MIN(purchase_price), continent_name
FROM article JOIN brand USING(id_brand) JOIN country USING(id_country)
 JOIN continent USING(id_continent)
 GROUP BY continent_name;


-- 10/ Afficher le nombre total d'articles vendus pour chaque type de bière, en affichant le nom du type et le nombre total d'articles vendus.

SELECT type_name, article_name, SUM(quantity) AS total
FROM type JOIN article USING(id_type) JOIN sale USING(id_article)
GROUP BY id_article
ORDER BY type_name;


 -- EXERCICE 3    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- 1/ Quels sont les tickets qui comportent l'article d'ID 500 ?
-- Afficher le numéro de ticket uniquement.

SELECT id_ticket
FROM sale JOIN article USING(id_article)
WHERE id_article = 500;

-- 2/ Quels sont les tickets du 15/01/2017 ?
-- Afficher le numéro de ticket et la date.

SELECT ticket_date, id_ticket
FROM ticket
WHERE YEAR(ticket_date) = 2017 AND MONTH(ticket_date)= 01 AND DAY(ticket_date) = 15;


-- 3/ Quels sont les tickets émis du 15/01/2017 au 17/01/2017 ?
-- Afficher le numéro de ticket et la date.

SELECT ticket_date, id_ticket
FROM ticket
WHERE ticket_date BETWEEN "2017-01-15" AND "2017-01-17"
GROUP BY id_ticket
ORDER BY ticket_date;

-- 4/ Quels sont les articles (Code et nom uniquement) apparaissant sur un ticket à au moins 95 exemplaires.

SELECT id_article, article_name, SUM(quantity) AS q
FROM article JOIN sale USING(id_article)
GROUP BY id_article
HAVING  q >= 95
ORDER BY q DESC; 





