#!/usr/bin/env bash

function input() {
   local undecorated="--undecorated"
   [ "${TIGER_DIALOG_SHOW_TITLE}" = "1" ] && undecorated=""

   local field="--field=:ldl"
   [ ! -z "${4}" ] && field="--field=:${4}"

   local window_icon="dialog-messages"
   [ ! -z "${5}" ] && window_icon="${5}"

   yad --center --borders=32 --width=400 --window-icon="${window_icon}" --title="${TIGER_DIALOG_TITLE}" ${undecorated} --fixed \
       --text="<big><b>${1}</b></big>\n${2}\n" --form ${field} --field=" ":lbl --separator="" --image-on-top                   \
       --button=gtk-ok:0 --button=gtk-cancel:1

   return ${?}
}

function message() {
   local undecorated="--undecorated"
   [ "${TIGER_DIALOG_SHOW_TITLE}" = "1" ] && undecorated=""

   local autoclose="--close-on-unfocus"
   [ "${TIGER_DIALOG_AUTOCLOSE}" = "0" ] && autoclose=""

   local icon=""
   [ ! -z "${3}" ] && icon="--image=${3}"

   local window_icon="--window-icon=dialog-messages"
   [ ! -z "${3}" ] && window_icon="--window-icon=${3}"

   local buttons="--button=gtk-ok:0"
   [ "${4}" = "yes-no"    ] && buttons="--button=gtk-yes:1 --button=gtk-no:0"
   [ "${4}" = "no-yes"    ] && buttons="--button=gtk-no:0 --button=gtk-yes:1"
   [ "${4}" = "cancel-ok" ] && buttons=""
   [ "${4}" = "close"     ] && buttons="--button=gtk-close:0 "
   [ "${4}" = "ok"        ] && buttons="--button=gtk-ok:0 "
   [ "${4}" = "cancel"    ] && buttons="--button=gtk-cancel:0 "
   [ "${4}" = "none"      ] && {
     buttons="--no-buttons"
     [ ! "${TIGER_DIALOG_SHOW_TITLE}" = "1" ] && {
       autoclose="--close-on-unfocus"
     }
   }

   yad --center --borders=32 --width=400 "${window_icon}" --title="${TIGER_DIALOG_TITLE}" ${undecorated} --fixed "${icon}" ${autoclose} \
       --text="<big><b>${1}</b></big>\n${2}" --form ${field} --field=" ":lbl --separator="" ${buttons} --image-on-top

   return ${?}
}

function display-text() {
   local undecorated="--undecorated"
   [ "${TIGER_DIALOG_SHOW_TITLE}" = "1" ] && undecorated=""

   local autoclose="--close-on-unfocus"
   [ "${TIGER_DIALOG_AUTOCLOSE}" = "0" ] && autoclose=""

   local window_icon="--window-icon=text-x-generic"
   [ ! -z "${4}" ] && window_icon="--window-icon=${4}"

   local buttons="--button=gtk-ok:0"
   [ "${4}" = "yes-no"    ] && buttons="--button=gtk-yes:1 --button=gtk-no:0"
   [ "${4}" = "no-yes"    ] && buttons="--button=gtk-no:0 --button=gtk-yes:1"
   [ "${4}" = "cancel-ok" ] && buttons=""
   [ "${4}" = "close"     ] && buttons="--button=gtk-close:0 "
   [ "${4}" = "ok"        ] && buttons="--button=gtk-ok:0 "
   [ "${4}" = "cancel"    ] && buttons="--button=gtk-cancel:0 "
   [ "${3}" = "none"      ] && {
     buttons="--no-buttons"
     [ ! "${TIGER_DIALOG_SHOW_TITLE}" = "1" ] && {
       autoclose="--close-on-unfocus"
     }
   }

   sed '1s/.*/\n&/' "${3}" | \
      yad --center --borders=32 --width=800 --height=480 "${window_icon}" --title="${TIGER_DIALOG_TITLE}" ${undecorated}  \
          --text="<big><b>${1}</b></big>\n${2}" --fixed "${icon}" ${autoclose} --margins=32 --wrap ${buttons} --listen    \
          --text-info --image-on-top

   return ${?};
}

function undefined-progress() {
   while read -t 1 -r data; do echo "$data"; done | \
     yad --center --borders=32 --width=480 --undecorated --no-buttons --auto-close \
          --text="${1}" --progress --pulsate --progress-text=""
}

function progress() {
   while read -t 1 -r data; do echo "$data"; done | \
     yad --center --borders=32 --width=480 --undecorated --no-buttons --auto-close \
          --text="${1}" --progress --progress-text=""
}

# -----------------------------------------------------------------------------------------------------

function password()          { input "${1}" "${2}" "${3}" "H" "dialog-password" ; return ${?}; }
function directory-picker()  { input "${1}" "${2}" "${3}" "DIR" "file-manager"  ; return ${?}; }
function file-picker()       { input "${1}" "${2}" "${3}" "FL" "file-manager"   ; return ${?}; }
function multi-file-picker() { input "${1}" "${2}" "${3}" "MFL" "file-manager"  ; return ${?}; }

# -----------------------------------------------------------------------------------------------------

function show-message()      { message "${1}" "${2}" ""                "ok"     ; return ${?}; }
function show-warning()      { message "${1}" "${2}" "dialog-warning"  "ok"     ; return ${?}; }
function show-error()        { message "${1}" "${2}" "dialog-error"    "close"  ; exit   ${?}; }
function ask()               { message "${1}" "${2}" "dialog-question" "no-yes" ; return ${?}; }

# -----------------------------------------------------------------------------------------------------
