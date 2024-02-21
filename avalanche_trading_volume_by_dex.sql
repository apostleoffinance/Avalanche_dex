SELECT 
      platform,
      --date_trunc(day, block_timestamp) as date,
      sum(ABS(amount_in_usd) + ABS(amount_out_usd))/2 as total_trading_volume

FROM avalanche.defi.ez_dex_swaps
WHERE 'total_trading_volume' IS NOT NULL
GROUP By 1
ORDER BY 2 DESC 
LIMIT 10
