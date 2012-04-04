cmake_minimum_required(VERSION 2.8)
project( PYOPENMS )

find_package(PythonInterp REQUIRED)

find_program( CYTHON_EXECUTABLE NAMES cython )

include( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( Cython REQUIRED_VARS CYTHON_EXECUTABLE )

mark_as_advanced( CYTHON_EXECUTABLE )

# copy files

FILE(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/pyOpenMS)
FILE(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/pyOpenMS/cython_code)
FILE(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/pyOpenMS/cython_code/pxd)

FILE(GLOB _python_files "pyOpenMS/*.py")
FILE(COPY ${_python_files} DESTINATION ${CMAKE_BINARY_DIR}/pyOpenMS)

FILE(GLOB _python_files "pyOpenMS/cython_code/*.py")
FILE(COPY ${_python_files} DESTINATION ${CMAKE_BINARY_DIR}/pyOpenMS/cython_code)

FILE(GLOB _python_files "pyOpenMS/cython_code/*.pyx")
FILE(COPY ${_python_files} DESTINATION ${CMAKE_BINARY_DIR}/pyOpenMS/cython_code)

FILE(GLOB _python_files "pyOpenMS/cython_code/pxd/*.p*")
FILE(COPY ${_python_files} DESTINATION ${CMAKE_BINARY_DIR}/pyOpenMS/cython_code/pxd)

FILE(GLOB _python_files "pyOpenMS/*.dll")
FILE(COPY ${_python_files} DESTINATION ${CMAKE_BINARY_DIR}/pyOpenMS)

FILE(COPY setup.py DESTINATION ${CMAKE_BINARY_DIR})

# generate cython wrapper

EXECUTE_PROCESS(COMMAND ${PYTHON_EXECUTABLE} build_cython_file.py 
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/pyOpenMS/cython_code
  ERROR_VARIABLE PYOK)

MESSAGE("PYOK " ${PYOK})

# run cython to generate c++ file
 
EXECUTE_PROCESS(COMMAND ${CYTHON_EXECUTABLE} -X boundscheck=False -X wraparound=False --cplus -o ../pyOpenMS.cpp pyOpenMS.pyx
WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/pyOpenMS/cython_code
ERROR_VARIABLE CYOK)
MESSAGE("CYOK " ${CYOK})

add_custom_target(pyopenms COMMAND ${PYTHON_EXECUTABLE} setup.py build_ext --inplace)
