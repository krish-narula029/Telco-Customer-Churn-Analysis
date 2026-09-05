create database telco_final;
use telco_final;
show tables;
select * from telco_final limit 10;
select count(*) as total_customers;
describe telco_final;
select churn,count(*) as customers from telco_final group by churn;
select round(sum(case when Churn = 'Yes' then 1 else 0 end)*100.0 / count(*),2) as churn_rate from telco_final;
select contract,churn,count(*) as customers from telco_final group by contract,churn order by contract,churn;

select InternetService, Churn, count(*) as customers from telco_final group by InternetService, Churn
 order by InternetService, churn;
 
 select churn, round(avg(monthlycharges),2) as avg_monthly_charges from telco_final group by churn;
 select churn,round(avg(tenure),2) as avg_tenure from telco_final group by churn;
 select CustomerID, MonthlyCharges, TotalCharges, Churn from telco_final order by MonthlyCharges desc limit 10;
 select SeniorCitizen, Churn,count(*) as customers from telco_final group by SeniorCitizen, Churn;
 select PaymentMethod, churn, count(*) as customers from telco_final group by PaymentMethod, Churn order by
 PaymentMethod, Churn;
 
 select gender, churn, count(*) as customers from telco_final group by gender, churn;
 
select gender, count(*) as total_customers, sum(case when Churn = 'Yes' then 1 else 0 end) as churned_customers, 
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0 / count(*),2) as churn_rate from telco_final group by gender;

select contract, count(*) as total_customers, sum(case when Churn = 'Yes' then 1 else 0 end) as churned_customers, 
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0 / count(*),2) as churn_rate from telco_final group by contract order by churn_rate desc;

select InternetService, count(*) as total_customers, sum(case when Churn = 'Yes' then 1 else 0 end) as churned_customers, 
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0 / count(*),2) as churn_rate from telco_final group by InternetService order by churn_rate desc;

select PaymentMethod, count(*) as total_customers, sum(case when Churn = 'Yes' then 1 else 0 end) as churned_customers, 
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0 / count(*),2) as churn_rate from telco_final group by PaymentMethod order by churn_rate desc;

 select SeniorCitizen, count(*) as total_customers, sum(case when Churn = 'Yes' then 1 else 0 end) as churned_customers, 
round(sum(case when churn = 'yes' then 1 else 0 end)*100.0 / count(*),2) as churn_rate from telco_final group by SeniorCitizen order by churn_rate desc;

select case when tenure <=12 then '0-12 months'
when tenure <=24 then '13-24 months'
when tenure <=48 then '25-48 months'
when tenure <= 60 then '49-60 months'
else '61+ months' end as tenure_group, count(*) as total_customers, sum(case when churn = 'yes' then 1 else 0 end) as churned_customers,
round(sum(case when churn = 'yes' then 1 else 0 end)* 100.0 / count(*),2) as churn_rate from telco_final group by tenure_group order by churn_rate desc;

select contract, round(avg(TotalCharges),2) as avg_total_charges, round(avg(MonthlyCharges),2) as avg_monthly_charges,
round(avg(tenure),2) as avg_tenure from telco_final group by contract order by avg_total_charges;

select case when MonthlyCharges < 40 then 'Low'
when MonthlyCharges < 80 then 'Medium' 
else 'High' end as charge_group, count(*) as total_customers, sum(churn = 'Yes') as churned_customers,
round(sum(churn = 'Yes') * 100.0/count(*),2) as churn_rate from telco_final group by charge_group order by churn_rate desc;

select Contract,InternetService, count(*) as customers, sum(churn = 'yes') as churned, round(sum(churn = 'Yes') * 100.0 / count(*),2) as churn_rate
from telco_final group by Contract, InternetService order by churn_rate desc limit 10;

select CustomerID, Contract, InternetService, MonthlyCharges, Tenure, TotalCharges from telco_final where Churn = 'Yes'
order by MonthlyCharges desc limit 10;

select TechSupport, count(*) as customers, sum(churn = 'Yes' ) as churned, round(sum(churn = 'Yes') * 100.0 / count(*),2) as churn_rate
from telco_final group by TechSupport order by churn_rate desc;

select OnlineSecurity, count(*) as customers, sum(churn = 'Yes' ) as churned, round(sum(churn = 'Yes') * 100.0 / count(*),2) as churn_rate
from telco_final group by OnlineSecurity order by churn_rate desc;

select PaperlessBilling, count(*) as customers, sum(churn = 'Yes' ) as churned, round(sum(churn = 'Yes') * 100.0 / count(*),2) as churn_rate
from telco_final group by PaperlessBilling order by churn_rate desc;

select Contract, PaymentMethod, count(*) as customers, sum(churn = 'Yes') * 100.0 / count(*) as churn_rate from telco_final
group by Contract, PaymentMethod order by churn_rate desc limit 10;

select StreamingTV, count(*) as customers, sum(churn = 'Yes') * 100.0 / count(*) as churn_rate from telco_final
group by StreamingTV order by churn_rate desc;

select StreamingMovies, count(*) as customers, sum(churn = 'Yes') as churned, round(sum(churn = 'Yes') * 100.0 / count(*),2) as churn_rate 
from telco_final group by StreamingMovies order by churn_rate desc;

SELECT
    (
        (PhoneService = 'Yes') +
        (MultipleLines = 'Yes') +
        (OnlineSecurity = 'Yes') +
        (OnlineBackup = 'Yes') +
        (DeviceProtection = 'Yes') +
        (TechSupport = 'Yes') +
        (StreamingTV = 'Yes') +
        (StreamingMovies = 'Yes')
    ) AS service_count,
    COUNT(*) AS customers,
    SUM(churn = 'Yes') AS churned,
    ROUND(SUM(churn = 'Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_final
GROUP BY service_count
ORDER BY service_count;

SELECT
    Contract,
    CASE
        WHEN Tenure <= 12 THEN '0-12 months'
        WHEN Tenure <= 24 THEN '13-24 months'
        WHEN Tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_group,
    COUNT(*) AS customers,
    SUM(Churn = 'Yes') AS churned,
    ROUND(SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_final
GROUP BY Contract, tenure_group
ORDER BY churn_rate DESC;

SELECT
    Contract,
    CASE
        WHEN MonthlyCharges < 40 THEN 'Low'
        WHEN MonthlyCharges < 80 THEN 'Medium'
        ELSE 'High'
    END AS charge_group,
    COUNT(*) AS customers,
    SUM(Churn = 'Yes') AS churned,
    ROUND(SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_final
GROUP BY Contract, charge_group
ORDER BY churn_rate DESC;

SELECT
    CASE
        WHEN Tenure <= 12 THEN '0-12 months'
        WHEN Tenure <= 24 THEN '13-24 months'
        WHEN Tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_group,
    CASE
        WHEN MonthlyCharges < 40 THEN 'Low'
        WHEN MonthlyCharges < 80 THEN 'Medium'
        ELSE 'High'
    END AS charge_group,
    COUNT(*) AS customers,
    SUM(Churn = 'Yes') AS churned,
    ROUND(SUM(Churn = 'Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_final
GROUP BY tenure_group, charge_group
ORDER BY churn_rate DESC;
