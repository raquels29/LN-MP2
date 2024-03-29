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

echo "Testing the transducer 'converter' with the input 'tests/numero.txt'"
fstcompose compiled/numero.fst compiled/converter.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'horas' with the input 'tests/uma.txt'"
fstcompose compiled/uma.fst compiled/horas.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'horas' with the input 'tests/uma_hora.txt'"
fstcompose compiled/uma_hora.fst compiled/horas.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'horas' with the input 'tests/uma_horas.txt'"
fstcompose compiled/uma_horas.fst compiled/horas.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'horas' with the input 'tests/catorze_horas.txt'"
fstcompose compiled/catorze_horas.fst compiled/horas.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'horas' with the input 'tests/tres_horas.txt'"
fstcompose compiled/tres_horas.fst compiled/horas.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'horas' with the input 'tests/catorze_hora.txt'"
fstcompose compiled/catorze_hora.fst compiled/horas.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'horas' with the input 'tests/vinte_e_uma_hora.txt'"
fstcompose compiled/vinte_e_uma_hora.fst compiled/horas.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'horas' with the input 'tests/vinte_e_tres_hora.txt'"
fstcompose compiled/vinte_e_tres_hora.fst compiled/horas.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'horas' with the input 'tests/vinte_e_tres_horas.txt'"
fstcompose compiled/vinte_e_tres_horas.fst compiled/horas.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'minutos' with the input 'tests/um.txt'"
fstcompose compiled/um.fst compiled/minutos.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'minutos' with the input 'tests/dois_minutos.txt'"
fstcompose compiled/dois_minutos.fst compiled/minutos.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'minutos' with the input 'tests/vinte_e_oito_minutos.txt'"
fstcompose compiled/vinte_e_oito_minutos.fst compiled/minutos.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'minutos' with the input 'tests/quarenta_e_tres.txt'"
fstcompose compiled/quarenta_e_tres.fst compiled/minutos.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'meias' with the input 'tests/meia.txt'"
fstcompose compiled/meia.fst compiled/meias.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'quartos' with the input 'tests/um_quarto.txt'"
fstcompose compiled/um_quarto.fst compiled/quartos.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'quartos' with the input 'tests/dois_quartos.txt'"
fstcompose compiled/dois_quartos.fst compiled/quartos.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'quartos' with the input 'tests/tres_quartos.txt'"
fstcompose compiled/tres_quartos.fst compiled/quartos.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'text2num' with the input 'tests/dez_horas_e_quinze.txt'"
fstcompose compiled/dez_horas_e_quinze.fst compiled/text2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'text2num' with the input 'tests/dez_e_quinze_minutos.txt'"
fstcompose compiled/dez_e_quinze_minutos.fst compiled/text2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'text2num' with the input 'tests/dez_horas_e_quinze_minutos.txt'"
fstcompose compiled/dez_horas_e_quinze_minutos.fst compiled/text2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'lazy2num' with the input 'tests/dez_horas_e_quinze.txt'"
fstcompose compiled/dez_horas_e_quinze.fst compiled/lazy2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'lazy2num' with the input 'tests/dez.txt'"
fstcompose compiled/dez.fst compiled/lazy2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'rich2text' with the input 'tests/dez_e_um_quarto.txt'"
fstcompose compiled/dez_e_um_quarto.fst compiled/rich2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'rich2text' with the input 'tests/dez_e_meia.txt'"
fstcompose compiled/dez_e_meia.fst compiled/rich2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'rich2text' with the input 'tests/dez_horas_e_um_quarto.txt'"
fstcompose compiled/dez_horas_e_um_quarto.fst compiled/rich2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'rich2num' with the input 'tests/dez_e_um_quarto.txt'"
fstcompose compiled/dez_e_um_quarto.fst compiled/rich2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'rich2num' with the input 'tests/dez_e_meia.txt'"
fstcompose compiled/dez_e_meia.fst compiled/rich2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'rich2num' with the input 'tests/dez.txt'"
fstcompose compiled/dez.fst compiled/rich2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'rich2num' with the input 'tests/dez_horas_e_quinze.txt'"
fstcompose compiled/dez_horas_e_quinze_minutos.fst compiled/rich2num.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'num2text' with the input 'tests/1_0_:_1_5.txt'"
fstcompose compiled/1_0_:_1_5.fst compiled/num2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'num2text' with the input 'tests/0_0_:_0_0.txt'"
fstcompose compiled/0_0_:_0_0.fst compiled/num2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'num2text' with the input 'tests/0_0_:_3_0.txt'"
fstcompose compiled/0_0_:_3_0.fst compiled/num2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'num2text' with the input 'tests/0_9_:_0_3.txt'"
fstcompose compiled/0_9_:_0_3.fst compiled/num2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'num2text' with the input 'tests/1_3_:_2_9.txt'"
fstcompose compiled/1_3_:_2_9.fst compiled/num2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'num2text' with the input 'tests/2_2_:_4_5.txt'"
fstcompose compiled/2_2_:_4_5.fst compiled/num2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

############################

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

for i in tests/*.txt; do
	echo "Compiling: $i"
    fstcompile --isymbols=syms.txt --osymbols=syms.txt $i | fstarcsort > compiled/$(basename $i ".txt").fst
done

for i in compiled/*.fst; do
	echo "Creating image: images/$(basename $i '.fst').pdf"
    fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
done
