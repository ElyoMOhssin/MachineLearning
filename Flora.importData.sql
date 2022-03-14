SELECT
	`c`.`customer_id`,
	`c`.`sex_at_birth`,
	TIMESTAMPDIFF(YEAR, `c`.`birthdate`,`invoice_tot`.`first_order`) AS `age`,
    `o`.`occupation`,
    `emplyment`.`employment_type`,
    `education`.`education`,
    `c`.`completed_years_of_education`,
    `marital`.`marital_status`,
    `relationship`.`relationship_in_household`,
    `race`.`race`,
    `country`.`country`,
    `type`.`type_of_client`,
    `invoice_tot`.`total_revenue_by_invoice`,
    `invoice_tot`.`average_spending_per_unit`,
    `invoice_tot`.`total_quantity`,
    `invoice_tot`.`total_products`,
    `invoice_tot`.`max_spend_per_unit`,
    `invoice_tot`.`min_spend_per_unit`,
    `invoice_tot`.`max_quantity`,
    `invoice_tot`.`min_quantity`
FROM
    `H_Retail`.`customer` AS `c`
		LEFT JOIN
    `H_Retail`.`occupation` AS `o`
	ON `c`.`occupation_id` = `o`.`occupation_id`
		LEFT JOIN
    `H_Retail`.`employment_type` AS `emplyment`
    ON `c`.`employment_type_id` = `emplyment`.`employment_type_id`
		LEFT JOIN
    `H_Retail`.`education` AS `education`
    ON `c`.`education_id` = `education`.`education_id`
		LEFT JOIN
    `H_Retail`.`marital_status` AS `marital`
    ON `c`.`marital_status_id` = `marital`.`marital_status_id`
    	LEFT JOIN
    `H_Retail`.`relationship_in_household` AS `relationship`
    ON `c`.`relationship_in_household_id` = `relationship`.`relationship_in_household_id`
		LEFT JOIN
    `H_Retail`.`race` AS `race`
    ON `c`.`race_id` = `race`.`race_id`
		LEFT JOIN
    `H_Retail`.`country` AS `country`
    ON `c`.`original_country_of_citizenship_id` = `country`.`country_id`
		LEFT JOIN
    `H_Retail`.`type_of_client_staging2` AS `type`
    ON `c`.`customer_id` = `type`.`customer_id`	
		INNER JOIN
	`H_Retail`.`invoice2` AS `invoice`
    ON `c`.`customer_id` = `invoice`.`customer_id`
		INNER JOIN
	`H_Retail`.`invoice_line` AS `invoice_line`
    ON `invoice`.`invoice_id` = `invoice_line`.`invoice_id`
		INNER JOIN
	(SELECT 
    `invoice`.`customer_id` AS `customer_id`,
    SUM(`invoice_line`.`quantity` * `invoice_line`.`unit_price`) AS `total_revenue_by_invoice`,
    AVG(`invoice_line`.`unit_price`) AS `average_spending_per_unit`,
    SUM(`invoice_line`.`quantity`) AS `total_quantity`,
    COUNT(`invoice_line`.`product_id`)AS `total_products`,
    MAX(`invoice_line`.`unit_price`) AS `max_spend_per_unit`,
    MIN(`invoice_line`.`unit_price`) AS `min_spend_per_unit`,
    MAX(`invoice_line`.`quantity`) AS `max_quantity`,
    MIN(`invoice_line`.`quantity`) AS `min_quantity`,
    MIN(`invoice`.`date`) AS `first_order`
FROM
    `H_Retail`.`invoice2` AS `invoice`
INNER JOIN
	`H_Retail`.`invoice_line` AS `invoice_line`
    ON `invoice`.`invoice_id` = `invoice_line`.`invoice_id`
WHERE `invoice`.`customer_id` <> 0
GROUP BY `invoice`.`customer_id`) AS `invoice_tot` on `c`.`customer_id` = `invoice_tot`.`customer_id`
GROUP BY `c`.`customer_id`
    ;