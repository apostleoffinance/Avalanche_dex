 --Top 10 Swapped Tokens And Amount Swapped 
/*SELECT *
FROM ethereum.core.ez_dex_swaps
LIMIT 100*/

WITH top_tokens AS 
  (SELECT symbol_in,
  	COUNT(DISTINCT tx_hash) AS swaps
   FROM ethereum.core.ez_dex_swaps
   WHERE event_name = 'Swap'
   AND platform = 'uniswap-v3'
   AND symbol_in IS NOT NULL
   GROUP BY 1
   ORDER BY 2 DESC
   LIMIT 10)

SELECT date_trunc('month', block_timestamp) AS monthly,
  	   symbol_in,
  	   COUNT(DISTINCT tx_hash) as swaps,
	   SUM(ABS(amount_in_usd) + ABS(amount_out_usd))/2 AS swap_volunme
FROM ethereum.core.ez_dex_swaps
WHERE event_name = 'Swap'
AND symbol_in IS NOT NULL 
AND symbol_in IN (SELECT symbol_in from top_tokens)
AND platform = 'uniswap-v3'
AND monthly >= CURRENT_DATE  - INTERVAL '2 years'
GROUP BY 1,2
