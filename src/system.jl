# System module.
module System

using RCall
using Conda

import PyCall: pyimport, pycall

export LIB_SKL_AVAILABLE,
       LIB_CRT_AVAILABLE

function check_py_dep(package::AbstractString)
  is_available = true
  try
    pyimport(package)
  catch
    try 
      Conda.add(package)
    catch
      is_available = false
    end
  end
  return is_available
end

function check_r_dep()
  is_available = true
  try
    R"library(caret)"
  catch
    try
      R"install.packages('caret',repos='https://cloud.r-project.org')"
      R"install.packages('earth',repos='https://cloud.r-project.org')"
      R"install.packages('mda',repos='https://cloud.r-project.org')"
      R"install.packages('e1071',repos='https://cloud.r-project.org')"
      R"install.packages('gam',repos='https://cloud.r-project.org')"
      R"install.packages('randomForest',repos='https://cloud.r-project.org')"
      R"install.packages('nnet',repos='https://cloud.r-project.org')"
      R"install.packages('kernlab',repos='https://cloud.r-project.org')"
      R"install.packages('grid',repos='https://cloud.r-project.org')"
      R"install.packages('MASS',repos='https://cloud.r-project.org')"
      R"install.packages('pls',repos='https://cloud.r-project.org')"
      R"install.packages('xgboost',repos='https://cloud.r-project.org')"
    catch
      is_available = false
    end
  end
  return is_available
end

# Check system for python dependencies.
LIB_SKL_AVAILABLE = check_py_dep("scikit-learn")
LIB_CRT_AVAILABLE = check_r_dep()
end # module