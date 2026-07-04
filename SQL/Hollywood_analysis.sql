CREATE TABLE hollywood_movies (
    film VARCHAR(255),
    genre VARCHAR(100),
    lead_studio VARCHAR(150),
    audience_score NUMERIC,
    profitability NUMERIC,
    rotten_tomatoes NUMERIC,
    worldwide_gross NUMERIC,
    release_year INT,
	rating_category VARCHAR(100),
	profit_category VARCHAR(100),
    gross_category VARCHAR(100)
);


--Total number of movies--
SELECT COUNT(*) FROM hollywood_movies;

--Average profitability--
SELECT ROUND(AVG(profitability),2) 
FROM hollywood_movies;

--Total worldwide gross--
SELECT ROUND(SUM(worldwide_gross),2)
FROM hollywood_movies;

----Top 10 most profitable movies--
SELECT film, profitability
FROM hollywood_movies
ORDER BY profitability DESC
LIMIT 10;

--Top 10 highest grossing movies--
SELECT film, worldwide_gross
FROM hollywood_movies
ORDER BY worldwide_gross DESC
LIMIT 10;

--Number of movies by genre--
SELECT genre, COUNT(film) 
FROM hollywood_movies
GROUP BY genre;

--Average profitability by genre--
SELECT genre, ROUND(AVG(profitability),2)
FROM hollywood_movies
GROUP BY genre;

--Total worldwide gross by genre--
SELECT genre, ROUND(SUM(worldwide_gross),2)
FROM hollywood_movies
GROUP BY genre;

--Average profitability by studio--
SELECT lead_studio, ROUND(AVG(profitability),2)
FROM hollywood_movies
GROUP BY lead_studio;

----Movies released each year--
SELECT release_year,COUNT(film)
FROM hollywood_movies
GROUP BY release_year
ORDER BY release_year; 

--Average profitability by year
SELECT release_year,ROUND(AVG(profitability),2)
FROM hollywood_movies
GROUP BY release_year
ORDER BY release_year; 

--Movies with worldwide gross above the overall average--
SELECT film, worldwide_gross
FROM hollywood_movies
WHERE worldwide_gross >
(
  SELECT ROUND(AVG(worldwide_gross),2)
  FROM hollywood_movies
)
ORDER BY worldwide_gross DESC;

--Rank movies by profitability--
SELECT film,profitability,
RANK() OVER(ORDER BY profitability DESC) as profit_rank
FROM hollywood_movies;

--Rank movies within each genre--
SELECT genre, film,profitability,
RANK() OVER (PARTITION BY genre
             ORDER BY profitability DESC) as genre_rank
FROM hollywood_movies;

---High audience score but low Rotten Tomatoes score--
SELECT
    film,
    genre,
    audience_score,
    rotten_tomatoes
FROM hollywood_movies
WHERE audience_score >= 80
  AND rotten_tomatoes < 60
ORDER BY audience_score DESC;

			 
