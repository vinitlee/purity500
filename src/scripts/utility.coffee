@bound = (num,low,high) ->
  return Math.max(low,Math.min(high,num))