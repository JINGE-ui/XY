val n = getInt();
val m = getInt();
(*用邻接表实现边的存储，且舍弃0，从1开始计数*)
val V = Array2.array(n+1,n+1,~1);
val dfn = Array.array(n+1,~1);
val low = Array.array(n+1,~1);
val fa = Array.array(n+1,0);
val iscut = Array.array(n+1,false);

fun readin _ = 
let val u = getInt() and v = getInt()
val t1 = Array2.update(V,u,v,1) and t2 = Array2.update(V,v,u,1)
in 0 end;
List.tabulate(m,readin);

val arr = Array.tabulate(n,fn x=>x+1);

fun tarjan(u:int,from:int,index:int) = 
let val t1 = Array.update(dfn,u,index) and t2 = Array.update(low,u,index)
and t3 = Array.update(fa,u,from);
val t4 = Array.foldl (fn(i,_)=> if Array2.sub(V,u,i) = 1 then 
if Array.sub(dfn,i) = ~1 then let val t1 = tarjan(i,u,index+1) 
and t2 = Array.update(low,u,Int.min(Array.sub(low,u),Array.sub(low,i))) in 0 end
else if from <> i then let 
val t3 = Array.update(low,u,Int.min(Array.sub(low,u),Array.sub(dfn,i))) in 0 end
else 0 else 0) 0 arr;
in 0 end;

tarjan(1,~1,1);

val c = Array.foldli (fn(i,v,rootson)=>if i = 0 orelse i = 1 then 0
else if v = 1 then rootson + 1 
else if Array.sub(low,i) >= Array.sub(dfn,v) then 
let val tmp = Array.update(iscut,v,true) in rootson end
else rootson) 0 fa;
if c > 1 then Array.update(iscut,1,true) else ();

val ecut = Array.foldli (fn(i,v,num)=>
if v > 0 andalso Array.sub(low,i) > Array.sub(dfn,v) then num+1 else num) 0 fa;
val vcut = Array.foldl (fn(v,num)=> if v = true then num + 1 else num) 0 iscut;

printInt(vcut);
printInt(ecut);