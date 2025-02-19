-- 1. Вывести количество городов для каждой страны. Результат должен содержать CountryCode, CityCount (количество городов в стране). 

select * from city;
select * from country;

select CountryCode, count(ID) as CityCount
from city
group by CountryCode;

-- Поменяйте запрос с использованием джойнов так, чтобы выводилось название страны вместо CountryCode. 

select co.Name, count(ID) as CityCount
from city
join country as co on co.Code = city.CountryCode
group by city.CountryCode;


-- 2. Вывести список стран с продолжительностью жизни и средней продолжительностью жизни (для всех стран). (Name, продолжительность жизни, средняя продолжительность жизни)
select * from country;

select avg(LifeExpectancy) from country;

select 
	Name, 
	avg(LifeExpectancy),
    (select avg(LifeExpectancy) from country) as avg_for_all_countries
from country
group by Name;



-- 3. Используя ранжирующие функции, вывести страны по убыванию продолжительности жизни.(Name, продолжительность жизни, ранг)
select * from country;

select 
    Name, 
    LifeExpectancy, 
    rank() over (order by LifeExpectancy desc) as `Rank`
from country;

-- 4. Используя ранжирующие функции, вывести третью страну с самой высокой продолжительностью жизни. (учесть, что таких стран может быть несколько).
select * from country;

select Code, Name, dense_rank() over (order by LifeExpectancy desc) LifeExp_pop from country;

select Name, LifeExp_pop from (select Code, Name, dense_rank() over (order by LifeExpectancy desc) LifeExp_pop from country) t1
where LifeExp_pop = 3;
