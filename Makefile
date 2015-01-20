
# Assumes NUPIC_CORE is set to point to the root of the nupic.core repo.
NUPIC_CORE_EXTERNAL = $(NUPIC_CORE)/external

##########################################
# Include paths
#
# Three include paths: nupic core, platform specific external libraries,
# platform independent external libraries
#
NUPIC_CORE_INC = $(NUPIC_CORE)/build/release/include
NUPIC_EXTERNAL_INC = $(NUPIC_CORE_EXTERNAL)/common/include
NUPIC_EXTERNAL_PLATFORM_INC = $(NUPIC_CORE_EXTERNAL)/darwin64/include

##########################################
#
# Library paths
#
NUPIC_CORE_LIB = $(NUPIC_CORE)/external/darwin64/lib

##########################################
#
# All compiler flags
#
#
# Note: compilation flags for your system may be different. To get the
# compilation flags for your system, look in:
# $nupic.core/build/scripts/CMakeFiles/testcpphtm.dir/flags.make
# and:
# $nupic.core/build/scripts/CMakeFiles/testcpphtm.dir/link.txt
#

CXX_FLAGS = -DBOOST_NO_WREGEX -DHAVE_CONFIG_H -DNTA_ASM -DNTA_ASSERTIONS_ON \
	-DNTA_INTERNAL -DNTA_PLATFORM_darwin64 -DNUPIC2 \
	-isystem $(NUPIC_EXTERNAL_PLATFORM_INC) -isystem $(NUPIC_EXTERNAL_INC) \
	-isystem $(NUPIC_CORE)/src -I$(NUPIC_CORE_INC) -fPIC -std=c++11 -m64 \
	-stdlib=libc++ -fvisibility=hidden -Wall -Wreturn-type -Wunused \
	-Wno-unused-parameter -O3

sdr: test.cpp
	capnp compile -oc++ --src-prefix=example example/proto.capnp
	clang++ -c proto.capnp.c++ $(CXX_FLAGS)
	clang++ -c test.cpp $(CXX_FLAGS)
	clang++ -Wl,-search_paths_first \
		-Wl,-headerpad_max_install_names -Wl,-u,_munmap -m64 \
		-stdlib=libc++ \
		-lc++abi -liconv -lsqlite3 -framework CoreServices -framework Accelerate \
		-L$(NUPIC_CORE_EXTERNAL)/darwin64/lib proto.capnp.o test.o -o test \
		$(NUPIC_CORE)/build/release/lib/libnupic_core.a \
		$(NUPIC_CORE_EXTERNAL)/darwin64/lib/libyaml.a \
		$(NUPIC_CORE_EXTERNAL)/darwin64/lib/libapr-1.a \
		$(NUPIC_CORE_EXTERNAL)/darwin64/lib/libaprutil-1.a \
		$(NUPIC_CORE_EXTERNAL)/darwin64/lib/libz.a
