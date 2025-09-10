CFLAGS=$(echo "${CFLAGS}" | sed "s/-march=[a-zA-Z0-9]*//g")
CFLAGS=$(echo "${CFLAGS}" | sed "s/-mtune=[a-zA-Z0-9]*//g")
CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-march=[a-zA-Z0-9]*//g")
CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-mtune=[a-zA-Z0-9]*//g")
unset PYTHON

cmake -B build -S . \
      ${CMAKE_ARGS} -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DENABLE_HWLOC=ON \
      -DBLIS_THREAD_MODEL=openmp \
      -DENABLE_THREAD_MODEL=openmp \
      -DBLIS_CONFIG_FAMILY=x86_64 \
      -DENABLE_STATIC=OFF
cmake --build build -j${CPU_COUNT}
cmake --install build

