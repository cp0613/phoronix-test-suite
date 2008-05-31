#!/bin/sh

THIS_DIR=$(pwd)
mkdir -p $THIS_DIR/hmmer_

tar -xvf hmmer-2.3.2.tar.gz
cd hmmer-2.3.2/
./configure --enable-threads --prefix=$THIS_DIR/hmmer_
make -j $NUM_CPU_JOBS
make install
cd ..
cp -r hmmer-2.3.2/tutorial hmmer_
rm -rf hmmer-2.3.2/
gunzip Pfam_ls.gz -c > hmmer_/tutorial/Pfam_ls

cat>hmmpfam<<EOT
#!/bin/sh
cd hmmer_/tutorial
../bin/hmmpfam -E 0.1 Pfam_ls 7LES_DROME > /dev/null
cd ../..
EOT
chmod +x hmmpfam

cat>hmmer<<EOT
#!/bin/sh
/usr/bin/time -f "Pfam search time: %e seconds" ./hmmpfam 2>&1 | grep seconds
EOT
chmod +x hmmer

