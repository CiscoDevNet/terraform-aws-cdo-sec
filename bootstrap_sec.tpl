#!/bin/bash

su sdc -c bash << 'EOF'
bootstrap_file=/tmp/bootstrap_data
sec_dir=/usr/local/cdo

echo "${cdo_bootstrap_data}" > $${bootstrap_file}
. <(base64 -d < $${bootstrap_file})
cd $${sec_dir}
curl -H "Authorization: Bearer $${CDO_TOKEN}" "$${CDO_BOOTSTRAP_URL}" -o $${sec_dir}/$${CDO_TENANT}.tar.gz
tar -zxvf $${CDO_TENANT}.tar.gz
/usr/local/cdo/bootstrap/bootstrap_sec_only.sh
/usr/local/cdo/toolkit/sec.sh setup ${sec_bootstrap_data}
EOF