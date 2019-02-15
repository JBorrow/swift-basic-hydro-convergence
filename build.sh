source shared.sh

extra_flags="--disable-mpi --with-hydro-dimension=1"

cd swiftsim-master

./autogen.sh

mkdir build

cd build

echo "Generating builds"

for scheme in "${sph[@]}"
do
	echo "Generating build for ${scheme}"
	mkdir $scheme
	cd $scheme

	../../configure --with-hydro=$scheme $extra_flags 2>&1 > configure_output.log

	cd ..
done

for scheme in "${gizmo[@]}"
do
	echo "Generating build for ${scheme}"
	mkdir $scheme
	cd $scheme

	../../configure --with-hydro=$scheme $extra_flags --with-riemann-solver=hllc 2>&1 > configure_output.log

	cd ..
done

echo "Making builds"

for scheme in "${sph[@]}"
do
	echo "Making ${scheme}"

	cd $scheme
	make -j 2>&1 > make_output.log
	cd ..
done

for scheme in "${gizmo[@]}"
do
	echo "Making ${scheme}"

	cd $scheme
	make -j 2>&1 > make_output.log
	cd ..
done
