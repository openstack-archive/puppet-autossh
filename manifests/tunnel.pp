# Copyright 2015 Hewlett-Packard Development Company, L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# == Define: autossh::tunnel
#
# A define to add an autossh tunnel
define autossh::tunnel (
  $ensure              = running,
  $user,
  $ssh_port            = '22',
  $ssh_host,
  $ssh_user,
  $ssh_key,
  $ssh_args,
  $monitoring_port     = 0,
  $run_in_background   = True,
) {
    service { '/usr/lib/autossh':
      ensure => $ensure,
      start => template('autossh/autossh-command.erb'),
      stop  => 'AUTOSSH_PID=`pidof autossh` && CHILD_PID=`pgrep -P $AUTOSSH_PID` && kill -9 $AUTOSSH_PID && kill -9 $CHILD_PID',
      provider => base,
    }
}
