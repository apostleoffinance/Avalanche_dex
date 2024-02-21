SELECT 
    
      symbol_in,
      --count(distinct tx_hash) as swaps
      count(distinct origin_from_address) as swappers

FROM avalanche.core.ez_dex_swaps
WHERE event_name = 'Swap'
AND platform IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC 

LIMIT 10
