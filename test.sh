#!/bin/bash

charts=$(find deploy-multi -type f -path "*/apps/*/Chart.yaml")
results=()

for chart in $charts; do
	env=$(basename $(dirname $chart))
	name=$(yq e '.name' "$chart")
	ext_name="$env-$name"

	if [[ " ${results[@]} " =~ " $ext_name " ]]; then
		echo "$ext_name duplicated"
		exit 1
	else
		results+=("$ext_name")
	fi
done
