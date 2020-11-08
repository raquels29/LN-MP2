#!/bin/bash

mkdir -p compiled images

for i in sources/*.txt tests/*.txt; do
	echo "Compiling: $i"
    fstcompile --isymbols=syms.txt --osymbols=syms.txt $i | fstarcsort > compiled/$(basename $i ".txt").fst
done


# text2num
fstconcat compiled/horas.fst compiled/e.fst compiled/horas+e.fst
fstconcat compiled/horas+e.fst compiled/minutos.fst compiled/text2num.fst
#can be done without e? ~dont think so
#try to do this in one line

# lazy2num
fstconcat compiled/horas.fst compiled/lazye.fst compiled/horas+le.fst
fstconcat compiled/horas+le.fst compiled/minutos.fst compiled/lazy2num.fst
#try to join differently by altering text2num directly 
 
# rich2text
fstproject compiled/horas+e.fst compiled/inputhoras.fst
fstunion compiled/meias.fst compiled/quartos.fst compiled/meias+quartos
fstconcat compiled/inputhoras.fst compiled/meias+quartos compiled/rich2text.fst
#try to do this in one line

# rich2num
#fstproject compiled/rich2text.fst compiled/rich.fst
#fstcompose compiled/rich.fst compiled/lazy2num.fst compiled/rich2num.fst
#fstproject compiled/rich2text.fst compiled/rich.fst
#fstintersect compiled/rich.fst compiled/lazy2num.fst compiled/rich2num.fst
#fstunion compiled/lazy2numP.fst compiled/rich2text.fst

# num2text
#fstinvert compiled/rich2num.fst compiled/num2text.fst
# TODO always using the words hora(s) and minuto(s).

for i in compiled/*.fst; do
	echo "Creating image: images/$(basename $i '.fst').pdf"
    fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
done


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

echo "Testing the transducer 'quartos' with the input 'tests/um_quarto.txt'"
fstcompose compiled/um_quarto.fst compiled/quartos.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'quartos' with the input 'tests/dois_quartos.txt'"
fstcompose compiled/dois_quartos.fst compiled/quartos.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
echo "Testing the transducer 'quartos' with the input 'tests/tres_quartos.txt'"
fstcompose compiled/tres_quartos.fst compiled/quartos.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

echo "Testing the transducer 'meias' with the input 'tests/meia.txt'"
fstcompose compiled/meia.fst compiled/meias.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt

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

#echo "Testing the transducer 'rich2num' with the input 'tests/dez_e_um_quarto.txt'"
#fstcompose compiled/dez_e_um_quarto.fst compiled/rich2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
#echo "Testing the transducer 'rich2num' with the input 'tests/dez_e_meia.txt'"
#fstcompose compiled/dez_e_meia.fst compiled/rich2text.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=./syms.txt
