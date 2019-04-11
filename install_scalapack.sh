module load daint-mc
module swap PrgEnv-cray PrgEnv-gnu
module unload cray-libsci
module load CMake
module load intel
module load hwloc

export CC=`which cc`
export CXX=`which CC`
export CRAYPE_LINK_TYPE=dynamic

cd build

FC=ftn cmake -DHWLOC_ROOT=$EBROOTHWLOC -DDLA_LAPACK_TYPE="MKL" -DDLA_SCALAPACK_TYPE="MKL" -DMKL_THREADING="GNU OpenMP" ..
make -j 10

#OMP_NUM_THREADS=18 MKL_NUM_THREADS=18 srun -N 2 --ntasks-per-node=2 --cpu-bind=verbose,sockets -p -y ./miniapp/matrix_multiplication -m 10000 -n 10000 -k 10000 --scalapack -r 3 -p 2 -q 2
# flags -p and -y are the flags of mpiP library for profiling

