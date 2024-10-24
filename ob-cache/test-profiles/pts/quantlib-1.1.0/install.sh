#!/bin/sh
tar -xf QuantLib-1.30.tar.gz
cd QuantLib-1.30/build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-O3" -DCMAKE_C_FLAGS="-O3"
if [ $OS_TYPE = "BSD" ]
then
	gmake -j $NUM_CPU_CORES
	echo $? > ~/install-exit-status
else
	make -j $NUM_CPU_CORES
	echo $? > ~/install-exit-status
fi
cd ~
echo "#!/bin/bash
cd QuantLib-1.30/build
./test-suite/quantlib-benchmark > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > quantlib
chmod +x quantlib
