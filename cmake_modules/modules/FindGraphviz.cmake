# * Try to find Graphviz cgraph library Once done this will define
#
# Graphviz_FOUND - system has Graphviz installed Graphviz_INCLUDE_DIR
# Graphviz_GVC_LIBRARY Graphviz_CGRAPH_LIBRARY Graphviz_CDT_LIBRARY
#

if(Graphviz_CGRAPH_LIBRARY)
  # in cache already
  set(Graphviz_FIND_QUIETLY TRUE)
endif(Graphviz_CGRAPH_LIBRARY)

# use pkg-config to get the directories and then use these values in the
# FIND_PATH() and FIND_LIBRARY() calls
if(NOT WIN32)
  find_package(PkgConfig)

  pkg_check_modules(Graphviz_GVC_PKG libgvc)
  pkg_check_modules(Graphviz_CGRAPH_PKG libcgraph)
  pkg_check_modules(Graphviz_CDT_PKG libcdt)

  set(Graphviz_INCLUDE_DIR ${Graphviz_CGRAPH_PKG_INCLUDE_DIRS})

endif(NOT WIN32)

find_library(
  Graphviz_GVC_LIBRARY
  NAMES gvc
  HINTS ${Graphviz_GVC_PKG_LIBRARY_DIRS} # Generated by pkg-config
)
if(NOT (Graphviz_GVC_LIBRARY))
  message(STATUS "Could not find libgvc.")
  set(Graphviz_GVC_FOUND FALSE)
else()
  set(Graphviz_GVC_FOUND TRUE)
endif()

find_library(
  Graphviz_CGRAPH_LIBRARY
  NAMES cgraph
  HINTS ${Graphviz_CGRAPH_PKG_LIBRARY_DIRS} # Generated by pkg-config
)
if(NOT (Graphviz_CGRAPH_LIBRARY))
  message(STATUS "Could not find libcgraph.")
  set(Graphviz_CGRAPH_FOUND FALSE)
else()
  set(Graphviz_CGRAPH_FOUND TRUE)
endif()

find_library(
  Graphviz_CDT_LIBRARY
  NAMES cdt
  HINTS ${Graphviz_CDT_PKG_LIBRARY_DIRS} # Generated by pkg-config
)
if(NOT (Graphviz_CDT_LIBRARY))
  message(STATUS "Could not find libcdt.")
  set(Graphviz_CDT_FOUND FALSE)
else()
  set(Graphviz_CDT_FOUND TRUE)
endif()

find_path(
  Graphviz_INCLUDE_DIR
  NAMES cgraph.h
  PATH_SUFFIXES graphviz
  HINTS ${Graphviz_CGRAPH_PKG_INCLUDE_DIRS} # Generated by pkg-config
)
if(NOT (Graphviz_INCLUDE_DIR))
  message(STATUS "Could not find graphviz headers.")
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  Graphviz DEFAULT_MSG Graphviz_GVC_LIBRARY Graphviz_CGRAPH_LIBRARY
  Graphviz_CDT_LIBRARY Graphviz_INCLUDE_DIR)
set(Graphviz_LIBRARIES ${Graphviz_GVC_LIBRARY} ${Graphviz_CGRAPH_LIBRARY}
                       ${Graphviz_CDT_LIBRARY})

# show the POPPLER_(XPDF/QT4)_INCLUDE_DIR and POPPLER_LIBRARIES variables only
# in the advanced view
mark_as_advanced(Graphviz_INCLUDE_DIR Graphviz_LIBRARIES)
