#!/bin/sh
tar -xf rocksdb-9.0.0.tar.gz
cd rocksdb-9.0.0
mkdir build
cd build
export CFLAGS="-O3 -Wno-error=maybe-uninitialized -Wno-error=uninitialized -Wno-error=deprecated-copy -Wno-error=pessimizing-move $CFLAGS"
export CXXFLAGS="-O3 -Wno-error=maybe-uninitialized -Wno-error=uninitialized -Wno-error=deprecated-copy -Wno-error=pessimizing-move $CXXFLAGS"
cmake -DCMAKE_BUILD_TYPE=Release -DWITH_SNAPPY=ON  ..
make -j $NUM_CPU_CORES
make db_bench
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/bash
rm -rf /tmp/rocksdbtest-1000/dbbench/
cd rocksdb-9.0.0/build/
./db_bench \$@ --threads \$NUM_CPU_CORES --duration 60 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
rm -rf /tmp/rocksdbtest-1000/dbbench/" > rocksdb
chmod +x rocksdb
