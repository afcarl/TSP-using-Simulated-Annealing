n=1000
df=data.frame(time=1:n,y=runif(n))
window=100

for(i in 1:(n-window)) {
  flush.console()
  plot(df$time,df$y,type='l',xlim=c(i,i+window))
  Sys.sleep(.05)
}