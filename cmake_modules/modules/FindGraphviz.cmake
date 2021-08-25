# - Try to find Graphviz cgraph library
# Once done this will define
#
#  Graphviz_FOUND - system has Graphviz installed
#  Graphviz_INCLUDE_DIR
#  Graphviz_GVC_LIBRARY
#  Graphviz_CGRAPH_LIBRARY
#  Graphviz_CDT_LIBRARY
#
#

if ( Graphviz_CGRAPH_LIBRARY )
   # in cache already
   SET(Graphviz_FIND_QUIETLY TRUE)
endif ( Graphviz_CGRAPH_LIBRARY )

# use pkg-config to get the directories and then use these values
# in the FIND_PATH() and FIND_LIBRARY() calls
if( NOT WIN32 )
  find_package(PkgConfig)

  pkg_check_modules(Graphviz_GVC_PKG libgvc)
  pkg_check_modules(Graphviz_CGRAPH_PKG libcgraph)
  pkg_check_modules(Graphviz_CDT_PKG libcdt)

  SET(Graphviz_INCLUDE_DIR ${Graphviz_CGRAPH_PKG_INCLUDE_DIRS})

endif( NOT WIN32 )

FIND_LIBRARY(Graphviz_GVC_LIBRARY NAMES gvc
  HINTS ${Graphviz_GVC_PKG_LIBRARY_DIRS} # Generated by pkg-config
)
IF ( NOT(Graphviz_GVC_LIBRARY) )
  MESSAGE(STATUS "Could not find libgvc." )
  SET(Graphviz_GVC_FOUND FALSE)
ELSE ()
  SET(Graphviz_GVC_FOUND TRUE)
ENDIF ()

FIND_LIBRARY(Graphviz_CGRAPH_LIBRARY NAMES cgraph
  HINTS ${Graphviz_CGRAPH_PKG_LIBRARY_DIRS} # Generated by pkg-config
)
IF ( NOT(Graphviz_CGRAPH_LIBRARY) )
  MESSAGE(STATUS "Could not find libcgraph." )
  SET(Graphviz_CGRAPH_FOUND FALSE)
ELSE ()
  SET(Graphviz_CGRAPH_FOUND TRUE)
ENDIF ()

FIND_LIBRARY(Graphviz_CDT_LIBRARY NAMES cdt
  HINTS ${Graphviz_CDT_PKG_LIBRARY_DIRS} # Generated by pkg-config
)
IF ( NOT(Graphviz_CDT_LIBRARY) )
  MESSAGE(STATUS "Could not find libcdt." )
  SET(Graphviz_CDT_FOUND FALSE)
ELSE ()
  SET(Graphviz_CDT_FOUND TRUE)
ENDIF ()

FIND_PATH(Graphviz_INCLUDE_DIR NAMES cgraph.h
  PATH_SUFFIXES graphviz
  HINTS ${Graphviz_CGRAPH_PKG_INCLUDE_DIRS} # Generated by pkg-config
)
IF ( NOT(Graphviz_INCLUDE_DIR) )
  MESSAGE(STATUS "Could not find graphviz headers." )
ENDIF ()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Graphviz DEFAULT_MSG
  Graphviz_GVC_LIBRARY
  Graphviz_CGRAPH_LIBRARY
  Graphviz_CDT_LIBRARY
  Graphviz_INCLUDE_DIR
  )
SET(Graphviz_LIBRARIES ${Graphviz_GVC_LIBRARY} ${Graphviz_CGRAPH_LIBRARY} ${Graphviz_CDT_LIBRARY})


# show the POPPLER_(XPDF/QT4)_INCLUDE_DIR and POPPLER_LIBRARIES variables only in the advanced view
MARK_AS_ADVANCED(Graphviz_INCLUDE_DIR Graphviz_LIBRARIES)
