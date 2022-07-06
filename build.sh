#!/bin/bash

[ ! "${EUID}" = "0" ] && {
  echo "Execute esse script como root:"
  echo
  echo "  sudo ${0}"
  echo
  exit 1
}

HERE="$(dirname "$(readlink -f "${0}")")"

working_dir=$(mktemp -d)

mkdir -p "${working_dir}/usr/lib/tiger-os/"
mkdir -p "${working_dir}/DEBIAN/"

cp -v "${HERE}/config" "${HERE}/tiger-osd.sh"        "${working_dir}/usr/lib/tiger-os/"

(
 echo "Package: tiger-shell-osd"
 echo "Priority: optional"
 echo "Version: $(date +%y.%m.%d%H%M%S)"
 echo "Architecture: all"
 echo "Maintainer: Natanael Barbosa Santos"
 echo "Depends: "
 echo "Description: Telas padronizadas para o Tiger OS"
 echo
) > "${working_dir}/DEBIAN/control"

dpkg -b ${working_dir}
rm -rfv ${working_dir}

mv "${working_dir}.deb" "${HERE}/tiger-shell-osd.deb"

chmod 777 "${HERE}/tiger-shell-osd.deb"
chmod -x  "${HERE}/tiger-shell-osd.deb"
