#!/bin/bash

config_file="$1"   # path to config file

# get the input_dir from the config file trim whitespace after the word. Remove "" from the input_dir
input_dir=$(grep -m 1 "input_dir" "$config_file" | awk '{print $2}' | tr -d '"')
printf "input_dir: %s\n" "$input_dir"

# get the output_prefix from the config file trim whitespace after the word. Remove "" from the output_prefix
output_prefix=$(grep -m 1 "output_prefix" "$config_file" | awk '{print $2}' | tr -d '"')
printf "output_prefix: %s\n" "$output_prefix"

threads=$(grep -m 1 "threads" "$config_file" | awk '{print $2}' | tr -d '"')
## check the system cores
if [ -z "$threads" ]; then
  cores=$(nproc)
else
  cores="$threads"
fi
printf "cores: %s\n" "$cores"

## get cwd
cwd=$(pwd)

config_file="${cwd}/${config_file}"
output_dir="${cwd}/${output_prefix}"

docker run --rm \
  -v "${input_dir}":/pipeline/data \
  -v "${config_file}":/pipeline/config.yaml \
  -v "${output_dir}":/pipeline/"${output_prefix}" \
  -w /pipeline \
  ghcr.io/aimann/snax \
  --cores "${cores}" \
  "$@"
