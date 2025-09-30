CREATE database social_media_advertising;

USE social_media_advertising;

Commit;

select * from ad_campaign_performance;

/* Social Media Advertising campaign

A look into the campaign performance
ROI 
Strategy Optimization*/

-- Total revenue --

    select 
    ROUND(SUM(CAST(REPLACE(acquisition_cost, '$', '') AS DECIMAL(10,2)) * (1 + roi))) AS total_revenue
    FROM 
    ad_campaign_performance;

-- Sum of Acquisition Cost --
    
	select 
	ROUND(SUM(CAST(REPLACE(acquisition_cost, '$', '') AS DECIMAL(10,2)))) AS total_acquisition_cost
	FROM 
		ad_campaign_performance;

-- Avg ROI --

	select
	ROUND(AVG(roi),2) AS AVG_ROI
	FROM 
		ad_campaign_performance;

-- Avg Conversion Rate -- 

	select   
	ROUND(AVG(conversion_rate),2) AS AVG_Conversion_Rate
	FROM 
		ad_campaign_performance;
    
-- Total Profit --

#Added an additional row where I calculated click through rate per campaign where I took the (total clicks divided by impressions) multiplied by 100 #

SELECT
  channel_used,
  campaign_goal,
  duration,
  impressions,
  clicks,
  ROUND((clicks * 100.0 / impressions), 2) AS ctr,
  conversion_rate,
  engagement_score
FROM ad_campaign_performance
ORDER BY conversion_rate desc;

#ROI based on ad spent, conversions and revenue#
#Cleaned the data by removing the currency on acquisition cost using REPLACE(), and changing data type to an interger using CAST()#
#Added a revenue column using acquisition_cost * (1 + roi)#
#Calculated the profit in the profit column#


SELECT 
    campaign_id,
    channel_used,
    campaign_goal,
    conversion_rate,
    customer_segment,
    impressions,
    clicks,
    ROUND((clicks * 100.0 / impressions), 2) AS ctr,
    CAST(REPLACE(acquisition_cost, '$', '') AS DECIMAL(10,2)) AS acquisition_cost_clean,
    ROUND(roi, 2) AS roi,
    CAST(REPLACE(acquisition_cost, '$', '') AS DECIMAL(10,2)) * (1 + roi) AS revenue,
    ROUND((CAST(REPLACE(acquisition_cost, '$', '') AS DECIMAL(10,2)) * (1 + roi)) - 
    CAST(REPLACE(acquisition_cost, '$', '') AS DECIMAL(10,2)),2) AS profit
FROM 
    ad_campaign_performance
    ORDER BY profit desc;
    
    
    #Optimization Opportunities#
    
    #Which channel has the highest ROI#
    
	SELECT 
		channel_used, 
        ROUND(AVG(roi),2) AS avg_roi
	FROM
		ad_campaign_performance
	GROUP BY channel_used
	ORDER BY avg_roi DESC;

#Which target audience segment converts best?#

	SELECT 
		customer_segment, 
        ROUND(AVG(conversion_rate),2) AS avg_conversion
	FROM
		ad_campaign_performance
	GROUP BY customer_segment
	ORDER BY avg_conversion DESC;





















