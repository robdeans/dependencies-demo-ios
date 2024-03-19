#!/bin/sh
unset SDKROOT
script_dir="${0%/*}"
mkdir -p "${PROJECT_DIR}/DependenciesDemo/Code/Generated/Sourcery"
"$script_dir"/sourcery/bin/sourcery --config "$script_dir"/Configs/sourcery_DependenciesDemo.yml
mkdir -p "${PROJECT_DIR}/Packages/DependenciesDemoAPIKit/Services/Generated/Sourcery"
"$script_dir"/sourcery/bin/sourcery --config "$script_dir"/Configs/sourcery_DependenciesDemoAPIKit.yml
mkdir -p "${PROJECT_DIR}/Packages/DependenciesDemoHelpers/Sources/Generated/Sourcery"
"$script_dir"/sourcery/bin/sourcery --config "$script_dir"/Configs/sourcery_DependenciesDemoHelpers.yml
