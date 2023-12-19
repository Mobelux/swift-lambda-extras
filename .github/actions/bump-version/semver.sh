#!/usr/bin/env bash

# https://github.com/fsaintjacques/semver-tool
#
#                               Apache License
#                         Version 2.0, January 2004
#                      http:#www.apache.org/licenses/
#
# TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
#
# 1. Definitions.
#
#    "License" shall mean the terms and conditions for use, reproduction,
#    and distribution as defined by Sections 1 through 9 of this document.
#
#    "Licensor" shall mean the copyright owner or entity authorized by
#    the copyright owner that is granting the License.
#
#    "Legal Entity" shall mean the union of the acting entity and all
#    other entities that control, are controlled by, or are under common
#    control with that entity. For the purposes of this definition,
#    "control" means (i) the power, direct or indirect, to cause the
#    direction or management of such entity, whether by contract or
#    otherwise, or (ii) ownership of fifty percent (50%) or more of the
#    outstanding shares, or (iii) beneficial ownership of such entity.
#
#    "You" (or "Your") shall mean an individual or Legal Entity
#    exercising permissions granted by this License.
#
#    "Source" form shall mean the preferred form for making modifications,
#    including but not limited to software source code, documentation
#    source, and configuration files.
#
#    "Object" form shall mean any form resulting from mechanical
#    transformation or translation of a Source form, including but
#    not limited to compiled object code, generated documentation,
#    and conversions to other media types.
#
#    "Work" shall mean the work of authorship, whether in Source or
#    Object form, made available under the License, as indicated by a
#    copyright notice that is included in or attached to the work
#    (an example is provided in the Appendix below).
#
#    "Derivative Works" shall mean any work, whether in Source or Object
#    form, that is based on (or derived from) the Work and for which the
#    editorial revisions, annotations, elaborations, or other modifications
#    represent, as a whole, an original work of authorship. For the purposes
#    of this License, Derivative Works shall not include works that remain
#    separable from, or merely link (or bind by name) to the interfaces of,
#    the Work and Derivative Works thereof.
#
#    "Contribution" shall mean any work of authorship, including
#    the original version of the Work and any modifications or additions
#    to that Work or Derivative Works thereof, that is intentionally
#    submitted to Licensor for inclusion in the Work by the copyright owner
#    or by an individual or Legal Entity authorized to submit on behalf of
#    the copyright owner. For the purposes of this definition, "submitted"
#    means any form of electronic, verbal, or written communication sent
#    to the Licensor or its representatives, including but not limited to
#    communication on electronic mailing lists, source code control systems,
#    and issue tracking systems that are managed by, or on behalf of, the
#    Licensor for the purpose of discussing and improving the Work, but
#    excluding communication that is conspicuously marked or otherwise
#    designated in writing by the copyright owner as "Not a Contribution."
#
#    "Contributor" shall mean Licensor and any individual or Legal Entity
#    on behalf of whom a Contribution has been received by Licensor and
#    subsequently incorporated within the Work.
#
# 2. Grant of Copyright License. Subject to the terms and conditions of
#    this License, each Contributor hereby grants to You a perpetual,
#    worldwide, non-exclusive, no-charge, royalty-free, irrevocable
#    copyright license to reproduce, prepare Derivative Works of,
#    publicly display, publicly perform, sublicense, and distribute the
#    Work and such Derivative Works in Source or Object form.
#
# 3. Grant of Patent License. Subject to the terms and conditions of
#    this License, each Contributor hereby grants to You a perpetual,
#    worldwide, non-exclusive, no-charge, royalty-free, irrevocable
#    (except as stated in this section) patent license to make, have made,
#    use, offer to sell, sell, import, and otherwise transfer the Work,
#    where such license applies only to those patent claims licensable
#    by such Contributor that are necessarily infringed by their
#    Contribution(s) alone or by combination of their Contribution(s)
#    with the Work to which such Contribution(s) was submitted. If You
#    institute patent litigation against any entity (including a
#    cross-claim or counterclaim in a lawsuit) alleging that the Work
#    or a Contribution incorporated within the Work constitutes direct
#    or contributory patent infringement, then any patent licenses
#    granted to You under this License for that Work shall terminate
#    as of the date such litigation is filed.
#
# 4. Redistribution. You may reproduce and distribute copies of the
#    Work or Derivative Works thereof in any medium, with or without
#    modifications, and in Source or Object form, provided that You
#    meet the following conditions:
#
#    (a) You must give any other recipients of the Work or
#        Derivative Works a copy of this License; and
#
#    (b) You must cause any modified files to carry prominent notices
#        stating that You changed the files; and
#
#    (c) You must retain, in the Source form of any Derivative Works
#        that You distribute, all copyright, patent, trademark, and
#        attribution notices from the Source form of the Work,
#        excluding those notices that do not pertain to any part of
#        the Derivative Works; and
#
#    (d) If the Work includes a "NOTICE" text file as part of its
#        distribution, then any Derivative Works that You distribute must
#        include a readable copy of the attribution notices contained
#        within such NOTICE file, excluding those notices that do not
#        pertain to any part of the Derivative Works, in at least one
#        of the following places: within a NOTICE text file distributed
#        as part of the Derivative Works; within the Source form or
#        documentation, if provided along with the Derivative Works; or,
#        within a display generated by the Derivative Works, if and
#        wherever such third-party notices normally appear. The contents
#        of the NOTICE file are for informational purposes only and
#        do not modify the License. You may add Your own attribution
#        notices within Derivative Works that You distribute, alongside
#        or as an addendum to the NOTICE text from the Work, provided
#        that such additional attribution notices cannot be construed
#        as modifying the License.
#
#    You may add Your own copyright statement to Your modifications and
#    may provide additional or different license terms and conditions
#    for use, reproduction, or distribution of Your modifications, or
#    for any such Derivative Works as a whole, provided Your use,
#    reproduction, and distribution of the Work otherwise complies with
#    the conditions stated in this License.
#
# 5. Submission of Contributions. Unless You explicitly state otherwise,
#    any Contribution intentionally submitted for inclusion in the Work
#    by You to the Licensor shall be under the terms and conditions of
#    this License, without any additional terms or conditions.
#    Notwithstanding the above, nothing herein shall supersede or modify
#    the terms of any separate license agreement you may have executed
#    with Licensor regarding such Contributions.
#
# 6. Trademarks. This License does not grant permission to use the trade
#    names, trademarks, service marks, or product names of the Licensor,
#    except as required for reasonable and customary use in describing the
#    origin of the Work and reproducing the content of the NOTICE file.
#
# 7. Disclaimer of Warranty. Unless required by applicable law or
#    agreed to in writing, Licensor provides the Work (and each
#    Contributor provides its Contributions) on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
#    implied, including, without limitation, any warranties or conditions
#    of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
#    PARTICULAR PURPOSE. You are solely responsible for determining the
#    appropriateness of using or redistributing the Work and assume any
#    risks associated with Your exercise of permissions under this License.
#
# 8. Limitation of Liability. In no event and under no legal theory,
#    whether in tort (including negligence), contract, or otherwise,
#    unless required by applicable law (such as deliberate and grossly
#    negligent acts) or agreed to in writing, shall any Contributor be
#    liable to You for damages, including any direct, indirect, special,
#    incidental, or consequential damages of any character arising as a
#    result of this License or out of the use or inability to use the
#    Work (including but not limited to damages for loss of goodwill,
#    work stoppage, computer failure or malfunction, or any and all
#    other commercial damages or losses), even if such Contributor
#    has been advised of the possibility of such damages.
#
# 9. Accepting Warranty or Additional Liability. While redistributing
#    the Work or Derivative Works thereof, You may choose to offer,
#    and charge a fee for, acceptance of support, warranty, indemnity,
#    or other liability obligations and/or rights consistent with this
#    License. However, in accepting such obligations, You may act only
#    on Your own behalf and on Your sole responsibility, not on behalf
#    of any other Contributor, and only if You agree to indemnify,
#    defend, and hold each Contributor harmless for any liability
#    incurred by, or claims asserted against, such Contributor by reason
#    of your accepting any such warranty or additional liability.
#
# END OF TERMS AND CONDITIONS
#
# APPENDIX: How to apply the Apache License to your work.
#
#    To apply the Apache License to your work, attach the following
#    boilerplate notice, with the fields enclosed by brackets "[]"
#    replaced with your own identifying information. (Don't include
#    the brackets!)  The text should be enclosed in the appropriate
#    comment syntax for the file format. We also recommend that a
#    file or class name and description of purpose be included on the
#    same "printed page" as the copyright notice for easier
#    identification within third-party archives.
#
# Copyright [yyyy] [name of copyright owner]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit -o nounset -o pipefail

NAT='0|[1-9][0-9]*'
ALPHANUM='[0-9]*[A-Za-z-][0-9A-Za-z-]*'
IDENT="$NAT|$ALPHANUM"
FIELD='[0-9A-Za-z-]+'

SEMVER_REGEX="\
^[vV]?\
($NAT)\\.($NAT)\\.($NAT)\
(\\-(${IDENT})(\\.(${IDENT}))*)?\
(\\+${FIELD}(\\.${FIELD})*)?$"

PROG=semver
PROG_VERSION="3.3.0"

USAGE="\
Usage:
  $PROG bump (major|minor|patch|release|prerel [<prerel>]|build <build>) <version>
  $PROG compare <version> <other_version>
  $PROG diff <version> <other_version>
  $PROG get (major|minor|patch|release|prerel|build) <version>
  $PROG validate <version>
  $PROG --help
  $PROG --version

Arguments:
  <version>  A version must match the following regular expression:
             \"${SEMVER_REGEX}\"
             In English:
             -- The version must match X.Y.Z[-PRERELEASE][+BUILD]
                where X, Y and Z are non-negative integers.
             -- PRERELEASE is a dot separated sequence of non-negative integers and/or
                identifiers composed of alphanumeric characters and hyphens (with
                at least one non-digit). Numeric identifiers must not have leading
                zeros. A hyphen (\"-\") introduces this optional part.
             -- BUILD is a dot separated sequence of identifiers composed of alphanumeric
                characters and hyphens. A plus (\"+\") introduces this optional part.

  <other_version>  See <version> definition.

  <prerel>  A string as defined by PRERELEASE above. Or, it can be a PRERELEASE
            prototype string (or empty) followed by a dot.

  <build>   A string as defined by BUILD above.

Options:
  -v, --version          Print the version of this tool.
  -h, --help             Print this help message.

Commands:
  bump      Bump by one of major, minor, patch; zeroing or removing
            subsequent parts. \"bump prerel\" sets the PRERELEASE part and
            removes any BUILD part. A trailing dot in the <prerel> argument
            introduces an incrementing numeric field which is added or
            bumped. If no <prerel> argument is provided, an incrementing numeric
            field is introduced/bumped. \"bump build\" sets the BUILD part.
            \"bump release\" removes any PRERELEASE or BUILD parts.
            The bumped version is written to stdout.

  compare   Compare <version> with <other_version>, output to stdout the
            following values: -1 if <other_version> is newer, 0 if equal, 1 if
            older. The BUILD part is not used in comparisons.

  diff      Compare <version> with <other_version>, output to stdout the
            difference between two versions by the release type (MAJOR, MINOR,
            PATCH, PRERELEASE, BUILD).

  get       Extract given part of <version>, where part is one of major, minor,
            patch, prerel, build, or release.

  validate  Validate if <version> follows the SEMVER pattern (see <version>
            definition). Print 'valid' to stdout if the version is valid, otherwise
            print 'invalid'.

See also:
  https://semver.org -- Semantic Versioning 2.0.0"

function error {
  echo -e "$1" >&2
  exit 1
}

function usage_help {
  error "$USAGE"
}

function usage_version {
  echo -e "${PROG}: $PROG_VERSION"
  exit 0
}

function validate_version {
  local version=$1
  if [[ "$version" =~ $SEMVER_REGEX ]]; then
    # if a second argument is passed, store the result in var named by $2
    if [ "$#" -eq "2" ]; then
      local major=${BASH_REMATCH[1]}
      local minor=${BASH_REMATCH[2]}
      local patch=${BASH_REMATCH[3]}
      local prere=${BASH_REMATCH[4]}
      local build=${BASH_REMATCH[8]}
      eval "$2=(\"$major\" \"$minor\" \"$patch\" \"$prere\" \"$build\")"
    else
      echo "$version"
    fi
  else
    error "version $version does not match the semver scheme 'X.Y.Z(-PRERELEASE)(+BUILD)'. See help for more information."
  fi
}

function is_nat {
    [[ "$1" =~ ^($NAT)$ ]]
}

function is_null {
    [ -z "$1" ]
}

function order_nat {
    [ "$1" -lt "$2" ] && { echo -1 ; return ; }
    [ "$1" -gt "$2" ] && { echo 1 ; return ; }
    echo 0
}

function order_string {
    [[ $1 < $2 ]] && { echo -1 ; return ; }
    [[ $1 > $2 ]] && { echo 1 ; return ; }
    echo 0
}

# given two (named) arrays containing NAT and/or ALPHANUM fields, compare them
# one by one according to semver 2.0.0 spec. Return -1, 0, 1 if left array ($1)
# is less-than, equal, or greater-than the right array ($2).  The longer array
# is considered greater-than the shorter if the shorter is a prefix of the longer.
#
function compare_fields {
    local l="$1[@]"
    local r="$2[@]"
    local leftfield=( "${!l}" )
    local rightfield=( "${!r}" )
    local left
    local right

    local i=$(( -1 ))
    local order=$(( 0 ))

    while true
    do
        [ $order -ne 0 ] && { echo $order ; return ; }

        : $(( i++ ))
        left="${leftfield[$i]}"
        right="${rightfield[$i]}"

        is_null "$left" && is_null "$right" && { echo 0  ; return ; }
        is_null "$left"                     && { echo -1 ; return ; }
                           is_null "$right" && { echo 1  ; return ; }

        is_nat "$left" &&  is_nat "$right" && { order=$(order_nat "$left" "$right") ; continue ; }
        is_nat "$left"                     && { echo -1 ; return ; }
                           is_nat "$right" && { echo 1  ; return ; }
                                              { order=$(order_string "$left" "$right") ; continue ; }
    done
}

# shellcheck disable=SC2206     # checked by "validate"; ok to expand prerel id's into array
function compare_version {
  local order
  validate_version "$1" V
  validate_version "$2" V_

  # compare major, minor, patch

  local left=( "${V[0]}" "${V[1]}" "${V[2]}" )
  local right=( "${V_[0]}" "${V_[1]}" "${V_[2]}" )

  order=$(compare_fields left right)
  [ "$order" -ne 0 ] && { echo "$order" ; return ; }

  # compare pre-release ids when M.m.p are equal

  local prerel="${V[3]:1}"
  local prerel_="${V_[3]:1}"
  local left=( ${prerel//./ } )
  local right=( ${prerel_//./ } )

  # if left and right have no pre-release part, then left equals right
  # if only one of left/right has pre-release part, that one is less than simple M.m.p

  [ -z "$prerel" ] && [ -z "$prerel_" ] && { echo 0  ; return ; }
  [ -z "$prerel" ]                      && { echo 1  ; return ; }
                      [ -z "$prerel_" ] && { echo -1 ; return ; }

  # otherwise, compare the pre-release id's

  compare_fields left right
}

# render_prerel -- return a prerel field with a trailing numeric string
#                  usage: render_prerel numeric [prefix-string]
#
function render_prerel {
    if [ -z "$2" ]
    then
        echo "${1}"
    else
        echo "${2}${1}"
    fi
}

# extract_prerel -- extract prefix and trailing numeric portions of a pre-release part
#                   usage: extract_prerel prerel prerel_parts
#                   The prefix and trailing numeric parts are returned in "prerel_parts".
#
PREFIX_ALPHANUM='[.0-9A-Za-z-]*[.A-Za-z-]'
DIGITS='[0-9][0-9]*'
EXTRACT_REGEX="^(${PREFIX_ALPHANUM})*(${DIGITS})$"

function extract_prerel {
    local prefix; local numeric;

    if [[ "$1" =~ $EXTRACT_REGEX ]]
    then                                        # found prefix and trailing numeric parts
        prefix="${BASH_REMATCH[1]}"
        numeric="${BASH_REMATCH[2]}"
    else                                        # no numeric part
        prefix="${1}"
        numeric=
    fi

    eval "$2=(\"$prefix\" \"$numeric\")"
}

# bump_prerel -- return the new pre-release part based on previous pre-release part
#                and prototype for bump
#                usage: bump_prerel proto previous
#
function bump_prerel {
    local proto; local prev_prefix; local prev_numeric;

    # case one: no trailing dot in prototype => simply replace previous with proto
    if [[ ! ( "$1" =~ \.$ ) ]]
    then
        echo "$1"
        return
    fi

    proto="${1%.}"                              # discard trailing dot marker from prototype

    extract_prerel "${2#-}" prerel_parts        # extract parts of previous pre-release
#   shellcheck disable=SC2154
    prev_prefix="${prerel_parts[0]}"
    prev_numeric="${prerel_parts[1]}"

    # case two: bump or append numeric to previous pre-release part
    if [ "$proto" == "+" ]                      # dummy "+" indicates no prototype argument provided
    then
        if [ -n "$prev_numeric" ]
        then
            : $(( ++prev_numeric ))             # previous pre-release is already numbered, bump it
            render_prerel "$prev_numeric" "$prev_prefix"
        else
            render_prerel 1 "$prev_prefix"      # append starting number
        fi
        return
    fi

    # case three: set, bump, or append using prototype prefix
    if [  "$prev_prefix" != "$proto" ]
    then
        render_prerel 1 "$proto"                # proto not same pre-release; set and start at '1'
    elif [ -n "$prev_numeric" ]
    then
        : $(( ++prev_numeric ))                 # pre-release is numbered; bump it
        render_prerel "$prev_numeric" "$prev_prefix"
    else
        render_prerel 1 "$prev_prefix"          # start pre-release at number '1'
    fi
}

function command_bump {
  local new; local version; local sub_version; local command;

  case $# in
    2) case $1 in
        major|minor|patch|prerel|release) command=$1; sub_version="+."; version=$2;;
        *) usage_help;;
       esac ;;
    3) case $1 in
        prerel|build) command=$1; sub_version=$2 version=$3 ;;
        *) usage_help;;
       esac ;;
    *) usage_help;;
  esac

  validate_version "$version" parts
  # shellcheck disable=SC2154
  local major="${parts[0]}"
  local minor="${parts[1]}"
  local patch="${parts[2]}"
  local prere="${parts[3]}"
  local build="${parts[4]}"

  case "$command" in
    major) new="$((major + 1)).0.0";;
    minor) new="${major}.$((minor + 1)).0";;
    patch) new="${major}.${minor}.$((patch + 1))";;
    release) new="${major}.${minor}.${patch}";;
    prerel) new=$(validate_version "${major}.${minor}.${patch}-$(bump_prerel "$sub_version" "$prere")");;
    build) new=$(validate_version "${major}.${minor}.${patch}${prere}+${sub_version}");;
    *) usage_help ;;
  esac

  echo "$new"
  exit 0
}

function command_compare {
  local v; local v_;

  case $# in
    2) v=$(validate_version "$1"); v_=$(validate_version "$2") ;;
    *) usage_help ;;
  esac

  set +u                        # need unset array element to evaluate to null
  compare_version "$v" "$v_"
  exit 0
}

function command_diff {
  validate_version "$1" v1_parts
  # shellcheck disable=SC2154
  local v1_major="${v1_parts[0]}"
  local v1_minor="${v1_parts[1]}"
  local v1_patch="${v1_parts[2]}"
  local v1_prere="${v1_parts[3]}"
  local v1_build="${v1_parts[4]}"

  validate_version "$2" v2_parts
  # shellcheck disable=SC2154
  local v2_major="${v2_parts[0]}"
  local v2_minor="${v2_parts[1]}"
  local v2_patch="${v2_parts[2]}"
  local v2_prere="${v2_parts[3]}"
  local v2_build="${v2_parts[4]}"

  if [ "${v1_major}" != "${v2_major}" ]; then
    echo "major"
  elif [ "${v1_minor}" != "${v2_minor}" ]; then
    echo "minor"
  elif [ "${v1_patch}" != "${v2_patch}" ]; then
    echo "patch"
  elif [ "${v1_prere}" != "${v2_prere}" ]; then
    echo "prerelease"
  elif [ "${v1_build}" != "${v2_build}" ]; then
    echo "build"
  fi
}

# shellcheck disable=SC2034
function command_get {
    local part version

    if [[ "$#" -ne "2" ]] || [[ -z "$1" ]] || [[ -z "$2" ]]; then
        usage_help
        exit 0
    fi

    part="$1"
    version="$2"

    validate_version "$version" parts
    local major="${parts[0]}"
    local minor="${parts[1]}"
    local patch="${parts[2]}"
    local prerel="${parts[3]:1}"
    local build="${parts[4]:1}"
    local release="${major}.${minor}.${patch}"

    case "$part" in
        major|minor|patch|release|prerel|build) echo "${!part}" ;;
        *) usage_help ;;
    esac

    exit 0
}

function command_validate {
  if [[ "$#" -ne "1" ]]; then
        usage_help
  fi  
  
  if [[ "$1" =~ $SEMVER_REGEX ]]; then
    echo "valid"
  else
    echo "invalid"
  fi

  exit 0
}

case $# in
  0) echo "Unknown command: $*"; usage_help;;
esac

case $1 in
  --help|-h) echo -e "$USAGE"; exit 0;;
  --version|-v) usage_version ;;
  bump) shift; command_bump "$@";;
  get) shift; command_get "$@";;
  compare) shift; command_compare "$@";;
  diff) shift; command_diff "$@";;
  validate) shift; command_validate "$@";;
  *) echo "Unknown arguments: $*"; usage_help;;
esac