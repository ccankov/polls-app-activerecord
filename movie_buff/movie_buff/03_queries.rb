def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie.joins(:actors)
    .where('actors.name IN (?)', those_actors)
    .select('movies.title, movies.id')
    .group('movies.id')
    .having('COUNT(*) = ?', those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  year = Movie.select('yr / 10 AS decade')
    .group('decade')
    .order('AVG(score) DESC')
    .limit(1)

  year.first.decade * 10
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  # Hint: use a subquery
  movies_w_actor = Movie.joins(:actors)
    .where('actors.name = ?', name)
    .pluck(:title)

  costars = Movie.joins(:actors)
    .where('movies.title IN (?) AND actors.name != ?', movies_w_actor, name)
    .pluck(:name)

  costars.uniq
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.joins('LEFT JOIN castings ON castings.actor_id = actors.id')
    .where('castings.movie_id IS NULL').count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the letters in whazzername,
  # ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"
  whazzername = "%" + whazzername.chars.join("%") + "%"
  Movie.joins(:actors)
    .where('lower(actors.name) LIKE ?', whazzername)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of their career.
  Movie.joins(:actors)
    .select('actors.id, actors.name, MAX(yr) - MIN(yr) AS career')
    .group('actors.id')
    .order('career DESC, actors.name')
    .limit(3)
end
