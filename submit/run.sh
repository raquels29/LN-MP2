#!/bin/bash

mkdir -p compiled images

for i in sources/*.txt tests/*.txt; do
	echo "Compiling: $i"
    fstcompile --isymbols=syms.txt --osymbols=syms.txt $i | fstarcsort > compiled/$(basename $i ".txt").fst
done


# text2num
fstconcat compiled/horas.fst compiled/e.fst compiled/horas+e.fst
fstconcat compiled/horas+e.fst compiled/minutos.fst compiled/text2num.fst

# lazy2num
fstconcat compiled/horas.fst compiled/lazye.fst compiled/horas+le.fst
fstconcat compiled/horas+le.fst compiled/minutos.fst compiled/lazy2num.fst
 
# rich2text
fstproject compiled/horas+e.fst compiled/inputhoras.fst
fstunion compiled/meias.fst compiled/quartos.fst compiled/meias+quartos
fstconcat compiled/inputhoras.fst compiled/meias+quartos compiled/rich2text.fst

# rich2num
fstarcsort --sort_type=olabel compiled/rich2text.fst compiled/rich2text_sorted.fst
fstarcsort --sort_type=ilabel compiled/lazy2num.fst compiled/lazy2num_sorted.fst
fstcompose compiled/rich2text_sorted.fst compiled/lazy2num_sorted.fst compiled/rich2numA.fst
fstunion compiled/rich2numA.fst compiled/lazy2num_sorted.fst compiled/rich2num.fst

# num2text
fstinvert compiled/rich2num.fst compiled/num2text.fst

for i in compiled/*.fst; do
	echo "Creating image: images/$(basename $i '.fst').pdf"
    fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
done


#tests
echo "Testing the transducer 'rich2num' with the input 'tests/sleepA_89413.txt'"
fstcompose compiled/sleepA_89413.fst compiled/rich2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'num2text' with the input 'tests/sleepB_89413.txt'"
fstcompose compiled/sleepB_89413.fst compiled/num2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'rich2num' with the input 'tests/wakeupA_89413.txt'"
fstcompose compiled/wakeupA_89413.fst compiled/rich2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'num2text' with the input 'tests/wakeupB_89413.txt'"
fstcompose compiled/wakeupB_89413.fst compiled/num2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'rich2num' with the input 'tests/sleepC_89533.txt'"
fstcompose compiled/sleepC_89533.fst compiled/rich2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'num2text' with the input 'tests/sleepD_89533.txt'"
fstcompose compiled/sleepD_89533.fst compiled/num2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'rich2num' with the input 'tests/wakeupC_89533.txt'"
fstcompose compiled/wakeupC_89533.fst compiled/rich2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'num2text' with the input 'tests/wakeupD_89533.txt'"
fstcompose compiled/wakeupD_89533.fst compiled/num2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

