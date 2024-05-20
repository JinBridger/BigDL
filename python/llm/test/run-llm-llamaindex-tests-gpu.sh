#!/bin/bash

export ANALYTICS_ZOO_ROOT=${ANALYTICS_ZOO_ROOT}
export LLM_HOME=${ANALYTICS_ZOO_ROOT}/python/llm/src
export LLM_INFERENCE_TEST_DIR=${ANALYTICS_ZOO_ROOT}/python/llm/test/llamaindex_gpu

if [[ $RUNNER_OS == "Linux" ]]; then
  export USE_XETLA=OFF
  export SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS=1
elif [[ $RUNNER_OS == "Windows" ]]; then
  export SYCL_CACHE_PERSISTENT=1
fi

set -e

echo "# Start testing inference"
start=$(date "+%s")

python -m pytest -s ${LLM_INFERENCE_TEST_DIR}

now=$(date "+%s")
time=$((now-start))

echo "Bigdl-llm llamaindex gpu tests finished"
echo "Time used:$time seconds"