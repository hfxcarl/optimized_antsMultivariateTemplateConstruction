#!/bin/bash
# ARG_HELP([DBM post-processing for modelbuild.sh from optimized_antsMultivariateTemplateConstruction])
# ARG_OPTIONAL_SINGLE([output-dir],[],[Output directory for modelbuild],[output])
# ARG_OPTIONAL_BOOLEAN([float],[],[Use float instead of double for calculations (reduce memory requirements, reduce precision)],[])
# ARG_OPTIONAL_SINGLE([mask],[],[Mask file for average to improve delin estimates],[])
# ARG_OPTIONAL_SINGLE([delin-affine-ratio],[],[Ratio of voxels within mask used to estimate delin affine],[0.25])
# ARG_OPTIONAL_BOOLEAN([use-geometric],[],[Use geometric estimate of Jacobian instead of finite-difference],[on])
# ARG_OPTIONAL_SINGLE([jacobian-smooth],[],[Comma separated list of smoothing gaussian FWHM, append "vox" for voxels, "mm" for millimeters],[4vox])
# ARG_OPTIONAL_SINGLE([walltime],[],[Walltime for short running stages (averaging, resampling)],[00:15:00])
# ARG_OPTIONAL_BOOLEAN([block],[],[For qbatch SGE, PBS and SLURM, blocks execution until jobs are finished.],[])
# ARG_OPTIONAL_BOOLEAN([debug],[],[Debug mode, print all commands to stdout],[])
# ARG_OPTIONAL_BOOLEAN([dry-run],[],[Dry run, don't run any commands, implies debug],[])
# ARG_OPTIONAL_SINGLE([jobname-prefix],[],[Prefix to add to front of job names, used by twolevel wrapper],[])
# ARG_POSITIONAL_INF([inputs],[Input text files, one line per input, one file per spectra],[1])
# ARGBASH_SET_INDENT([  ])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.10.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
  local _ret="${2:-1}"
  test "${_PRINT_HELP:-no}" = yes && print_help >&2
  echo "$1" >&2
  exit "${_ret}"
}


begins_with_short_option()
{
  local first_option all_short_options='h'
  first_option="${1:0:1}"
  test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
_arg_inputs=('' )
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_output_dir="output"
_arg_float="off"
_arg_mask=
_arg_delin_affine_ratio="0.25"
_arg_use_geometric="on"
_arg_jacobian_smooth="4vox"
_arg_walltime="00:15:00"
_arg_block="off"
_arg_debug="off"
_arg_dry_run="off"
_arg_jobname_prefix=


print_help()
{
  printf '%s\n' "DBM post-processing for modelbuild.sh from optimized_antsMultivariateTemplateConstruction"
  printf 'Usage: %s [-h|--help] [--output-dir <arg>] [--(no-)float] [--mask <arg>] [--delin-affine-ratio <arg>] [--(no-)use-geometric] [--jacobian-smooth <arg>] [--walltime <arg>] [--(no-)block] [--(no-)debug] [--(no-)dry-run] [--jobname-prefix <arg>] <inputs-1> [<inputs-2>] ... [<inputs-n>] ...\n' "$0"
  printf '\t%s\n' "<inputs>: Input text files, one line per input, one file per spectra"
  printf '\t%s\n' "-h, --help: Prints help"
  printf '\t%s\n' "--output-dir: Output directory for modelbuild (default: 'output')"
  printf '\t%s\n' "--float, --no-float: Use float instead of double for calculations (reduce memory requirements, reduce precision) (off by default)"
  printf '\t%s\n' "--mask: Mask file for average to improve delin estimates (no default)"
  printf '\t%s\n' "--delin-affine-ratio: Ratio of voxels within mask used to estimate delin affine (default: '0.25')"
  printf '\t%s\n' "--use-geometric, --no-use-geometric: Use geometric estimate of Jacobian instead of finite-difference (on by default)"
  printf '\t%s\n' "--jacobian-smooth: Comma separated list of smoothing gaussian FWHM, append \"vox\" for voxels, \"mm\" for millimeters (default: '4vox')"
  printf '\t%s\n' "--walltime: Walltime for short running stages (averaging, resampling) (default: '00:15:00')"
  printf '\t%s\n' "--block, --no-block: For qbatch SGE, PBS and SLURM, blocks execution until jobs are finished. (off by default)"
  printf '\t%s\n' "--debug, --no-debug: Debug mode, print all commands to stdout (off by default)"
  printf '\t%s\n' "--dry-run, --no-dry-run: Dry run, don't run any commands, implies debug (off by default)"
  printf '\t%s\n' "--jobname-prefix: Prefix to add to front of job names, used by twolevel wrapper (no default)"
}


parse_commandline()
{
  _positionals_count=0
  while test $# -gt 0
  do
    _key="$1"
    case "$_key" in
      -h|--help)
        print_help
        exit 0
        ;;
      -h*)
        print_help
        exit 0
        ;;
      --output-dir)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_output_dir="$2"
        shift
        ;;
      --output-dir=*)
        _arg_output_dir="${_key##--output-dir=}"
        ;;
      --no-float|--float)
        _arg_float="on"
        test "${1:0:5}" = "--no-" && _arg_float="off"
        ;;
      --mask)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_mask="$2"
        shift
        ;;
      --mask=*)
        _arg_mask="${_key##--mask=}"
        ;;
      --delin-affine-ratio)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_delin_affine_ratio="$2"
        shift
        ;;
      --delin-affine-ratio=*)
        _arg_delin_affine_ratio="${_key##--delin-affine-ratio=}"
        ;;
      --no-use-geometric|--use-geometric)
        _arg_use_geometric="on"
        test "${1:0:5}" = "--no-" && _arg_use_geometric="off"
        ;;
      --jacobian-smooth)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_jacobian_smooth="$2"
        shift
        ;;
      --jacobian-smooth=*)
        _arg_jacobian_smooth="${_key##--jacobian-smooth=}"
        ;;
      --walltime)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_walltime="$2"
        shift
        ;;
      --walltime=*)
        _arg_walltime="${_key##--walltime=}"
        ;;
      --no-block|--block)
        _arg_block="on"
        test "${1:0:5}" = "--no-" && _arg_block="off"
        ;;
      --no-debug|--debug)
        _arg_debug="on"
        test "${1:0:5}" = "--no-" && _arg_debug="off"
        ;;
      --no-dry-run|--dry-run)
        _arg_dry_run="on"
        test "${1:0:5}" = "--no-" && _arg_dry_run="off"
        ;;
      --jobname-prefix)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_jobname_prefix="$2"
        shift
        ;;
      --jobname-prefix=*)
        _arg_jobname_prefix="${_key##--jobname-prefix=}"
        ;;
      *)
        _last_positional="$1"
        _positionals+=("$_last_positional")
        _positionals_count=$((_positionals_count + 1))
        ;;
    esac
    shift
  done
}


handle_passed_args_count()
{
  local _required_args_string="'inputs'"
  test "${_positionals_count}" -ge 1 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require at least 1 (namely: $_required_args_string), but got only ${_positionals_count}." 1
}


assign_positional_args()
{
  local _positional_name _shift_for=$1
  _positional_names="_arg_inputs "
  _our_args=$((${#_positionals[@]} - 1))
  for ((ii = 0; ii < _our_args; ii++))
  do
    _positional_names="$_positional_names _arg_inputs[$((ii + 1))]"
  done

  shift "$_shift_for"
  for _positional_name in ${_positional_names}
  do
    test $# -gt 0 || break
    eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
    shift
  done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash

set -euo pipefail
export QBATCH_SCRIPT_FOLDER="${_arg_output_dir}/qbatch/"

# Load up helper scripts and define helper variables
# shellcheck source=helpers.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/helpers.sh"

# Setup a timestamp for prefixing all commands
_datetime=$(date -u +%F_%H-%M-%S-UTC)

# Setup a directory which contains all commands run
# for this invocation
mkdir -p ${_arg_output_dir}/jobs/${_datetime}

# Store the full command line for each run
echo ${__invocation} >${_arg_output_dir}/jobs/${_datetime}/invocation

info "Checking input files"

# Load input file into array
if [[ ! -s ${_arg_inputs[0]} ]]; then
  failure "Input file ${_arg_inputs[0]} is non-existent or zero size"
else
  mapfile -t _arg_inputs <${_arg_inputs[0]}
fi

for file in "${_arg_inputs[@]}"; do
  if [[ ! -s ${file} ]]; then
    failure "Input file ${file} is non-existent or zero size"
  fi
done

# Enable float mode for ants commands
if [[ ${_arg_float} == "on" ]]; then
  _arg_float="--float"
else
  _arg_float=""
fi

# Enable block for qbatch job submission
if [[ ${_arg_block} == "on" ]]; then
  _arg_block="--block"
else
  _arg_block=""
fi

# Convert smoothing jacobians to a list
IFS=',' read -r -a _arg_jacobian_smooth <<<${_arg_jacobian_smooth}

# Prefight check for required programs
for program in qbatch ImageMath \
  ThresholdImage ExtractRegionFromImageByMask \
  antsApplyTransforms; do

  if ! command -v ${program} &>/dev/null; then
    failure "Required program ${program} not found!"
  fi

done

# Make output directories
mkdir -p ${_arg_output_dir}/dbm/intermediate/delin/{affine,warp,jacobian}
mkdir -p ${_arg_output_dir}/dbm/intermediate/nlin/jacobian
mkdir -p ${_arg_output_dir}/dbm/intermediate/affine/{warp,jacobian}
mkdir -p ${_arg_output_dir}/dbm/jacobian/{relative,full}/smooth

# Convert geometric option to ANTs option
if [[ ${_arg_use_geometric} == "on" ]]; then
  _arg_use_geometric=1
else
  _arg_use_geometric=0
fi

_arg_log_jacobian=1

# Generate jacobian from nlin field
# Log, values > 0, voxel expands towards subject (i.e. subject voxel is larger)
# Log, values < 0, voxel contracts towards subject (i.e. subject voxel is smaller)
info "Computing Jacobians from non-linear warp fields"
for file in "${_arg_inputs[@]}"; do
  if [[ ! -s ${_arg_output_dir}/final/transforms/$(basename ${file} | extension_strip)_1Warp.nii.gz ]]; then
    failure "Expected deformation file ${_arg_output_dir}/final/transforms/$(basename ${file} | extension_strip)_1Warp.nii.gz does not exist"
  fi
  if [[ ! -s ${_arg_output_dir}/dbm/intermediate/nlin/jacobian/$(basename ${file} | extension_strip).nii.gz ]]; then
    echo "CreateJacobianDeterminantImage 3 ${_arg_output_dir}/final/transforms/$(basename ${file} | extension_strip)_1Warp.nii.gz \
      ${_arg_output_dir}/dbm/intermediate/nlin/jacobian/$(basename ${file} | extension_strip).nii.gz ${_arg_log_jacobian} ${_arg_use_geometric}"
  fi
done >${_arg_output_dir}/jobs/${_datetime}/nlin_jacobian

debug "$(cat ${_arg_output_dir}/jobs/${_datetime}/nlin_jacobian)"
if [[ ${_arg_dry_run} == "off" ]]; then
  qbatch ${_arg_block} --logdir ${_arg_output_dir}/logs/${_datetime} \
    --walltime ${_arg_walltime} \
    -N ${_arg_jobname_prefix}dbm_${_datetime}_nlin_jacobian \
    ${_arg_output_dir}/jobs/${_datetime}/nlin_jacobian
fi

# Generate warp field from affine transform
info "Computing warp fields from affine transforms"
for file in "${_arg_inputs[@]}"; do
  if [[ ! -s ${_arg_output_dir}/dbm/intermediate/affine/warp/$(basename ${file} | extension_strip).nii.gz ]]; then
    echo "antsApplyTransforms -d 3 --verbose ${_arg_float} \
      -r ${_arg_output_dir}/final/average/template_sharpen_shapeupdate.nii.gz \
      -t ${_arg_output_dir}/final/transforms/$(basename ${file} | extension_strip)_0GenericAffine.mat \
      -o [ ${_arg_output_dir}/dbm/intermediate/affine/warp/$(basename ${file} | extension_strip).nii.gz,1 ]"
  fi
done >${_arg_output_dir}/jobs/${_datetime}/affine_warp

debug "$(cat ${_arg_output_dir}/jobs/${_datetime}/affine_warp)"
if [[ ${_arg_dry_run} == "off" ]]; then
  qbatch ${_arg_block} --logdir ${_arg_output_dir}/logs/${_datetime} \
    --walltime ${_arg_walltime} \
    -N ${_arg_jobname_prefix}dbm_${_datetime}_affine_warp \
    ${_arg_output_dir}/jobs/${_datetime}/affine_warp
fi

# Generate jacobian from affine warp field
# Log, values > 0, voxel expands towards subject (i.e. subject voxel is larger)
# Log, values < 0, voxel contracts towards subject (i.e. subject voxel is smaller)
info "Computing Jacobians from affine warp fields"
for file in "${_arg_inputs[@]}"; do
  if [[ ! -s ${_arg_output_dir}/dbm/intermediate/affine/jacobian/$(basename ${file} | extension_strip).nii.gz ]]; then
    echo "CreateJacobianDeterminantImage 3 ${_arg_output_dir}/dbm/intermediate/affine/warp/$(basename ${file} | extension_strip).nii.gz \
      ${_arg_output_dir}/dbm/intermediate/affine/jacobian/$(basename ${file} | extension_strip).nii.gz ${_arg_log_jacobian} ${_arg_use_geometric}"
  fi
done >${_arg_output_dir}/jobs/${_datetime}/affine_jacobian

debug "$(cat ${_arg_output_dir}/jobs/${_datetime}/affine_jacobian)"
if [[ ${_arg_dry_run} == "off" ]]; then
  qbatch ${_arg_block} --logdir ${_arg_output_dir}/logs/${_datetime} \
    --walltime ${_arg_walltime} \
    -N ${_arg_jobname_prefix}dbm_${_datetime}_affine_jacobian \
    --depend ${_arg_jobname_prefix}dbm_${_datetime}_affine_warp \
    ${_arg_output_dir}/jobs/${_datetime}/affine_jacobian
fi

# Check for mask to use for delin
if [[ -s ${_arg_mask} ]]; then
  info "Using supplied file ${_arg_mask} for delin calculation"
elif [[ -s ${_arg_output_dir}/final/average/mask_shapeupdate.nii.gz ]]; then
  info "Using modelbuild mask ${_arg_output_dir}/final/average/mask_shapeupdate.nii.gz for delin calculation"
  _arg_mask=${_arg_output_dir}/final/average/mask_shapeupdate.nii.gz
else
  if [[ ! -s ${_arg_output_dir}/dbm/intermediate/mask.nii.gz ]]; then
    info "No average mask available (provide via --mask), estimating mask using thresholding for delin calculation"
    # Otsu threshold, erode, get largest component, dilate
    echo "ThresholdImage 3 ${_arg_output_dir}/final/average/template_sharpen_shapeupdate.nii.gz \
      ${_arg_output_dir}/dbm/intermediate/mask.nii.gz Otsu 1 && \
      iMath 3 ${_arg_output_dir}/dbm/intermediate/mask.nii.gz ME ${_arg_output_dir}/dbm/intermediate/mask.nii.gz 1 1 ball 1 && \
      ImageMath 3 ${_arg_output_dir}/dbm/intermediate/mask.nii.gz GetLargestComponent ${_arg_output_dir}/dbm/intermediate/mask.nii.gz && \
      iMath 3 ${_arg_output_dir}/dbm/intermediate/mask.nii.gz MD ${_arg_output_dir}/dbm/intermediate/mask.nii.gz 1 1 ball 1"
    _arg_mask=${_arg_output_dir}/dbm/intermediate/mask.nii.gz
  fi
fi >${_arg_output_dir}/jobs/${_datetime}/delin_mask

debug "$(cat ${_arg_output_dir}/jobs/${_datetime}/delin_mask)"
if [[ ${_arg_dry_run} == "off" && -s ${_arg_output_dir}/jobs/${_datetime}/delin_mask ]]; then
  qbatch ${_arg_block} --logdir ${_arg_output_dir}/logs/${_datetime} \
    --walltime ${_arg_walltime} \
    -N ${_arg_jobname_prefix}dbm_${_datetime}_delin_mask \
    -- bash ${_arg_output_dir}/jobs/${_datetime}/delin_mask
fi

# Generate delin affine from warp field
info "Estimate delin affine from nlin warp fields"
for file in "${_arg_inputs[@]}"; do
  if [[ ! -s ${_arg_output_dir}/dbm/intermediate/delin/affine/$(basename ${file} | extension_strip).mat ]]; then
    echo "ANTSUseDeformationFieldToGetAffineTransform ${_arg_output_dir}/final/transforms/$(basename ${file} | extension_strip)_1Warp.nii.gz \
      ${_arg_delin_affine_ratio} affine ${_arg_output_dir}/dbm/intermediate/delin/affine/$(basename ${file} | extension_strip).mat \
      ${_arg_mask}"
  fi
done >${_arg_output_dir}/jobs/${_datetime}/delin_affine_from_warp

debug "$(cat ${_arg_output_dir}/jobs/${_datetime}/delin_affine_from_warp)"
if [[ ${_arg_dry_run} == "off" ]]; then
  qbatch ${_arg_block} --logdir ${_arg_output_dir}/logs/${_datetime} \
    --walltime ${_arg_walltime} \
    -N ${_arg_jobname_prefix}dbm_${_datetime}_delin_affine_from_warp \
    --depend ${_arg_jobname_prefix}dbm_${_datetime}_delin_mask \
    ${_arg_output_dir}/jobs/${_datetime}/delin_affine_from_warp
fi

# Generate warp from delin affine
info "Generate composite warp field from delin affine"
for file in "${_arg_inputs[@]}"; do
  if [[ ! -s ${_arg_output_dir}/dbm/intermediate/delin/warp/$(basename ${file} | extension_strip).nii.gz ]]; then
    echo "antsApplyTransforms -d 3 --verbose ${_arg_float} \
      -r ${_arg_output_dir}/final/average/template_sharpen_shapeupdate.nii.gz \
      -t [ ${_arg_output_dir}/dbm/intermediate/delin/affine/$(basename ${file} | extension_strip).mat,1 ] \
      -o [ ${_arg_output_dir}/dbm/intermediate/delin/warp/$(basename ${file} | extension_strip).nii.gz,1 ]"
  fi
done >${_arg_output_dir}/jobs/${_datetime}/delin_warp_from_delin_affine

debug "$(cat ${_arg_output_dir}/jobs/${_datetime}/delin_warp_from_delin_affine)"
if [[ ${_arg_dry_run} == "off" ]]; then
  qbatch ${_arg_block} --logdir ${_arg_output_dir}/logs/${_datetime} \
    --walltime ${_arg_walltime} \
    -N ${_arg_jobname_prefix}dbm_${_datetime}_delin_warp_from_delin_affine \
    --depend ${_arg_jobname_prefix}dbm_${_datetime}_delin_affine_from_warp \
    ${_arg_output_dir}/jobs/${_datetime}/delin_warp_from_delin_affine
fi

# Generate jacobians from delin warp field
info "Computing Jacobians from delin affine warp fields"
for file in "${_arg_inputs[@]}"; do
  if [[ ! -s ${_arg_output_dir}/dbm/intermediate/delin/jacobian/$(basename ${file} | extension_strip).nii.gz ]]; then
    echo "CreateJacobianDeterminantImage 3 ${_arg_output_dir}/dbm/intermediate/delin/warp/$(basename ${file} | extension_strip).nii.gz \
      ${_arg_output_dir}/dbm/intermediate/delin/jacobian/$(basename ${file} | extension_strip).nii.gz ${_arg_log_jacobian} ${_arg_use_geometric}"
  fi
done >${_arg_output_dir}/jobs/${_datetime}/jacobian_from_delin_warp

debug "$(cat ${_arg_output_dir}/jobs/${_datetime}/jacobian_from_delin_warp)"
if [[ ${_arg_dry_run} == "off" ]]; then
  qbatch ${_arg_block} --logdir ${_arg_output_dir}/logs/${_datetime} \
    --walltime ${_arg_walltime} \
    -N ${_arg_jobname_prefix}dbm_${_datetime}_jacobian_from_delin_warp \
    --depend ${_arg_jobname_prefix}dbm_${_datetime}_delin_warp_from_delin_affine \
    ${_arg_output_dir}/jobs/${_datetime}/jacobian_from_delin_warp
fi

# Generate final full jacobians
info "Generating Full Jacobians"
for file in "${_arg_inputs[@]}"; do
  if [[ ! -s ${_arg_output_dir}/dbm/jacobian/full/$(basename ${file} | extension_strip).nii.gz ]]; then
    echo "ImageMath 3 \
      ${_arg_output_dir}/dbm/jacobian/full/$(basename ${file} | extension_strip).nii.gz \
      + ${_arg_output_dir}/dbm/intermediate/affine/jacobian/$(basename ${file} | extension_strip).nii.gz \
      ${_arg_output_dir}/dbm/intermediate/nlin/jacobian/$(basename ${file} | extension_strip).nii.gz"
  fi
done >${_arg_output_dir}/jobs/${_datetime}/gen_full_jacobian

debug "$(cat ${_arg_output_dir}/jobs/${_datetime}/gen_full_jacobian)"
if [[ ${_arg_dry_run} == "off" ]]; then
  qbatch ${_arg_block} --logdir ${_arg_output_dir}/logs/${_datetime} \
    --walltime ${_arg_walltime} \
    -N ${_arg_jobname_prefix}dbm_${_datetime}_gen_full_jacobian \
    --depend ${_arg_jobname_prefix}dbm_${_datetime}_affine_jacobian \
    --depend ${_arg_jobname_prefix}dbm_${_datetime}_nlin_jacobian \
    ${_arg_output_dir}/jobs/${_datetime}/gen_full_jacobian
fi

# Generate final relative jacobians
info "Generating Relative Jacobians"
for file in "${_arg_inputs[@]}"; do
  if [[ ! -s ${_arg_output_dir}/dbm/jacobian/relative/$(basename ${file} | extension_strip).nii.gz ]]; then
    echo "ImageMath 3 \
      ${_arg_output_dir}/dbm/jacobian/relative/$(basename ${file} | extension_strip).nii.gz \
      + ${_arg_output_dir}/dbm/intermediate/delin/jacobian/$(basename ${file} | extension_strip).nii.gz \
      ${_arg_output_dir}/dbm/intermediate/nlin/jacobian/$(basename ${file} | extension_strip).nii.gz"
  fi
done >${_arg_output_dir}/jobs/${_datetime}/gen_rel_jacobian

debug "$(cat ${_arg_output_dir}/jobs/${_datetime}/gen_rel_jacobian)"
if [[ ${_arg_dry_run} == "off" ]]; then
  qbatch ${_arg_block} --logdir ${_arg_output_dir}/logs/${_datetime} \
    --walltime ${_arg_walltime} \
    -N ${_arg_jobname_prefix}dbm_${_datetime}_gen_rel_jacobian \
    --depend ${_arg_jobname_prefix}dbm_${_datetime}_nlin_jacobian \
    --depend ${_arg_jobname_prefix}dbm_${_datetime}_jacobian_from_delin_warp \
    ${_arg_output_dir}/jobs/${_datetime}/gen_rel_jacobian
fi

# Smooth jacobians files
info "Smoothing Jacobians"
for file in "${_arg_inputs[@]}"; do
  for fwhm in "${_arg_jacobian_smooth[@]}"; do
    sigma_num=$(calc "$(echo ${fwhm} | grep -o -E '^[0-9]+')/(2*sqrt(2*log(2)))")
    if [[ ${fwhm} =~ [0-9]+mm$ ]]; then
      fwhm_type=1
    elif [[ ${fwhm} =~ [0-9]+vox$ ]]; then
      fwhm_type=0
    else
      failure "Parse error for FWHM entry \"${fwhm}\", must end with vox or mm"
    fi
    if [[ ! -s ${_arg_output_dir}/dbm/jacobian/full/smooth/$(basename ${file} | extension_strip)_fwhm_${fwhm}.nii.gz ]]; then
      echo SmoothImage 3 \
        ${_arg_output_dir}/dbm/jacobian/full/$(basename ${file} | extension_strip).nii.gz \
        ${sigma_num} \
        ${_arg_output_dir}/dbm/jacobian/full/smooth/$(basename ${file} | extension_strip)_fwhm_${fwhm}.nii.gz ${fwhm_type} 0
    fi
    if [[ ! -s ${_arg_output_dir}/dbm/jacobian/relative/smooth/$(basename ${file} | extension_strip)_fwhm_${fwhm}.nii.gz ]]; then
      echo SmoothImage 3 \
        ${_arg_output_dir}/dbm/jacobian/relative/$(basename ${file} | extension_strip).nii.gz \
        ${sigma_num} \
        ${_arg_output_dir}/dbm/jacobian/relative/smooth/$(basename ${file} | extension_strip)_fwhm_${fwhm}.nii.gz ${fwhm_type} 0
    fi
  done
done >${_arg_output_dir}/jobs/${_datetime}/smooth_jacobian

debug "$(cat ${_arg_output_dir}/jobs/${_datetime}/smooth_jacobian)"
if [[ ${_arg_dry_run} == "off" ]]; then
  qbatch ${_arg_block} --logdir ${_arg_output_dir}/logs/${_datetime} \
    --walltime ${_arg_walltime} \
    -N ${_arg_jobname_prefix}dbm_${_datetime}_smooth_jacobian \
    --depend ${_arg_jobname_prefix}dbm_${_datetime}_gen_full_jacobian \
    --depend ${_arg_jobname_prefix}dbm_${_datetime}_gen_rel_jacobian \
    ${_arg_output_dir}/jobs/${_datetime}/smooth_jacobian
fi


# ] <-- needed because of Argbash
