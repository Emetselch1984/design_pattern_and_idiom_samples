# mkdir -p test/{1,2,3,4,5}/{1,2,3,4,5}/{a,b,c,d,e,f}
# touch test/{1,2,3,4,5}/{1,2,3,4,5}/{a,b,c,d,e,f}.txt
require 'find'
results1 = []
Find.find('./test') do |f|
  results1 << f
end
results2 = []
Find.find('./test') do |f|
  next unless File.file?(f)
  results2 << f
end

def prune(f)
  Find.prune if f == "./test/1"
  Find.prune if f == "./test/2"
  Find.prune if f == "./test/3"

end

results4 = []
Find.find('./test') do |f|
  prune(f)
  results4 << f
end
results4



