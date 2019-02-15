source shared.sh

echo "Generating ICs"

mkdir ics
cd ics

cp ../swiftsim-master/examples/HydroTests/SedovBlast_1D/makeIC.py .
cp ../swiftsim-master/examples/HydroTests/SedovBlast_1D/sedov.yml .
sed -i ''  s/numPart\ =\ 1001/import\ sys\;numPart=int\(sys\.argv\[1\]\)/ makeIC.py

for n_part in "${n_particles[@]}" 
do
	echo "Generating n=${n_part}"
	python3 makeIC.py $n_part
	mv sedov.hdf5 sedov_$n_part.hdf5

	cp sedov.yml sedov_$n_part.yml
	sed -i '' "s/\.\/sedov/\.\.\/\.\.\/ics\/sedov_${n_part}/" sedov_$n_part.yml
done


