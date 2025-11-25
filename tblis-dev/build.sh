CFLAGS=$(echo "${CFLAGS}" | sed "s/-march=[a-zA-Z0-9]*//g")
CFLAGS=$(echo "${CFLAGS}" | sed "s/-mtune=[a-zA-Z0-9]*//g")
CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-march=[a-zA-Z0-9]*//g")
CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-mtune=[a-zA-Z0-9]*//g")
unset PYTHON

echo "Building for TBLIS_ARCH=${TBLIS_ARCH}"

cmake -B build -S . \
      ${CMAKE_ARGS} -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DENABLE_HWLOC=ON \
      -DBLIS_THREAD_MODEL=openmp \
      -DENABLE_THREAD_MODEL=openmp \
      -DBLIS_CONFIG_FAMILY=${TBLIS_ARCH} \
      -DENABLE_STATIC=OFF
cmake --build build -j${CPU_COUNT}
cmake --install build

sed -i "s:${BUILD_PREFIX}/x86_64-conda-linux-gnu/sysroot/usr/lib/libm.so;::g" ${PREFIX}/lib/cmake/TCI/TCITargets.cmake
